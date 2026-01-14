#pragma once

#include <QObject>

class CalculatorBackend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString displayText READ displayText NOTIFY displayTextChanged)

public:
    explicit CalculatorBackend(QObject *parent = nullptr);

    QString displayText() const;

    Q_INVOKABLE void appendChar(const QString &text);
    Q_INVOKABLE void backspace();
    Q_INVOKABLE void clearAll();
    Q_INVOKABLE void toggleSign();
    Q_INVOKABLE void evaluateExpression();

signals:
    void displayTextChanged();

private:
    QString m_displayText;
};