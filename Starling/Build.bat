@ECHO OFF

ECHO Building haxe...
ECHO.
haxe build.hxml
flashplayer_11_sa_debug.exe bin\main.swf
ECHO Press any key to continue...
::PAUSE >NUL
EXIT
