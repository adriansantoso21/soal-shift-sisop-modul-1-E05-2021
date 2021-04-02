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
printf "Error,Count\n" > "error_message.csv"
grep -oP "$regex_err_msgs" "$INPUT" | sort | uniq -c | sort -nr | while read count msgs;
do
        printf "%s,%d\n" "$msgs" "$count" >> "error_message.csv"
done
```

### Penjelasan 1d
Pada soal 1d diminta untuk menuliskan semua informasi yang didapatkan pada poin 1b ke dalam file `error_message.csv` dengan header `Error,Count`
```
printf "Error,Count\n" > "error_message.csv"
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
printf "Username,INFO,ERROR\n" > "user_statistic.csv"
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
printf "Username,INFO,ERROR\n" > "user_statistic.csv"
```
Kode di atas memasukkan `Username,INFO,ERROR` sebagai header file ke dalam `user_statistic.csv`.
```
grep -oP "$regex_username" "$INPUT" | sort | uniq | while read user;
do
        n_info=$(grep -w "$user" <<< "$info" | wc -l);
        n_error=$(grep -w "$user" <<< "$err" | wc -l);
      	 printf "%s,%d,%d\n" "$user" "$n_info" "$n_error" >> "user_statistic.csv"
done
```
Kode di atas  menampilkan jumlah kemunculan log `ERROR` dan `INFO` untuk setiap user-nya. Dimana `while` melakukan looping terhadap var `user` untuk membaca semua baris dari grep tersebut dan hasilnya dengan format `Username,INFO,ERROR` akan dimasukkan ke dalam file `user_statistic.csv`. Kode `n_info=$(grep -w "$user" <<< "$info" | wc -l)` menghitung berapa dari log `INFO` yang ada user tersebut secara match. Kode `n_error=$(grep -w "$user" <<< "$err" | wc -l)` menghitung berapa dari log `ERROR` yang ada user tersebut secara match.

Kendala selama pengerjaan:
1. Agak kesulitan dalam menuliskan regex dikarenakan sebelumnya belum pernah mendengar kata tersebut.
2. Mengalami kendala pada saat akan menuliskan syntax cara membaca multiple lines dari sebuah grep.
3. Kurang teliti dalalm menulis kode program sehingga outputnya menjadi salah. Contohnya pada pengerjaan soal 1e 

### Soal No 2
Steven dan Manis mendirikan sebuah startup bernama “TokoShiSop”. Sedangkan kamu dan Clemong adalah karyawan pertama dari TokoShiSop. Setelah tiga tahun bekerja, Clemong diangkat menjadi manajer penjualan TokoShiSop, sedangkan kamu menjadi kepala gudang yang mengatur keluar masuknya barang.

Tiap tahunnya, TokoShiSop mengadakan Rapat Kerja yang membahas bagaimana hasil penjualan dan strategi kedepannya yang akan diterapkan. Kamu sudah sangat menyiapkan sangat matang untuk raker tahun ini. Tetapi tiba-tiba, Steven, Manis, dan Clemong meminta kamu untuk mencari beberapa kesimpulan dari data penjualan “Laporan-TokoShiSop.tsv”.

**(a)** Steven ingin mengapresiasi kinerja karyawannya selama ini dengan mengetahui Row ID dan profit percentage terbesar (jika hasil profit percentage terbesar lebih dari 1, maka ambil Row ID yang paling besar). Karena kamu bingung, Clemong memberikan definisi dari profit percentage, yaitu:  
Profit Percentage = (Profit Cost Price) * 100  
Cost Price didapatkan dari pengurangan Sales dengan Profit. (Quantity diabaikan).

**(b)** Clemong memiliki rencana promosi di Albuquerque menggunakan metode MLM. Oleh karena itu, Clemong membutuhkan daftar nama customer pada transaksi tahun 2017 di Albuquerque.

**(c)** TokoShiSop berfokus tiga segment customer, antara lain: Home Office, Customer, dan Corporate. Clemong ingin meningkatkan penjualan pada segmen customer yang paling sedikit. Oleh karena itu, Clemong membutuhkan segment customer dan jumlah transaksinya yang paling sedikit.

**(d)** TokoShiSop membagi wilayah bagian (region) penjualan menjadi empat bagian, antara lain: Central, East, South, dan West. Manis ingin mencari wilayah bagian (region) yang memiliki total keuntungan (profit) paling sedikit dan total keuntungan wilayah tersebut.

**(e)** Agar mudah dibaca oleh Manis, Clemong, dan Steven, kamu diharapkan bisa membuat sebuah script yang akan menghasilkan file “hasil.txt” yang memiliki format sebagai berikut:  
```
Transaksi terakhir dengan profit percentage terbesar yaitu *ID Transaksi* dengan persentase *Profit Percentage*%.

Daftar nama customer di Albuquerque pada tahun 2017 antara lain:
*Nama Customer1*
*Nama Customer2* dst

Tipe segmen customer yang penjualannya paling sedikit adalah *Tipe Segment* dengan *Total Transaksi* transaksi.

Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah *Nama Region* dengan total keuntungan *Total Keuntungan (Profit)*
```  
Catatan :  
Gunakan bash, AWK, dan command pendukung  
Script pada poin (e) memiliki nama file ‘soal2_generate_laporan_ihir_shisop.sh’  

Hasil koding keseluruhan untuk no 2:  
```
#!/bin/bash

awk 'BEGIN{max=0;min=2000000000;min2=2000000000;FS="\t"}
{
	if( NR!=1){
		profitPercentage=($21/($18-$21))*100;
		if (max <= profitPercentage){
			max=profitPercentage;
			rowId=$1;
		}
		
		year=substr($3,7,2)
		if(year==17 && $10=="Albuquerque") names[$7];
		
		transactions[$8]++;
		
		regions[$13]+=$21
	}	
} 
END{
print("Transaksi terakhir dengan profit percentage terbesar yaitu",rowId,"dengan persentase",max,"%.\n")
print("Daftar nama customer di Albuquerque pada tahun 2017 antara lain:")
for (name in names) print name
for (transaction in transactions){
	if(min>=transactions[transaction]){
		jenis=transaction
		min=transactions[transaction]
	}
}
print("\nTipe segmen customer yang penjualannya paling sedikit adalah",jenis,"dengan",min, "transaksi.")
for (region in regions){
	if(min2>=regions[region]){
		region2=region
		min2=regions[region]
	}
}
print("\nWilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah",region2, "dengan total keuntungan",min2)	
}' Laporan-TokoShiSop.tsv > hasil.txt
```  
### Jawaban 2a  
Pertama, kita deklarasikan beberapa variabel yaitu ```max``` untuk menyimpan Profit Percentage tertinggi, ```min``` untuk menyimpan banyak transaksi terkecil, ```min2``` untuk menyimpan total profit terkecil, dan FS(Field Separator) dimana di data menggunakan tab(\t)
```
awk 'BEGIN{max=0;min=2000000000;min2=2000000000;FS="\t"}
```
Selanjutnya, akan membaca tiap line dari data di "Laporan-TokoShisop.tsv" dan agar judul dari kolom tidak terbaca maka menggunakan syntax ```if( NR!=1)```

Kita mencari nilai dari Profil Percentage terlebih dahulu dengan rumus di soal 
```Profit Percentage=($21/($18-$21))*100``` 

Untuk mencari Profil Percentage dan row Id terbesar, kita akan melakukan update jika kondisional terpenuhi dengan mengupdate variabel ```max``` dengan Profil Percentage saat ini dan rowId dengan $1 pada data saat ini
```
if (max <= profitPercentage){
	max=profitPercentage;
	rowId=$1;
}
```

### Jawaban 2b
Kita akan mencari tahun transaksi terlebih dahulu dengan menggunakan syntax ```year=substr($3,7,2)``` dimana $3 merupakan kolom dimana kita mencari tahun transaksi, 7 merupakan lokasi awal pencarian karakter dan 2 adalah banyak karakter yang akan diambil.  

Jika kondisional memenuhi yaitu tahun transaksi adalah 17 dan lokasi nya berada di Albuquerque, maka kita akan membuat array yang berisi nama pelanggan
```
year=substr($3,7,2)
if(year==17 && $10=="Albuquerque") names[$7];
```

### Jawaban 2c
Untuk mencari segment dengan jumlah transaksi terkecil maka kita akan membuat array yang berisi tipe-tipe dari segment customer yang ada (Home Office, Consumer, dan Corporate) dan akan melakukan increment untuk menyimpan banyak transaksi yang dilakukan
```
transactions[$8]++;
```

### Jawaban 2d
Untuk mencari region dengan total profit terkecil maka kita juga akan membuat array yang berisi tipe-tipe region yang ada (Central, East, South, dan West) kemudian di dalam array akan menyimpan total profit dengan cara terus menambahkan profit ```$13``` pada array sesuai dengan region yang sesuai ```$21```
```
regions[$13]+=$21
```

### Jawaban 2e
Untuk bagian terakhir maka akan mencetak hasil sesuai dengan format yang diminta :     

__Untuk mencetak bagian 2a__  
```print("Transaksi terakhir dengan profit percentage terbesar yaitu",rowId,"dengan persentase",max,"%.\n")```

__Untuk mencetak bagian 2b__  
```print("Daftar nama customer di Albuquerque pada tahun 2017 antara lain:")```  
Di sini, untuk mencetak nama masing-masing pelanggan maka kita melakukan iterasi pada array names dan mencetak isi item dalam array nya  
```for (name in names) print name```

__Untuk mencetak bagian 2c__  
Kita akan mencari segmen dengan jumlah transaksi terkecil dengan cara melakukan iterasi. Di mana dalam iterasi, jika transaksi saat ini lebih kecil dari pada variabel ```min```  maka akan menyimpan nama section pada ```jenis``` dan akan mengupdate variabel ```min``` dengan besar transaksi saat ini  
```
for (transaction in transactions){
	if(min>=transactions[transaction]){
		jenis=transaction
		min=transactions[transaction]
	}
 print("\nTipe segmen customer yang penjualannya paling sedikit adalah",jenis,"dengan",min, "transaksi.")
}

```

__Untuk mencetak bagian 2d__  
Kita akan mencari region dengan total profit terkecil dengan cara melakukan iterasi. Di mana dalam iterasi, jika total profit saat ini lebih kecil dari pada variabel ```min2```  maka akan menyimpan nama region pada ```region2``` dan akan mengupdate variabel ```min2``` dengan total profit saat ini  
```
for (region in regions){
	if(min2>=regions[region]){
		region2=region
		min2=regions[region]
	}
}
print("\nWilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah",region2, "dengan total keuntungan",min2)  	
```  
__Untuk memasukkan hasil output__  
Terakhir, kita akan memasukkan output dari awk ke dalam file hasil.txt dengan syntax ```Laporan-TokoShiSop.tsv > hasil.txt```

Isi dari file hasil.txt :  
```
Transaksi terakhir dengan profit percentage terbesar yaitu 9952 dengan persentase 100 %.

Daftar nama customer di Albuquerque pada tahun 2017 antara lain:
David Wiener
Susan Vittorini
Benjamin Farhat
Michelle Lonsdale

Tipe segmen customer yang penjualannya paling sedikit adalah Home Office dengan 1783 transaksi.

Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah Central dengan total keuntungan 39706.4 	
```

Kendala selama pengerjaan :  
1. Awalnya agak bingung saat menjalankan beberapa syntax dalam awk.
2. Agak kesulitan dalam mengambil beberapa karakter dari suatu string (soal 2b).
3. Kurang teliti saat melihat separator dari file "Laporan-TokoShiSop.tsv" yang berupa tab.

### Soal No 3
Kuuhaku adalah orang yang sangat suka mengoleksi foto-foto digital, namun Kuuhaku juga merupakan seorang yang pemalas sehingga ia tidak ingin repot-repot mencari foto, selain itu ia juga seorang pemalu, sehingga ia tidak ingin ada orang yang melihat koleksinya tersebut, sayangnya ia memiliki teman bernama Steven yang memiliki rasa kepo yang luar biasa. Kuuhaku pun memiliki ide agar Steven tidak bisa melihat koleksinya, serta untuk mempermudah hidupnya, yaitu dengan meminta bantuan kalian. Idenya adalah :  
**(a)** Membuat script untuk mengunduh 23 gambar dari "https://loremflickr.com/320/240/kitten" serta menyimpan log-nya ke file "Foto.log". Karena gambar yang diunduh acak, ada kemungkinan gambar yang sama terunduh lebih dari sekali, oleh karena itu kalian harus menghapus gambar yang sama (tidak perlu mengunduh gambar lagi untuk menggantinya). Kemudian menyimpan gambar-gambar tersebut dengan nama "Koleksi_XX" dengan nomor yang berurutan tanpa ada nomor yang hilang (contoh : Koleksi_01, Koleksi_02, ...)  
**(b)** Karena Kuuhaku malas untuk menjalankan script tersebut secara manual, ia juga meminta kalian untuk menjalankan script tersebut sehari sekali pada jam 8 malam untuk tanggal-tanggal tertentu setiap bulan, yaitu dari tanggal 1 tujuh hari sekali (1,8,...), serta dari tanggal 2 empat hari sekali(2,6,...). Supaya lebih rapi, gambar yang telah diunduh beserta log-nya, dipindahkan ke folder dengan nama tanggal unduhnya dengan format "DD-MM-YYYY" (contoh : "13-03-2023").  
**(c)** Agar kuuhaku tidak bosan dengan gambar anak kucing, ia juga memintamu untuk mengunduh gambar kelinci dari "https://loremflickr.com/320/240/bunny". Kuuhaku memintamu mengunduh gambar kucing dan kelinci secara bergantian (yang pertama bebas. contoh : tanggal 30 kucing > tanggal 31 kelinci > tanggal 1 kucing > ... ). Untuk membedakan folder yang berisi gambar kucing dan gambar kelinci, nama folder diberi awalan "Kucing_" atau "Kelinci_" (contoh : "Kucing_13-03-2023").  
**(d)** Untuk mengamankan koleksi Foto dari Steven, Kuuhaku memintamu untuk membuat script yang akan memindahkan seluruh folder ke zip yang diberi nama “Koleksi.zip” dan mengunci zip tersebut dengan password berupa tanggal saat ini dengan format "MMDDYYYY" (contoh : “03032003”).  
**(e)** Karena kuuhaku hanya bertemu Steven pada saat kuliah saja, yaitu setiap hari kecuali sabtu dan minggu, dari jam 7 pagi sampai 6 sore, ia memintamu untuk membuat koleksinya ter-zip saat kuliah saja, selain dari waktu yang disebutkan, ia ingin koleksinya ter-unzip dan tidak ada file zip sama sekali.  

Catatan :
Gunakan bash, AWK, dan command pendukung
Tuliskan semua cron yang kalian pakai ke file cron3[b/e].tab yang sesuai

### Jawaban 3a  
Pertama, kita akan memindahkan direktori dari home ke direktori yang kita inginkan  
```cd /home/adr01/Documents/SesiLab1/SoalPraktikum/Soal3``` 

Kemudian, kita membuat file Foto.log untuk menyimpan keterangan saat mendownload foto  
```touch Foto.log```  

Karena, di soal meminta penamaan Koleksi diawali dengan 0 jika mempunyai urutan ke 0-9 maka kita perlu membuat suatu pengondisian. Jika dalam iterasi, variabel bernilai kurang dari 10 maka nama file diawali dengan 0 sedangkan jika tidak maka akan dinamai sesuai dengan nilai dari variabel. ```wget -a (append)``` berfungsi untuk mendownload dan menambahkan keterangan ke dalam file ```Foto.log``` dan ```-O ``` untuk memberi nama dari file yang didownload
```
for((a=1;a<24;a++))
do
	if((a<=9))
	then
		wget -a /home/adr01/Documents/SesiLab1/SoalPraktikum/Soal3/Foto.log "https://loremflickr.com/320/240/kitten" -O /home/adr01/Documents/SesiLab1/SoalPraktikum/Soal3/Koleksi_0"$a".jpeg
	else
		wget -a /home/adr01/Documents/SesiLab1/SoalPraktikum/Soal3/Foto.log "https://loremflickr.com/320/240/kitten" -O /home/adr01/Documents/SesiLab1/SoalPraktikum/Soal3/Koleksi_"$a".jpeg
	fi
done
```  

Kemudian, untuk mengecek apakah ada yang sama dalam foto tersebut maka kita mengecek satu per satu secara looping.  
```
for ((b = 1 ; b < 24 ; b++)); do
    for ((c = b + 1 ; c < 24 ; c++)); do
```  

Untuk mengecek foto yang sama menggunakan ```diff Koleksi_"$b".jpeg Koleksi_"$c".jpeg``` dan jika menemukan foto yang sama maka akan membuang foto tersebut dengan menggunakan syntax ```rm Koleksi_"$c".jpeg```  

Terakhir, kita akan melakukan penamaan kembali untuk masing-masing gambar agar tidak ada no yang hilang yang ada foto yang dihapus dengan melakukan iterasi pada masing-masing foto  
```
itr=0
for pic in *.jpeg
    do
    let itr=itr+1
```  

Untuk penamaan menggunakan cara yang sama seperti di atas, jika varibel itr bernilai 0 hingga 9 maka nama file diawali dengan 0 namun jika tidak maka dinamai sesuai dengan nilai dari variabel  
```
if((a<=9))
        then 
            mv "$pic" "Koleksi_0$itr.jpeg"
    else 
        mv "$pic" "Koleksi_$itr.jpeg"
    fi
done
``` 

![alt text](http://drive.google.com/uc?export=view&id=1yaWolNuf1SPl-mG9GYuMkBnmOlIif0s5)


### Jawaban 3b  
```
#!/bin/bash

tanggal="$(date +%d)-$(date +%m)-$(date +%Y)"
mkdir /home/adr01/Documents/SesiLab1/SoalPraktikum/Soal3/"$tanggal"

cd /home/adr01/Documents/SesiLab1/SoalPraktikum/Soal3/"$tanggal"
touch Foto.log

for((a=1;a<24;a++))
do
	if((a<=9))
	then
		wget -a /home/adr01/Documents/SesiLab1/SoalPraktikum/Soal3/"$tanggal"/Foto.log "https://loremflickr.com/320/240/kitten" -O /home/adr01/Documents/SesiLab1/SoalPraktikum/Soal3/"$tanggal"/Koleksi_0"$a".jpeg
	else
		wget -a /home/adr01/Documents/SesiLab1/SoalPraktikum/Soal3/"$tanggal"/Foto.log "https://loremflickr.com/320/240/kitten" -O /home/adr01/Documents/SesiLab1/SoalPraktikum/Soal3/"$tanggal"/Koleksi_"$a".jpeg
	fi
done

for ((b = 1 ; b < 24 ; b++)); do
    for ((c = b + 1 ; c < 24 ; c++)); do
        if diff Koleksi_"$b".jpeg Koleksi_"$c".jpeg &> /dev/null; then
            rm Koleksi_"$c".jpeg
        fi
    done
done

itr=0
for pic in *.jpeg
    do
    let itr=itr+1
    if((a<=9))
        then 
            mv "$pic" "Koleksi_0$itr.jpeg"
    else 
        mv "$pic" "Koleksi_$itr.jpeg"
    fi
done
```  
Cara pengerjaan untuk 3b hampir sama dengan 3a namun foto dan log akan diletakkan pada folder dengan format penamaan "DD-MM-YYYY". Pertama, kita membuat variabel tanggal untuk nama dari folder  
```
tanggal="$(date +%d)-$(date +%m)-$(date +%Y)"
```  
Kemudian, kita membuat folder nya ```mkdir /home/adr01/Documents/SesiLab1/SoalPraktikum/Soal3/"$tanggal""```  

Dan kita arahkan direktori kita ke folder yang kelak digunakan untuk menyimpan foto-foto dan log nya  Kemudian untuk langkah selanjutnya, sama dengan cara soal no 3a  

Untuk crontab soal 3b, arti crontab di bawah ini adalah script berjalan sehari sekali pada pukul 8 malam dari tanggal 1 dengan interval 7 hari (ex: 1,8) dan dari tanggal 2 dengan interval 4 hari (ex: 2, 6). ```/bin/bash /home/adr01/Documents/SesiLab1/SoalPraktikum/Soal3/soal3b.sh``` berarti awk akan diarahkan ke dalam folder ini  
Hasil crontab :  
```00 20 1-31/7,2-31/4 * * /bin/bash /home/adr01/Documents/SesiLab1/SoalPraktikum/Soal3/soal3b.sh```  

![alt text](http://drive.google.com/uc?export=view&id=16bHudz8m2nF_XiDl1qWiNR4Nc4qsU1g8)

### Jawaban 3c 

![alt text](http://drive.google.com/uc?export=view&id=1gSXc8yQWXczRJVJhDyIJO0M8Egf4oJ18)

### Jawaban 3d
Pertama, kita akan arahkan direktori ke dalam folder kita  
```cd /media/sf_soal-shift-sisop-modul-1-E05-2021/soal3/```  
Untuk membuat password dari zip dimana password dibuat berdasarkan format "MMDDYYYY"  
```tanggal="$(date '+%m%d%Y')"```  
Terakhir, kita akan melakukan zip folder pada direktori tersebut dengan format di atas  
```zip -P $tanggal -rm Koleksi.zip */```  
Hasil coding :  
```
#!/bin/bash

cd /media/sf_soal-shift-sisop-modul-1-E05-2021/soal3/

tanggal="$(date '+%m%d%Y')"
zip -P $tanggal -rm Koleksi.zip */
```  

![alt text](http://drive.google.com/uc?export=view&id=1rz9Gjw7xPcjs_VC14hKqbIzWOnY3wk8g)

### Jawaban 3e  
Untuk melakukan zip dari folder yaitu pada jam 7 pagi hingga jam 6 sore hari senin - jumat kecuali hari sabtu dan minggu. ```cd /media/sf_soal-shift-sisop-modul-1-E05-2021/soal3/``` berfungsi untuk mengubah direktori menuju ke folder tempat soal3d.sh berada dan untuk menjalankan soal3d.sh ```bash soal3d.sh```  
Hasil crontab :  
```0 7 * * 1-5 cd /media/sf_soal-shift-sisop-modul-1-E05-2021/soal3/ && bash soal3d.sh```  

Sedangkan itu, akan melakukan unzip pada hari selain kuliah berarti dilakukan setelah jam 6 malam. ```cd /media/sf_soal-shift-sisop-modul-1-E05-2021/soal3/``` berfungsi untuk mengubah direktori menuju ke folder tempat zip berada, ```unzip -P `date +\%m\%d\%Y` Koleksi.zip``` berfungsi untuk melakukan unzip dengan password sesuai format dan hanya folder bernama Koleksi.zip yang akan di unzip, dan rm ```Koleksi.zip``` berfungsi untuk menghapus folder Koleksi.zip  
Hasil crontab :  
```0 18 * * 1-5 cd /media/sf_soal-shift-sisop-modul-1-E05-2021/soal3/ && unzip -P `date +\%m\%d\%Y` Koleksi.zip && rm Koleksi.zip```


Kendala selama pengerjaan:
1. Agak kesulitan untuk menghapus foto yang sama.  
2. Mengalami kendala saat akan penamaan kembali agar tidak ada no yang hilang.  
3. Kesulitan saat melakukan zip dan unzip folder khususnya saat menggunakan crontab.  
