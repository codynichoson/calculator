QT += quick gui

CONFIG += c++17
CONFIG -= app_bundle

SOURCES += \
    main.cpp \
    calculator_backend.cpp

HEADERS += \
    calculator_backend.h

QML_FILES += qml/main.qml qml/CalcButton.qml qml/CalcTextEdit.qml
