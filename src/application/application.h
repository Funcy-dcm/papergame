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
#ifndef APPLICATION_H
#define APPLICATION_H

#include <QDebug>
#include <QQmlApplicationEngine>
#include <QSessionManager>
#include <qtsingleapplication.h>

#include "common.h"
#include "settings.h"

#define mainApp Application::getInstance()

class Application : public QtSingleApplication
{
    Q_OBJECT
public:
    explicit Application(int &argc, char **argv);
    ~Application();

    static Application *getInstance();

    Q_INVOKABLE QString version() const { return APP_VERSION; }
    Q_INVOKABLE QString reversion() const { return APP_REVISION; }
    Q_INVOKABLE QString releaseDate() const { return APP_DATE; }

    bool isClosing() const { return m_isClosing; }
    void setClosing() { m_isClosing = true; }
    bool isPortable() const { return m_isPortable; }
    bool isPortableAppsCom() const { return m_isPortableAppsCom; }
    bool dirPathInitialized() const { return m_dirPathInitialized; }
    QString resourcesDirPath() const { return m_resourcesDirPath; }
    Q_INVOKABLE QString dataDirPath() const { return m_dataDirPath; }
    QString cacheDirPath() const { return m_cacheDirPath; }
    QString defaultSoundNotifyFile() const;
    bool canWriteDebugMsgLog() const { return m_writeDebugMsgLog; }
    QQmlApplicationEngine *qmlEngine() { return &m_qmlEngine; }
    Q_INVOKABLE void setLanguage(const QString &language);
    Q_INVOKABLE QString getLanguage() { return m_language; }
    Q_INVOKABLE bool getExpertMode();
    Q_INVOKABLE void setExpertMode(bool mode);

signals:
    void showMainWindow();
    void closeMainWindow();
    void showClosingWindow();
    void languageChanged();

public slots:
    void quitApp();
    void receiveMessage(const QString &message);

private slots:
    void commitData(QSessionManager &manager);
    void saveState(QSessionManager &manager);

private:
    void checkPortable();
    void initDirPaths();
    void initSettings();
    void loadTranslation();
    QString getDefaultLanguage();
    void initQmlFileSelector();

    bool m_isPortable;
    bool m_isPortableAppsCom;
    bool m_isClosing;
    bool m_dirPathInitialized;

    QString m_resourcesDirPath;
    QString m_dataDirPath;
    QString m_cacheDirPath;

    bool m_writeDebugMsgLog;
    bool m_storeDBMemory;
    bool m_dbFileExists;
    bool m_isSaveDataLastFeed;
    bool m_updateFeedsStartUp;

    QQmlApplicationEngine m_qmlEngine;
    QTranslator *m_qtTranslator;
    QTranslator *m_appTranslator;
    QString m_language;

};

#endif // APPLICATION_H
