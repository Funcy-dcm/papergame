/****************************************************************************
**
** PaperGame is a open-source cross-platform board game
** Copyright (C) 2020 Shilyaev Egor <egor.shilyaev@gmail.com>
**
** This program is free software: you can redistribute it and/or modify
** it under the terms of the GNU General Public License as published by
** the Free Software Foundation, either version 3 of the License, or
** (at your option) any later version.
**
** This program is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
**
** You should have received a copy of the GNU General Public License
** along with this program.  If not, see <https://www.gnu.org/licenses/>.
**
****************************************************************************/
#include "application.h"

#include <QIcon>
#include <QDir>
#include <QFile>
#include <QLibraryInfo>
#include <QQmlFileSelector>
#include <QQmlContext>
#include <QQuickStyle>
#include <QQuickWindow>
#include <QStandardPaths>
#include <QTranslator>

Application::Application(int &argc, char **argv) :
  QtSingleApplication(argc, argv),
  m_isPortable(false),
  m_isPortableAppsCom(false),
  m_isClosing(false),
  m_dirPathInitialized(false),
  m_writeDebugMsgLog(false),
  m_qtTranslator(0),
  m_appTranslator(0)
{
  QString message = arguments().value(1);
  if (isRunning()) {
    if (argc == 1) {
      sendMessage("--show");
    } else {
      for (int i = 2; i < argc; ++i)
        message += '\n' + arguments().value(i);
      sendMessage(message);
    }
    setClosing();
    return;
  }

  setApplicationName("PaperGame");
  setOrganizationName("PaperGame");
  setOrganizationDomain("funcydcm.org");
  setApplicationVersion(APP_VERSION);
  setWindowIcon(QIcon(":/images/papergame.png"));
  setQuitOnLastWindowClosed(false);

  checkPortable();
  initDirPaths();
  initSettings();

  qWarning() << "Run application";

  loadTranslation();
  initQmlFileSelector();

  QQuickStyle::setStyle("Material");
  QQuickWindow::setTextRenderType(QQuickWindow::NativeTextRendering);
  m_qmlEngine.rootContext()->setContextProperty("mainApp", this);
  m_qmlEngine.load(QUrl(QStringLiteral("qrc:/qml/MainWindow.qml")));

#ifdef SHOW_GAME
  emit showMainWindow();
#endif

  receiveMessage(message);
  connect(this, &Application::messageReceived, this, &Application::receiveMessage);
  connect(this, &Application::commitDataRequest, this, &Application::commitData);
  connect(this, &Application::saveStateRequest, this, &Application::saveState);
}

Application::~Application()
{

}

Application *Application::getInstance()
{
  return static_cast<Application *>(QCoreApplication::instance());
}

void Application::quitApp()
{
  if (isClosing())
    return;

  setClosing();
  emit showClosingWindow();
  processEvents();
  //    saveSettings();

  qWarning() << "End application";
  quit();
}

void Application::commitData(QSessionManager &manager)
{
  qWarning() << "commitData";
  manager.setRestartHint(QSessionManager::RestartNever);
  manager.release();
  quitApp();
}

void Application::saveState(QSessionManager &manager)
{
  qWarning() << "saveState";
  manager.setRestartHint(QSessionManager::RestartNever);
  manager.release();
}

void Application::receiveMessage(const QString &message)
{
  if (!message.isEmpty()) {
    qWarning() << QString("Received message: %1").arg(message);

    QStringList params = message.split('\n');
    foreach (QString param, params) {
      if (param == "--show") {
        if (isClosing())
          return;
        emit showMainWindow();
      }
      if (param == "--exit")
        quitApp();
    }
  }
}

void Application::checkPortable()
{
#if defined(Q_OS_WIN)
  m_isPortable = true;
  QString fileName(QCoreApplication::applicationDirPath() + "/portable.dat");
  if (!QFile::exists(fileName)) {
    m_isPortable = false;
  }
#endif
}

void Application::initDirPaths()
{
#if defined(Q_OS_WIN) || defined(Q_OS_OS2)
  m_resourcesDirPath = QCoreApplication::applicationDirPath();
#else
#if defined(Q_OS_MAC)
  m_resourcesDirPath = QCoreApplication::applicationDirPath() + "/../Resources";
#elif defined(Q_OS_ANDROID)
  m_resourcesDirPath = ":";
#else
  m_resourcesDirPath = RESOURCES_DIR;
#endif
#endif

  if (isPortable()) {
    m_dataDirPath = QCoreApplication::applicationDirPath() + "/data";
    m_cacheDirPath = m_dataDirPath + "/cache";
  } else {
    m_dataDirPath = QStandardPaths::writableLocation(QStandardPaths::DataLocation);
    m_cacheDirPath = QStandardPaths::writableLocation(QStandardPaths::CacheLocation);
  }
  QDir dir(m_dataDirPath);
  dir.mkpath(m_dataDirPath);

  m_dirPathInitialized = true;
}

QString Application::defaultSoundNotifyFile() const
{
  return m_resourcesDirPath + "/sound/notification.wav";
}

void Application::initSettings()
{
  QString fileName;
  if (isPortable())
    fileName = dataDirPath() + "/" + QCoreApplication::applicationName() + ".ini";
  Settings::createSettings(fileName);

  Settings settings;
  m_writeDebugMsgLog = settings.value("WriteDebugMsgLog", false).toBool();
  m_language = settings.value("Language", getDefaultLanguage()).toString();
}

void Application::loadTranslation()
{
  if (!m_appTranslator)
    m_appTranslator = new QTranslator(this);
  removeTranslator(m_appTranslator);
  m_appTranslator->load("papergame_" + m_language, resourcesDirPath() + "/translations");
  installTranslator(m_appTranslator);

  if (!m_qtTranslator)
    m_qtTranslator = new QTranslator(this);
  removeTranslator(m_qtTranslator);
  m_qtTranslator->load("qt_" + m_language,
                       QLibraryInfo::location(QLibraryInfo::TranslationsPath));
  if (m_qtTranslator->isEmpty())
    m_qtTranslator->load("qt_" + m_language, resourcesDirPath() + "/translations");
  installTranslator(m_qtTranslator);
}

QString Application::getDefaultLanguage()
{
  QString language;
  QString localLanguage = QLocale::system().name();
  bool isFindLanguage = false;
  QDir translationsDir(resourcesDirPath() + "/translations");
  foreach (QString file, translationsDir.entryList(QStringList("*.qm"), QDir::Files)) {
    language = file.section('.', 0, 0).section('_', 1);
    if (localLanguage == language) {
      language = localLanguage;
      isFindLanguage = true;
      break;
    }
  }
  if (!isFindLanguage) {
    localLanguage = localLanguage.left(2);
    foreach (QString file, translationsDir.entryList(QStringList("*.qm"), QDir::Files)) {
      language = file.section('.', 0, 0).section('_', 1);
      if (localLanguage.contains(language, Qt::CaseInsensitive)) {
        language = localLanguage;
        isFindLanguage = true;
        break;
      }
    }
  }
  if (!isFindLanguage)
    language = "en";
  return language;
}

void Application::setLanguage(const QString &language)
{
  m_language = language;
  Settings settings;
  settings.setValue("Language", m_language);
  loadTranslation();
  emit languageChanged();
}

void Application::initQmlFileSelector()
{
  QQmlFileSelector *qfs = new QQmlFileSelector(&m_qmlEngine, &m_qmlEngine);
  QStringList selectors;

  qfs->setExtraSelectors(selectors);
}

bool Application::getExpertMode()
{
  Settings settings;
  return settings.value("ExpertMode", false).toBool();
}

void Application::setExpertMode(bool mode)
{
  Settings settings;
  settings.setValue("ExpertMode", mode);
}
