@echo off

:login
rem Konfigurasi username dan password
set "username=admin"
set "password=admin"

rem Meminta input dari pengguna
set /p "input_username=Masukkan username: "
set /p "input_password=Masukkan password: "

rem Memeriksa username dan password
if "%input_username%"=="%username%" (
    if "%input_password%"=="%password%" (
        echo Login berhasil!
        pause
        goto begin
    ) else (
        echo Password salah!
        pause
        goto login
    )
) else (
    echo Username tidak ditemukan!
    pause
    goto login
)

:begin
cls
echo            Menu Akademik 
echo ===================================
echo 1. Penilaian Mahasiswa
echo 2. Aplikasi Perhitungan
echo 3. Menu Troubleshoot Komputer 
echo 4. Menu Network Komputer
echo 5. Menu Aplikasi
echo 6. Menu Pengaturan Komputer
@REM echo 0. Keluar

set /p "choice=Masukkan pilihan: "

if "%choice%"=="1" goto menu_rekap_nilai 
if "%choice%"=="2" goto kalkulator
if "%choice%"=="3" goto menu_troubleshoot
if "%choice%"=="4" goto menu_network
if "%choice%"=="5" goto menu_aplikasi
if "%choice%"=="6" goto menu_pengaturan
@REM if "%choice%"=="0" goto begin

:menu_rekap_nilai
setlocal enabledelayedexpansion
cls
echo === Menu Rekap Nilai ===
echo 1. Masukkan Nilai
echo 2. Cetak Hasil
echo 0. Keluar

set /p "rekap_choice=Masukkan pilihan (1-3): "

if "%rekap_choice%"=="1" (
    goto masukkan_nilai
) 
if "%rekap_choice%"=="2" (
    call :lihat_rekap_nilai
    goto menu_rekap_nilai
) 
if "%rekap_choice%"=="0" (
    goto back
) 

:masukkan_nilai
cls
echo Penilaian Mahasiswa
echo.

REM Menginputkan Nama dan Semester Mahasiswa
set /p "namaMahasiswa=Masukkan Nama Mahasiswa: "
set /p "semester=Masukkan Semester: "

setlocal enabledelayedexpansion

REM Mendefinisikan daftar mata kuliah dan sks-nya
set "matkul[1]=Manajemen Basis Data"
set "matkul[2]=Manajemen Jaringan"
set "matkul[3]=RPL"
set "matkul[4]=Kewirausahaan"
set "matkul[5]=Etika Profesi"
set "matkul[6]=Probabilitas dan Statistika"
set "matkul[7]=Pemrograman Objek"
set "matkul[8]=Sistem Operasi"

set /a "sks[1]=4"
set /a "sks[2]=2"
set /a "sks[3]=4"
set /a "sks[4]=2"
set /a "sks[5]=2"
set /a "sks[6]=4"
set /a "sks[7]=4"
set /a "sks[8]=2"

REM Inisialisasi variabel totalNilaiMatkul, totalSKS, dan totalNilaiAsli
set /a "totNilai=0"
set /a "totalSKS=0"
set /a "totalNilaiAsli=0"

REM Melakukan perulangan untuk menginputkan nilai dan menghitung nilai skala 4.0
for /l %%i in (1,1,8) do (
    echo Masukkan nilai matkul !matkul[%%i]!:
    set /p "nilai[%%i]=Nilai: "

    REM Menghitung nilai skala 4.0 berdasarkan nilai masukkan
    set /a "nilai_4_scale[%%i]=nilai[%%i] / 25"
    set /a "nilairata[%%i]=nilai[%%i]"

    REM Menentukan bobot berdasarkan nilai skala 4.0
    if !nilai[%%i]! geq 90 (
        set "bobot[%%i]=A"
    ) else if !nilai[%%i]! geq 80 (
        set "bobot[%%i]=A-"
    ) else if !nilai[%%i]! geq 70 (
        set "bobot[%%i]=B"
    ) else if !nilai[%%i]! geq 60 (
        set "bobot[%%i]=C"
    ) else (
        set "bobot[%%i]=D"
    )

    REM Mengakumulasikan totalSKS dengan sks dari mata kuliah saat ini
    set /a "totalSKS+=sks[%%i]"

    REM Mengakumulasikan totalNilaiAsli dengan nilai rata-rata asli dari semua mata kuliah
    set /a "totalNilaiAsli+=nilairata[%%i]"
)

REM Menghitung Indeks Prestasi (IP) dan nilai rata-rata dari semua mata kuliah
if %totalSKS% equ 0 (
    set "ip=0"
    set "rataRata=0"
) else (
    REM Menghitung IP skala 4.0
    set /a "totalNilai4Scale=0"
    for /l %%i in (1,1,8) do (
        set /a "totalNilai4Scale+=nilai_4_scale[%%i] * sks[%%i]"
    )

    REM Menghitung IP dan nilai rata-rata asli
    set /a "ip=totalNilai4Scale/totalSKS"
    set /a "rataRata=totalNilaiAsli/8"
)

REM Menampilkan hasil penilaian ke layar
echo.
echo Hasil penilaian:
echo.
echo Nama Mahasiswa: %namaMahasiswa%
echo Semester: %semester%
echo.
echo  No ^| SKS ^| NILAI ^| GRADE  ^| Nama Matkul
for /l %%i in (1,1,8) do (
    echo   =======================================================
    echo   %%i ^| !sks[%%i]!   ^|!nilai[%%i]!     ^|!bobot[%%i]!        ^|!matkul[%%i]!
)

echo.
echo Total SKS   = %totalSKS%
echo IP Semester = %ip%
echo Nilai Rata-rata = %rataRata%

pause
goto menu_rekap_nilai

:lihat_rekap_nilai
cls
echo Program Saya - Laporan Penilaian Mahasiswa (bentuk txt)
echo.
echo Masukkan nama file laporan (tanpa ekstensi): 
set /p "namaFile=Nama File: "

echo.
echo membuat laporan penilaian mahasiswa  %namaFile%.txt...
echo.

REM Displaying nama mahasiswa and semester in the file
echo Nama Mahasiswa: %namaMahasiswa% >> %namaFile%.txt
echo Semester: %semester% >> %namaFile%.txt
echo. >> %namaFile%.txt
echo ====================================================  >> %namaFile%.txt
echo No ^|SKS ^| NILAI ^|GRADE ^|Nama Matkul  >> %namaFile%.txt

REM Mencetak data nilai mata kuliah
for /l %%i in (1,1,8) do (
echo ==================================================== >> %namaFile%.txt
echo %%i ^| !sks[%%i]!   ^|!nilai[%%i]!     ^|!bobot[%%i]!        ^|!matkul[%%i]!  >> %namaFile%.txt
)
echo Total SKS: %totalSKS% >> %namaFile%.txt
echo IP Semester: %ip% >> %namaFile%.txt
echo Nilai Rata-rata: %rataRata% >> %namaFile%.txt

echo.
echo Menyimpan file Laporan %namaFile%.txt.

pause
goto menu_rekap_nilai


:back
goto begin
pause


:kalkulator
cls
echo ======= Menu Kalkulator Sederhana =======:
echo 1. Penjumlahan
echo 2. Pengurangan
echo 3. Perkalian
echo 4. Pembagian
echo 0. Keluar

set /p "choice=Masukkan pilihan (1-5): "

if "%choice%"=="1" goto penjumlahan
if "%choice%"=="2" goto pengurangan
if "%choice%"=="3" goto perkalian
if "%choice%"=="4" goto pembagian
if "%choice%"=="0" goto exit

echo Pilihan tidak valid. Silakan coba lagi.
pause
goto menu

:penjumlahan
cls
echo === Penjumlahan ===
set /p "num1=Masukkan angka pertama: "
set /p "num2=Masukkan angka kedua: "
set /a "result=num1+num2"
echo Hasil penjumlahan: %result%
pause
goto kalkulator


:pengurangan
cls
echo === Pengurangan ===
set /p "num1=Masukkan angka pertama: "
set /p "num2=Masukkan angka kedua: "
set /a "result=num1-num2"
echo Hasil pengurangan: %result%
pause
goto kalkulator

:perkalian
cls
echo === Perkalian ===
set /p "num1=Masukkan angka pertama: "
set /p "num2=Masukkan angka kedua: "
set /a "result=num1*num2"
echo Hasil perkalian: %result%
pause
goto kalkulator

:pembagian
cls
echo === Pembagian ===
set /p "num1=Masukkan angka pertama: "
set /p "num2=Masukkan angka kedua: "
if "%num2%"=="0" (
    echo Tidak dapat melakukan pembagian dengan angka nol.
    pause
    goto kalkulator
)
set /a "result=num1/num2"
echo Hasil pembagian: %result%
pause
goto kalkulator

:exit
cls
echo Terima kasih telah menggunakan kalkulator sederhana ini.
goto begin
pause

:menu_troubleshoot
cls
echo Menu Troubleshoot Windows 10:
echo 1. Troubleshoot Koneksi Internet
echo 2. Troubleshoot Audio
echo 3. Troubleshoot Printer
echo 4. Troubleshoot Blue Screen
echo 5. Troubleshoot Sistem File
echo 6. menghapus sampah 
echo 0. Back

set /p "pilihan_utama=Masukkan nomor menu : "

if "%pilihan_utama%"=="1" (
    msdt.exe /id NetworkDiagnosticsNetworkAdapter
    goto menu_troubleshoot
    pause
)
if "%pilihan_utama%"=="2" (
    msdt.exe /id AudioPlaybackDiagnostic
    goto menu_troubleshoot
    pause
)
if "%pilihan_utama%"=="3" (
    msdt.exe /id  PrinterDiagnostic
    goto menu_troubleshoot
    pause
)
if "%pilihan_utama%"=="4" (
    msdt.exe /id BlueScreen
    goto menu_troubleshoot
    pause
)
if "%pilihan_utama%"=="5" (
    msdt.exe /id  MaintenanceDiagnostic
    goto menu_troubleshoot
    pause
)
if "%pilihan_utama%"=="6" (
    cleanmgr.exe
    goto menu_troubleshoot
    pause
)

if "%pilihan_utama%"=="0" (
    goto begin
)

:menu_network
cls
echo =========== menu Network Komputer ===========
echo 1. Check IP Address
echo 2. Cek Konektivitas Internet
echo 3. Cek Ping ke Google
echo 0. Back

set /p "network=Masukan Pilihan : "

if "%network%"=="1" (
    ipconfig
    pause
    goto menu_network
)
if "%network%"=="2" (
    ping -n 4 8.8.8.8
    pause
    goto menu_network
)
if "%network%"=="3" (
    ping google.com
    pause
    goto menu_network
)
if "%network%"=="0" (
    goto back
)


:menu_aplikasi
cls
echo ======= aplikasi =======:
echo 1. Microsoft Office
echo 2. Google Chrome
echo 3. Microsoft Edge
echo 0. Back

set /p "pilihan_utama=Masukkan nomor menu (1-4): "

if "%pilihan_utama%"=="1" (
    goto office_menu
    pause
)
if "%pilihan_utama%"=="2" (
    start chrome
    goto menu_aplikasi
    pause
)
if "%pilihan_utama%"=="3" (
    start msedge.exe
    goto menu_aplikasi
    pause
)
if "%pilihan_utama%"=="0" (
    goto begin
    pause
)
    
:office_menu
cls
echo ======= Microsoft Office =======:
echo 1. Microsoft Word
echo 2. Microsoft PowerPoint
echo 3. Microsoft Excel
echo 0. Back

set /p "pilihan_office=Masukkan nomor aplikasi : "

if "%pilihan_office%"=="1" (
    start "" "C:\Program Files\Microsoft Office\root\Office16\WINWORD.EXE"
    goto office_menu
    pause
)
if "%pilihan_office%"=="2" (
    start "" "C:\Program Files\Microsoft Office\root\Office16\POWERPNT.EXE"
    goto office_menu
    pause
)
if "%pilihan_office%"=="3" (
    start "" "C:\Program Files\Microsoft Office\root\Office16\EXCEL.EXE"
    goto office_menu
    pause
)
if "%pilihan_office%"=="0" (
    goto menu_aplikasi
)

:menu_pengaturan
cls
echo ======= Menu Pengaturan =======
echo 1. Pengaturan Jaringan
echo 2. Pengaturan Suara
echo 3. Pengaturan Layar
echo 0. Back

set /p "choice=Masukkan pilihan: "
if "%choice%"=="1" (
    echo Membuka Pengaturan Jaringan...
    control /name Microsoft.NetworkAndSharingCenter
    goto menu_pengaturan
    )
if "%choice%"=="2" (
    echo Membuka Pengaturan Suara...
    control /name Microsoft.Sound
    goto menu_pengaturan
    )
if "%choice%"=="3" (
    echo Membuka Pengaturan Layar...
    control /name Microsoft.Display
    goto menu_pengaturan
    )
if "%choice%"=="0" (
    goto begin
    )

