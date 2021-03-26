#!/bin/bash

awk 'BEGIN{max=0;itr=0;consumer=0;corporate=0;home=0;min=2000000000;min2=2000000000;transactions["Customer"]=0;transactions["Corporate"]=0;transactions["Home Office"]=0;regions["Central"]=0;regions["East"]=0;regions["South"]=0;regions["West"]=0;FS="\t"}
{
	//Soal 2a
	if( NR!=1){
		costPrice=($18-$21);
		profitPercentage=(($21/costPrice) * 100);
		if (max<=profitPercentage){
			max=profitPercentage;
			rowId=$2;
		}
	}
	fi
	
	//Soal 2b
	year=substr($3,7,2)
	if(NR!=1){
		if(year==17 && $10=="Albuquerque"){
			names[$7];
		}
	}
	fi
	
	//Soal 2c
	
	if(NR!=1){
		if($8=="Customer"){
			transactions["Customer"]++;
		}
		if($8=="Corporate"){
			transactions["Corporate"]++;
		}
		if($8=="Home Office"){
			transactions["Home Office"]++;
		}
	}
	
	
	
	//Soal 2d
	
	if(NR!=1){
		if($13=="Central"){
			regions["Central"]+=$21;
		}
		if($13=="East"){
			regions["East"]+=$21;
		}
		if($13=="South"){
			regions["South"]+=$21;
		}
		if($13=="West"){
			regions["West"]+=$21;
		}
	}
	
	
} 
END{
print("Transaksi terakhir dengan profit percentage terbesar yaitu",rowId,"dengan persentase",max,"%.\n")

print("Daftar nama customer di Albuquerque pada tahun 2017 antara lain:")
for (name in names){
	print name
}

for (transaction in transactions){
	if(min>transactions[transaction]){
		jenis=transaction
		minim=transactions[jenis]
	}
	fi
}

print("\nTipe segmen customer yang penjualannya paling sedikit adalah",jenis,"dengan",minim, "transaksi.")

for (region in regions){
	if(min2>regions[region]){
		region2=region
		minim2=regions[region]
	}
	fi
}

print("\nWilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah",region2, "dengan total keuntungan",minim2)
	
}' Laporan-TokoShiSop.tsv > hasil.txt
