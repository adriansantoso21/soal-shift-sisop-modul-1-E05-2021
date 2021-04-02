#!/bin/bash

cd /media/sf_soal-shift-sisop-modul-1-E05-2021/soal3/

tanggal="$(date '+%m%d%Y')"
zip -P $tanggal -rm Koleksi.zip */