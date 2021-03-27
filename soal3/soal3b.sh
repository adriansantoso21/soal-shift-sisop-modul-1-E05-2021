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
