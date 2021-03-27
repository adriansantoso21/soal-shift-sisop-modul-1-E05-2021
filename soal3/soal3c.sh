dir_counter() {
 # menghitung jumlah dir kelinci
 dir_kelinci=$(ls -d Kelinci_* | wc -l)
 # menghitung jumlah dir kucing
 dir_kucing=$(ls -d Kucing_* | wc -l)
  # apabila kelinci lebih banyak
 # maka 1 = mengunduh kucing
 # apabila kucing lebih banyak atau smdg
 # maka 0 = mengunduh kelinci
 if [[ $d_kucing -lt $d_kelinci ]]
 then
     echo 1
 else
     echo 0
 fi
}
download_img(){
 for i in {1..23}
 do
   wget $1 --trust-server-names -a "Foto.log"
 done
 
 array_img_duplicate=($(ls *.jpg.*))
 
 for i in "${array_img_duplicate[*]}"
 do
   rm $i
 done
 
 array_img=($(ls *.jpg))
 
 for i in ${!array_img[*]}
 do
   if [[ $i < 9 ]]
   then
     mv "${array_img[$i]}" "Koleksi_0$(($i+1)).jpg"
   else
     mv "${array_img[$i]}" "Koleksi_$(($i+1)).jpg"
   fi
 done
 
 curr_date=$(date "+%d-%m-%Y")
 foldername=$2$curr_date
 movetofolder $foldername
}
movetofolder(){
   img_array=($(ls *.jpg))
  
   mkdir "$1"
   mv "Foto.log" "$1/Foto.log"
   for i in "${!img_array[@]}"
   do
       mv "${img_array[$i]}" "$1/${img_array[$i]}"
   done
}
 
iskucing="$(dir_counter)"
 
link_kucing="https://loremflickr.com/320/240/kitten"
link_kelinci="https://loremflickr.com/320/240/bunny"
prefix_folder_kucing="Kucing_"
prefix_folder_kelinci="Kelinci_"
if [[ $iskucing -eq 1 ]]
then
   download_img $link_kucing $prefix_folder_kucing
else
   download_img $link_kelinci $prefix_folder_kelinci
fi
