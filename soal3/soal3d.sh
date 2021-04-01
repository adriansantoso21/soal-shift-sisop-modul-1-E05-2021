#!/bin/bash
cd /home/adr01/Documents/SesiLab1/SoalPraktikum/Soal3
tanggal="$(date '+%m%d%Y')"
zip -P $tanggal -rm Koleksi.zip */
