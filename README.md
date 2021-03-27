# soal-shift-sisop-modul-1-E05-2021

### Soal No 1
Ryujin baru saja diterima sebagai IT support di perusahaan Bukapedia. Dia diberikan tugas untuk membuat laporan harian untuk aplikasi internal perusahaan, ticky. Terdapat 2 laporan yang harus dia buat, yaitu laporan daftar peringkat pesan error terbanyak yang dibuat oleh ticky dan laporan penggunaan user pada aplikasi ticky. Untuk membuat laporan tersebut, Ryujin harus melakukan beberapa hal berikut:

**(a)** Mengumpulkan informasi dari log aplikasi yang terdapat pada file `syslog.log`. Informasi yang diperlukan antara lain: jenis log `(ERROR/INFO)`, pesan log, dan username pada setiap baris lognya. Karena Ryujin merasa kesulitan jika harus memeriksa satu per satu baris secara manual, dia menggunakan regex untuk mempermudah pekerjaannya. Bantulah Ryujin membuat regex tersebut.

**(b)** Kemudian, Ryujin harus menampilkan semua pesan error yang muncul beserta jumlah kemunculannya.

**(c)** Ryujin juga harus dapat menampilkan jumlah kemunculan log `ERROR` dan `INFO` untuk setiap user-nya.

Setelah semua informasi yang diperlukan telah disiapkan, kini saatnya Ryujin menuliskan semua informasi tersebut ke dalam laporan dengan format file `csv`.

**(d)** Semua informasi yang didapatkan pada poin b dituliskan ke dalam file `error_message.csv` dengan header `Error,Count` yang kemudian diikuti oleh daftar pesan error dan jumlah kemunculannya **diurutkan** berdasarkan jumlah kemunculan pesan error dari yang terbanyak.

Contoh:
```
Error,Count
Permission denied,5
File not found,3
Failed to connect to DB,2
```

**(e)** Semua informasi yang didapatkan pada poin c dituliskan ke dalam file `user_statistic.csv` dengan header `Username,INFO,ERROR` **diurutkan** berdasarkan username secara ascending.

Contoh:
```
Username,INFO,ERROR
kaori02,6,0
kousei01,2,2
ryujin.1203,1,3
```
**Catatan :**

- Setiap baris pada file syslog.log mengikuti pola berikut:

 ```<time> <hostname> <app_name>: <log_type> <log_message> (<username>)```

- Tidak boleh menggunakan AWK

### Jawaban 1a
```
#!/bin/bash

INPUT="syslog.log"

# 1a
regex_type="(INFO|ERROR)"
regex_msgs="(?<=[INFO|ERROR] ).*(?<=\ )"
regex_err_msgs="(?<=ERROR ).*(?<=\ )"
regex_info_msgs="(?<=INFO ).*(?<=\ )"
regex_username="(?<=\().*(?=\))"

type=$(grep -oP "$regex_type" "$INPUT")
err_msgs=$(grep -oP "$regex_err_msgs" "$INPUT")
info_msgs=$(grep -oP "$regex_info_msg" "$INPUT")
msgs=$(grep -oP "$regex_msgs" "$INPUT")
username=$(grep -oP "$regex_username" "$INPUT")
```

### Penjelasan 1a
Pada soal 1a diminta untuk membuat regex yang dapat menampilkan jenis log `(ERROR/INFO)`, pesan log, dan username pada setiap baris lognya.
```
INPUT="syslog.log"
``` 
Pertama, mengassign input file `syslog.log` ke dalam variabel `INPUT`.
```
regex_type="(INFO|ERROR)"
```
Regex `(ERROR|INFO)` akan mencari setiap setiap baris yang memiliki kata `(ERROR/INFO)`
```
regex_msgs="(?<=[INFO|ERROR] ).*(?<=\ )"
```
Regex `(?<=[INFO|ERROR] )` akan mencari baris yang memiliki kata `(ERROR/INFO)` dan `?<=` untuk mencari mencari kalimat selanjutnya dari kata tersebut. Regex `.*` untuk mencari semua karakter sampai akhir line. Regex `(?<=\ )` untuk memberhentikan `.*` setelah bertemu special character `space`.
```
regex_err_msgs="(?<=ERROR ).*(?<=\ )"
```
Regex `(?<=ERROR )` akan mencari baris yang memiliki kata `ERROR` dan `?<=` untuk mencari mencari kalimat selanjutnya dari kata tersebut. Regex `.*` untuk mencari semua karakter sampai akhir line. Regex `(?<=\ )` untuk memberhentikan `.*` setelah bertemu special character `space`.
```
regex_info_msgs="(?<=INFO ).*(?<=\ )"
```
Regex `(?<=INFO )` akan mencari baris yang memiliki kata `INFO` dan `?<=` untuk mencari mencari kalimat selanjutnya dari kata tersebut. Regex `.*` untuk mencari semua karakter sampai akhir line. Regex `(?<=\ )` untuk memberhentikan `.*` setelah bertemu special character `space`.
```
regex_username="(?<=\().*(?=\))"
```
Regex `(?<=\()` akan mencari baris yang memiliki karater `(` dan `?<=` untuk mencari mencari kalimat selanjutnya dari kata tersebut. Regex `.*` untuk mencari semua karakter sampai akhir line. Regex `(?=\))` untuk memberhentikan `.*` setelah bertemu special character `)`.
```
type=$(grep -oP "$regex_type" "$INPUT")
```
`grep -oP` hanya mengambil kata yang dicari dalam sebuah baris menggunakan Perl yang terdapat di dalam variabel `regex_type`.
```
err_msgs=$(grep -oP "$regex_err_msgs" "$INPUT")
```
`grep -oP` hanya mengambil kata yang dicari dalam sebuah baris menggunakan Perl yang terdapat di dalam variabel `regex_err_msgs`.
```
info_msgs=$(grep -oP "$regex_info_msg" "$INPUT")
```
`grep -oP` hanya mengambil kata yang dicari dalam sebuah baris menggunakan Perl yang terdapat di dalam variabel `regex_info_msgs`.
```
msgs=$(grep -oP "$regex_msgs" "$INPUT")
```
`grep -oP` hanya mengambil kata yang dicari dalam sebuah baris menggunakan Perl yang terdapat di dalam variabel `regex_msgs`.
```
username=$(grep -oP "$regex_username" "$INPUT")
```
`grep -oP` hanya mengambil kata yang dicari dalam sebuah baris menggunakan Perl yang terdapat di dalam variabel `regex_username`.

### Jawaban 1b
```
# 1b
uniq_err_msgs=$(grep -oP "$regex_err_msgs" "$INPUT" | sort | uniq -c | sort -nr)
```

### Penjelasan 1b
Pada soal 1b diminta untuk menampilkan semua pesan error yang muncul beserta jumlah kemunculannya. Kode `grep -oP` hanya mengambil kata yang dicari dalam baris menggunakan Perl. `regex_err_msgs` merupakan variabel yang mengandung regex untuk mendapatkan kalimat pada pesan ERROR. Kode `| sort | uniq -c` melakukan sort agar pesan log ERROR yang sama berurutan kemudian dihitung berapa setiap user mendapat pesan ERROR. Kode `| sort -nr` artinya mengurutkan pesan error berdasarkan jumlahnya dari terbanyak ke terkecil.

### Jawaban 1c
```
# 1c
regex_err="(?<=ERROR ).*(?<=\))"
regex_info="(?<=INFO ).*(?<=\))"
err=$(grep -oP "$regex_err" "$INPUT")
info=$(grep -oP "$regex_info" "$INPUT")
```

### Penjelasan 1c
Pada soal 1c diminta untuk menampilkan jumlah kemunculan log `ERROR` dan `INFO` untuk setiap user-nya.
```
regex_err="(?<=ERROR ).*(?<=\))"
```
Regex `(?<=ERROR )` akan mencari baris yang memiliki kata `ERROR` dan `?<=` untuk mencari mencari kalimat selanjutnya dari kata tersebut. Regex `.*` untuk mencari semua karakter sampai akhir line. Regex `(?<=\))` untuk memberhentikan `.*` setelah bertemu character `)`.
```
regex_info="(?<=INFO ).*(?<=\))"
```
Regex `(?<=INFO )` akan mencari baris yang memiliki kata `INFO` dan `?<=` untuk mencari mencari kalimat selanjutnya dari kata tersebut. Regex `.*` untuk mencari semua karakter sampai akhir line. Regex `(?<=\))` untuk memberhentikan `.*` setelah bertemu character `)`.
```
err=$(grep -oP "$regex_err" "$INPUT")
```
`grep -oP` hanya mengambil kata yang dicari dalam sebuah baris menggunakan Perl yang terdapat di dalam variabel `regex_err` yaitu pesan error dan usernamenya.
```
info=$(grep -oP "$regex_info" "$INPUT")
```
`grep -oP` hanya mengambil kata yang dicari dalam sebuah baris menggunakan Perl yang terdapat di dalam variabel `regex_info` yaitu info dan usernamenya.

### Jawaban 1d
```
# 1d
printf "ERROR,COUNT\n" > "error_message.csv"
grep -oP "$regex_err_msgs" "$INPUT" | sort | uniq -c | sort -nr | while read count msgs;
do
        printf "%s,%d\n" "$msgs" "$count" >> "error_message.csv"
done
```

### Penjelasan 1d
Pada soal 1d diminta untuk menuliskan semua informasi yang didapatkan pada poin 1b ke dalam file `error_message.csv` dengan header `Error,Count`
```
printf "ERROR,COUNT\n" > "error_message.csv"
```
Kode di atas memasukkan `Error,Count` sebagai header file ke dalam `error_message.csv`.
```
grep -oP "$regex_err_msgs" "$INPUT" | sort | uniq -c | sort -nr | while read count msgs;
do
        printf "%s,%d\n" "$msgs" "$count" >> "error_message.csv"
done
```
Kode di atas  menampilkan semua pesan error yang muncul beserta jumlah kemunculannya dari terbanyak ke terkecil. Dimana `while` melakukan looping terhadap var1 `count` dan var2 ` msgs` untuk membaca semua baris dari grep tersebut dan hasilnya dengan format `Error,Count` akan dimasukkan ke dalam file `error_message.csv`.

### Jawaban 1e
```
# 1e
printf "USERNAME,INFO,ERROR\n" > "user_statistic.csv"
grep -oP "$regex_username" "$INPUT" | sort | uniq | while read user;
do
        n_info=$(grep "$user" <<< "$info" | wc -l);
        n_error=$(grep "$user" <<< "$err" | wc -l);
      	 printf "%s,%d,%d\n" "$user" "$n_info" "$n_error" >> "user_statistic.csv"
done
```

### Penjelasan 1e
Pada soal 1e diminta untuk menuliskan semua informasi yang didapatkan pada poin 1c ke dalam file `user_statistic.csv` dengan header `Username,INFO,ERROR`.
```
printf "USERNAME,INFO,ERROR\n" > "user_statistic.csv"
```
Kode di atas memasukkan `Username,INFO,ERROR` sebagai header file ke dalam `user_statistic.csv`.
```
grep -oP "$regex_username" "$INPUT" | sort | uniq | while read user;
do
        n_info=$(grep "$user" <<< "$info" | wc -l);
        n_error=$(grep "$user" <<< "$err" | wc -l);
      	 printf "%s,%d,%d\n" "$user" "$n_info" "$n_error" >> "user_statistic.csv"
done
```
Kode di atas  menampilkan jumlah kemunculan log `ERROR` dan `INFO` untuk setiap user-nya. Dimana `while` melakukan looping terhadap var `user` untuk membaca semua baris dari grep tersebut dan hasilnya dengan format `Username,INFO,ERROR` akan dimasukkan ke dalam file `user_statistic.csv`. Kode `n_info=$(grep "$user" <<< "$info" | wc -l)` menghitung berapa dari log `INFO` yang ada user tersebut. Kode `n_error=$(grep "$user" <<< "$err" | wc -l)` menghitung berapa dari log `ERROR` yang ada user tersebut.

