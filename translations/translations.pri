INCLUDEPATH += $$PWD
DEPENDPATH += $$PWD

TRANSLATIONS += \
    $$PWD/papergame_ru.ts \

isEmpty(QMAKE_LRELEASE) {
    Q_OS_WIN:QMAKE_LRELEASE = $$[QT_INSTALL_BINS]\lrelease.exe
    else:QMAKE_LRELEASE = $$[QT_INSTALL_BINS]/lrelease
}
android {
    OUTDIR = $$PWD/../resources/translations
} else {
    OUTDIR = $$DESTDIR/translations
}
updateqm.input = TRANSLATIONS
updateqm.output = $$OUTDIR/${QMAKE_FILE_BASE}.qm
updateqm.commands = $$QMAKE_LRELEASE ${QMAKE_FILE_IN} -qm $$OUTDIR/${QMAKE_FILE_BASE}.qm
updateqm.CONFIG += no_link target_predeps
QMAKE_EXTRA_COMPILERS += updateqm
