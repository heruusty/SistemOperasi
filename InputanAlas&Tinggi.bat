echo off
title latihan 5 perhitungan luas segitiga
rem===================setting variabel=================
echo ---------------------------------------------------
echo            INPUTAN NILAI ALAS DAN TINGGI
echo ---------------------------------------------------
set /p alas=    masukan nilai alas
set /p tinggi=  masukan nilai tinggi

rem====================setting perhutingan==============
set /a luas=alas*tinggi/2

if %luas% GEQ 500 (
    set grade=kategori besar
) else if %luas% GEQ 100 (
    set grade=kategori sedang
) else (
    set grade=kategori kecil
)

cls
rem===================ouput===============================
echo ------------------------------------------------------
echo            PERHITUNGAN LUAS segitiga
echo ------------------------------------------------------
echo alas       :%alas%
echo TINGGI     :%tinggi%
echo luas setigita tersebut adalah :%luas%
echo kategori bangunan adalah   :%grade%
pause