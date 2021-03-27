#!/bin/bash

tanggal="$(date '+%m%d%Y')"
zip -P $tanggal -rm Koleksi.zip */
