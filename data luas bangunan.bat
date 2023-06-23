echo off
Title latihan 7 inputan persegi panjang

rem Variabel dan inputan
set /p P= masukkan panjang bangunan :
set /p l= masukan lebar bangunan    :

set /a luas=p*l

if %luas% GEQ 500 (
    set grad=kategori besar
) else if %luas% REQ 100 (
    set grade=kategori sedang
) else (
    set grade=kategori kecil
)

cls
rem output
echo ------------------------------------
echo Data luas bangunan
echo ------------------------------------
echo panjang bangunan   :%p%
echo lebar bangunan     :%l%
echo luas bangunan      :%luas%
echo kategori           :%grade%
echo ------------------------------------

rem cetak
echo ------------------------------------>>hasil.txt
echo data luas bangunan>>hasil.txt
echo ------------------------------------>>hasil.txt
echo panjang bangunan :%p%>>hasil.txt
echo lebar bangunan   :%l%>>hasil.txt
echo luas bangunan    :%luas%>>hasil.txt
echo kategori         :%grade%>>hasil.txt
pause