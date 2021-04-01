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
