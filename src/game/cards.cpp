#include "cards.h"
#include <QRandomGenerator>
#include <QDebug>

Cards::Cards(QObject *parent)
  : QObject(parent)
  , m_cardCount(0)
  , m_cardsMax(81)
  , m_targetsMax(6)
{
  Settings settings;
  m_expertMode = settings.value("ExpertMode", false).toBool();

  for (int i = 0; i < 3; ++i) {
    isTargetTop.append(true);
  }
}

bool Cards::getExpertMode() const
{
  return m_expertMode;
}

void Cards::setExpertMode(bool mode)
{
  m_expertMode = mode;
  Settings settings;
  settings.setValue("ExpertMode", m_expertMode);
}

void Cards::newGame()
{
  randomTargets();
  randomCards();
}

void Cards::randomCards()
{
  m_cardCount = 0;
  m_cardsArray.clear();

  while (m_cardsArray.size() < m_cardsMax) {
    quint32 randomNumber = QRandomGenerator::global()->bounded(1, m_cardsMax+1);
    if (m_cardsArray.contains(randomNumber))
      continue;

    m_cardsArray.append(randomNumber);
  }

  for (int i = 0; i < 3; ++i) {
    qDebug() << "cardBottom" << i << ":" << m_cardsArray[m_cardCount];
    emit setImageCardBottom(i, QString("qrc:///images/cards/cardBottom%1.png").arg(m_cardsArray[m_cardCount]));
    m_cardCount++;
  }
  for (int i = 0; i < 3; ++i) {
    qDebug() << "cardTop" << i << ":" << m_cardsArray[m_cardCount];
    emit setImageCardTop(i, QString("qrc:///images/cards/cardTop%1.png").arg(m_cardsArray[m_cardCount]));
    m_cardCount++;
  }
}

void Cards::flipOverCards()
{
  if (m_cardCount >= m_cardsArray.size()) {
    qDebug() << "randomCards";
    randomCards();
  } else {
    for (int i = 0; i < 3; i++) {
      qDebug() << "cardBottom" << i << ":" << m_cardsArray[m_cardCount-3+i];
      emit setImageCardBottom(i, QString("qrc:///images/cards/cardBottom%1.png").arg(m_cardsArray[m_cardCount-3+i]), false);
    }
    for (int i = 0; i < 3; i++) {
      qDebug() << "cardTop" << i << ":" << m_cardsArray[m_cardCount];
      emit setImageCardTop(i, QString("qrc:///images/cards/cardTop%1.png").arg(m_cardsArray[m_cardCount]), true);
      m_cardCount++;
    }
  }
}

void Cards::returnCards()
{
  if (m_cardCount < 9)
    return;

  for (int i = 0; i < 3; i++) {
    qDebug() << "cardBottom" << i << ":" << m_cardsArray[m_cardCount-9+i];
    emit setImageCardBottom(i, QString("qrc:///images/cards/cardBottom%1.png").arg(m_cardsArray[m_cardCount-9+i]), true);
  }
  for (int i = 0; i < 3; i++) {
    qDebug() << "cardTop" << i << ":" << m_cardsArray[m_cardCount-6+i];
    emit setImageCardTop(i, QString("qrc:///images/cards/cardTop%1.png").arg(m_cardsArray[m_cardCount-6+i]), false);
  }
  m_cardCount = m_cardCount - 3;
}

void Cards::randomTargets()
{
  m_targetsArray.clear();

  if (m_expertMode) {
    int ext = 5;
    int max = m_targetsMax + ext;

    int randomNumber = QRandomGenerator::global()->bounded(1, max+1);
    int start = 0;
    if (randomNumber > ext)
      start = 5;
    m_targetsArray.append(start + randomNumber);
    qDebug() << "target 0: " << m_targetsArray[0] << randomNumber;
    emit setImageTarget(0, QString("qrc:///images/targets/targetTop%1.png").arg(m_targetsArray[0]),
        QString("qrc:///images/targets/targetBottom%1.png").arg(m_targetsArray[0]));

    randomNumber = QRandomGenerator::global()->bounded(1, max+1);
    start = 5;
    if (randomNumber > ext)
      start = 11;
    m_targetsArray.append(start + randomNumber);
    qDebug() << "target 1: " << m_targetsArray[1] << randomNumber;
    emit setImageTarget(1, QString("qrc:///images/targets/targetTop%1.png").arg(m_targetsArray[1]),
        QString("qrc:///images/targets/targetBottom%1.png").arg(m_targetsArray[1]));

    max = m_targetsMax;
    randomNumber = QRandomGenerator::global()->bounded(1, max+1);
    start = 22;
    m_targetsArray.append(start + randomNumber);
    qDebug() << "target 2: " << m_targetsArray[2] << randomNumber;
    emit setImageTarget(2, QString("qrc:///images/targets/targetTop%1.png").arg(m_targetsArray[2]),
        QString("qrc:///images/targets/targetBottom%1.png").arg(m_targetsArray[2]));
  } else {
    for (int i = 0; i < 3; i++) {
      int randomNumber = QRandomGenerator::global()->bounded(1, m_targetsMax+1);
      m_targetsArray.append(10 + i*m_targetsMax + randomNumber);
      qDebug() << "target" << i << ":" << m_targetsArray[i] << randomNumber;
      emit setImageTarget(i, QString("qrc:///images/targets/targetTop%1.png").arg(m_targetsArray[i]),
                          QString("qrc:///images/targets/targetBottom%1.png").arg(m_targetsArray[i]));
    }
  }
}
