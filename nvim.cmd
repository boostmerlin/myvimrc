@echo off
setlocal
set "XDG_CONFIG_HOME=%~dp0"
"C:\Program Files\Neovim\bin\nvim.exe" %*
exit /b %errorlevel%
