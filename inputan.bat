@echo off
Title Latihan & Inputan

rem Variabel dan Inputan
set /p nim =   Masukan NIM Anda     : 
set /p nama =  Masukan Nama Lengkap : 
set /p prodi = Masukan Prodi Anda   : 
set /p kelas = Masukan Kelas Anda   : 
set /p kampus = Masukan Kampus Anda : 

rem Output
echo ........................................
echo Data Mahasiswa UNISS
echo ........................................
echo NIM    : %nim%
echo Nama   : %nama%
echo Prodi  : %prodi%
echo Kelas  : %kelas%
echo Kampus  : %kampus%
echo ........................................
pause