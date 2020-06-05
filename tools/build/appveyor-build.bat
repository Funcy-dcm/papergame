setlocal
@echo ON

echo "BUILD %APPVEYOR_BUILD_VERSION%_%CONFIGURATION%_%ARCH%_%APPVEYOR_REPO_TAG_NAME%"
mkdir build && cd build
qmake CONFIG+=%CONFIGURATION% ..\papergame.pro SHOW_GAME=true
call jom
windeployqt bin --qmldir=..\resources\qml --no-compiler-runtime
cp ../resources/data/rules_en.pdf bin/data
cp ../resources/data/rules_ru.pdf bin/data
cp ../resources/data/sheet.pdf bin/data
cp c:\Windows\SysWOW64\msvcp140.dll bin
cp c:\Windows\SysWOW64\vccorlib140.dll bin
cp c:\Windows\SysWOW64\vcruntime140.dll bin
cp %OPENSSL_DIR%\bin\libeay32.dll bin
cp %OPENSSL_DIR%\bin\ssleay32.dll bin
cp ../AUTHORS bin
cp ../CHANGELOG bin
cp ../LICENSE bin
cp ../README.md bin
if "%PORTABLE%" == "true" (
    mkdir PaperGame-%APPVEYOR_BUILD_VERSION%-portable
    cp -r bin/* PaperGame-%APPVEYOR_BUILD_VERSION%-portable/
    type nul > PaperGame-%APPVEYOR_BUILD_VERSION%-portable\portable.dat
    7z a "PaperGame-%APPVEYOR_BUILD_VERSION%-portable.zip" "PaperGame-%APPVEYOR_BUILD_VERSION%-portable"
    for /f %%i in ('"powershell (Get-FileHash -Algorithm MD5 -Path "PaperGame-%APPVEYOR_BUILD_VERSION%-portable.zip" ).Hash"') do set hash=%%i
    echo %hash% *PaperGame-%APPVEYOR_BUILD_VERSION%-portable.zip > PaperGame-%APPVEYOR_BUILD_VERSION%-portable.md5
) else (
    if "%APPVEYOR_REPO_TAG%" == "true" (
        call "C:\Program Files (x86)\Inno Setup 5\compil32" /cc "..\tools\installer\papergame.iss"
        ren PaperGame-*-setup.exe PaperGame-%APPVEYOR_BUILD_VERSION%-setup-%ARCH%.exe
        for /f %%i in ('"powershell (Get-FileHash -Algorithm MD5 -Path "PaperGame-%APPVEYOR_BUILD_VERSION%-setup-%ARCH%.exe" ).Hash"') do set hash=%%i
        echo %hash% *PaperGame-%APPVEYOR_BUILD_VERSION%-setup-%ARCH%.exe > PaperGame-%APPVEYOR_BUILD_VERSION%-setup-%ARCH%.md5
    )
)
