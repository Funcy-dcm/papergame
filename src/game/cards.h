#ifndef CARDS_H
#define CARDS_H

#include <QObject>

#include "settings.h"

class Cards : public QObject
{
  Q_OBJECT
public:
  explicit Cards(QObject *parent = nullptr);

  Q_INVOKABLE bool getExpertMode() const;
  Q_INVOKABLE void setExpertMode(bool mode);

  Q_INVOKABLE void newGame();
  Q_INVOKABLE void randomCards();
  Q_INVOKABLE void flipOverCards();
  Q_INVOKABLE void returnCards();
  Q_INVOKABLE void randomTargets();
  Q_INVOKABLE void flipOverTargets(int num);

signals:
  void setImageCardTop(int num, const QString &path);
  void setImageCardBottom(int num, const QString &path);
  void setImageTarget(int num, const QString &path);

private:
  bool m_expertMode;
  QList<quint32> m_cardsArray;
  QList<quint32> m_targetsArray;
  int m_cardCount;
  const int m_cardsMax;
  const int m_targetsMax;
  QList<bool> isTargetTop;

};

#endif // CARDS_H
