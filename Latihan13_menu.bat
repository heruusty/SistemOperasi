@echo off
:aku
cls
echo Menu Program
echo 1. Hello
echo 2.System Info
echo 3. Exit 

set /p pilihan= piluh menu :

if %pilihan% == 1 (
    goto 1 
) else if %pilihan% == 2 (
    goto 2 
) else if %pilihan% == 3 (
    goto 3
)

:1
cls 
echo =====================================
echo selamat datang
echo hi, Selamat datang
pause
goto aku

:2
cls 
systeminfo
pause
goto begin 

:3
exit

