# Program untuk menghitung luas persegi panjang

.data
    prompt_input1: .asciiz "\nMasukkan nilai panjang (4242 untuk berhenti): "
    prompt_input2: .asciiz "Masukkan nilai lebar (4242 untuk berhenti): "
    prompt_output: .asciiz "Luas persegi panjang: "
    kecil: .asciiz " PERSEGI PANJANG KECIL"
    besar: .asciiz " PERSEGI PANJANG BESAR"
    negatif: .asciiz "Nilai tidak valid. Masukkan nilai > 0"
    salah_urutan: .asciiz "Nilai tidak valid. Masukkan nilai panjang > lebar"

.text
.globl main

main:
    # Memanggil prosedur MASUKAN
    jal MASUKAN
    move $s0, $t0         #Memindahkan data pada $t0 ke $s0
    move $s1, $t1         #Memindahkan data pada $t1 ke $s1

    # Memanggil prosedur PENGOLAHAN
    jal PENGOLAHAN
    move $s2, $t2         #Memindahkan data pada $t2 ke $s2

    # Memanggil prosedur KELUARAN
    jal KELUARAN

    # Mengulang program
    j main

# Prosedur MASUKAN
MASUKAN:
    # Menampilkan prompt untuk memasukkan nilai panjang
    li $v0, 4
    la $a0, prompt_input1
    syscall

    # Menerima input nilai panjang
    li $v0, 5
    syscall
    move $t0, $v0        #Memindahkan data pada $v0 ke $t0
    
    # Memeriksa apakah nilai panjang merupakan bilangan negatif atau nol
    blez $t0,  ZERO

    # Memeriksa apakah bilangan 4242 yang dimasukkan
    li $t2, 4242
    beq $t0, $t2, EXIT
    
    # Menampilkan prompt untuk memasukkan nilai lebar
    li $v0, 4
    la $a0, prompt_input2
    syscall

    # Menerima input nilai lebar
    li $v0, 5
    syscall
    move $t1, $v0         #Memindahkan data pada $v0 ke $t1

    # Memeriksa apakah bilangan 4242 yang dimasukkan
    beq $t1, $t2, EXIT

    # Memeriksa apakah nilai lebar merupakan bilangan negatif atau nol
    blez $t1,  ZERO

    # Memeriksa apakah nilai panjang <= lebar
    ble $t0, $t1, SMALLER       # Apabila nilai panjang <= lebar maka akan menampilkan "Nilai tidak valid. Masukkan nilai panjang > lebar"

    # Keluar dari prosedur
    jr $ra

# Prosedur PENGOLAHAN
PENGOLAHAN:
    # Menghitung luas persegi panjang
    mul $t2, $s1, $s0       # Mengalikan bilangan pada $s1 dan $s0 lalu disimpan pada $t2
    
    # Keluar dari prosedur
    jr $ra

# Prosedur KELUARAN
KELUARAN:
    # Menampilkan hasil
    li $v0, 4
    la $a0, prompt_output
    syscall

    li $v0, 1
    move $a0, $s2       # Memindahkan nilai $s2 ke $a0
    syscall

    # Menampilkan pesan sesuai dengan ukuran persegi panjang
    li $v0, 4
    blt $s2, 700, KECIL
    la $a0, besar
    syscall
    jr $ra
    
KECIL:
    # Menampilkan pesan "PERSEGI PANJANG KECIL"
    li $v0, 4
    la $a0, kecil
    syscall
    
    j MASUKAN
    
ZERO:
    # Menampilkan pesan "Nilai tidak valid. Masukkan nilai > 0"
    li $v0, 4
    la $a0, negatif
    syscall
    
    j MASUKAN
    
SMALLER:
    # Menampilkan pesan "Nilai tidak valid. Masukkan nilai panjang > lebar"
    li $v0, 4
    la $a0, salah_urutan
    syscall
    
    j MASUKAN

EXIT:
    
    syscall
    # Menyelesaikan program
    li $v0, 10
    syscall