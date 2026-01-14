#include <QRegularExpression>
#include <QJSEngine>
#include <QJSValue>

#include "calculator_backend.h"

CalculatorBackend::CalculatorBackend(QObject *parent)
    : QObject(parent),
      m_displayText("0")
{
}

QString CalculatorBackend::displayText() const
{
    return m_displayText;
}

void CalculatorBackend::appendChar(const QString &text)
{
    if (m_displayText == "0")
        m_displayText = text;
    else
        m_displayText += text;

    emit displayTextChanged();
}

void CalculatorBackend::backspace()
{
    if (m_displayText.length() > 1)
        m_displayText.chop(1);
    else
        m_displayText = "0";

    emit displayTextChanged();
}

void CalculatorBackend::clearAll()
{
    m_displayText = "0";
    emit displayTextChanged();
}

void CalculatorBackend::toggleSign()
{
    // Case 1: already wrapped (-number)
    static QRegularExpression wrappedRe(R"(\(-(\d*\.?\d+)\)$)");
    QRegularExpressionMatch wrappedMatch = wrappedRe.match(m_displayText);
    if (wrappedMatch.hasMatch()) {
        QString number = wrappedMatch.captured(1);
        m_displayText.chop(wrappedMatch.capturedLength(0));
        m_displayText += number;
        emit displayTextChanged();
        return;
    }

    // Case 2: plain number at the end
    static QRegularExpression plainRe(R"((\d*\.?\d+)$)");
    QRegularExpressionMatch plainMatch = plainRe.match(m_displayText);
    if (!plainMatch.hasMatch())
        return;

    QString number = plainMatch.captured(1);
    int startIndex = m_displayText.length() - number.length();

    m_displayText =
        m_displayText.left(startIndex) +
        "(-" + number + ")";

    emit displayTextChanged();
}

void CalculatorBackend::evaluateExpression()
{
    QString expr = m_displayText;

    expr.replace("×", "*");
    expr.replace("−", "-");
    expr.replace("÷", "/");
    expr.remove(',');

    QJSEngine engine;
    QJSValue value = engine.evaluate(expr);

    if (value.isError() || !value.isNumber()) {
        m_displayText = "Error";
    } else {
        double result = value.toNumber();
        m_displayText = QString::number(result, 'g', 12);
    }

    emit displayTextChanged();
}



