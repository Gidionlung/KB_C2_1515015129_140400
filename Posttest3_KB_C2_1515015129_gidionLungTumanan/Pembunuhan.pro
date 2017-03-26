/*
						TUGAS POSTTESST
						   #ANALISIS
Nama 	: Gidion Lung Tumanan
NIM	: 1515015129
Kelas	: C2 2015

*/

DOMAINS
	nama,jender,pekerjaan,benda,alasan,zat = symbol % deskripsi dan implementasi 
	umur=integer % deskripsi dan implementasi
	
PREDICATES
	nondeterm orang(nama, umur, jender, pekerjaan) % data seseorang yang berupa nama, umur, jender, dan pekerjaan
	nondeterm selingkuh(nama, nama) % keterangan selingkuh dilengkapi dengan nama 
	terbunuh_dengan(nama, benda) % nama korban pembunuhan dan alat yang digunakan
	terbunuh(nama) % korban pembunuhan
	nondeterm pembunuh(nama) % nama pembunuh
	motif(alasan) % motif pembunuhan di sertai dengan alasan terjadinya pembunuhan
	ternodai(nama, zat) % keterangan nama korban yang terbunuh ternodai dengan zat
 	milik(nama, benda) % seseorang memiliki nama dan benda yang digunakan untuk pembunuhan
	nondeterm cara_kerja_mirip(benda, benda) %  keterangan alat yang digunakan di tempat kejadian
	nondeterm kemungkinan_milik(nama, benda) % seseorang kemungkinan memiliki benda yang digunakan untuk membunuh 
	nondeterm dicurigai(nama) % nama tersangka yang dicurigai

/* * * Fakta-fakta tentang pembunuhan * * */

CLAUSES
	orang(budi,55,m,tukang_kayu). % budi berusia 55th, jenis kelamin laki-laki dan bekerja sebagai tukang kayu
	orang(aldi,25,m,pemain_sepak_bola). % aldi berusia 25th, jenis kelamin laki-laki dan bekerja sebagai pemain sepak bola
	orang(aldi,25,m,tukang_jagal). % aldi berusia 25th, jenis kelamin laki-laki dan bekerja sebagai tukang jagal
	orang(joni,25,m,pencopet). % budi berusia 25th, jenis kelamin laki-laki dan bekerja sebagai pencopet
	
	selingkuh(ina,joni). % ina berselingkuh dengan joni
	selingkuh(ina,budi). % ina berselingkuh dengan budi
	selingkuh(siti,joni). % siti berselingkuh dengan joni
	
	terbunuh_dengan(siti,pentungan). % siti terbunuh dengan pentungan
	terbunuh(siti). % siti terbunuh
	motif(uang). % motif pembunuhan adalah uang
	motif(cemburu). % motif pembunuhan adalah cemburu
	motif(dendam). % motif pembunuhan adalah dendam
	
	ternodai(budi, darah). % budi ternodai oleh darah
	ternodai(siti, darah). % siti ternodai oleh darah
	ternodai(aldi, lumpur). % aldi ternodai oleh lumpur
	ternodai(joni, coklat). % joni ternodai oleh coklat
	ternodai(ina, coklat). % ina ternodai oleh coklat
	
	milik(budi,kaki_palsu). % budi memiliki kaki palsu
	milik(joni,pistol). % joni memiliki pistol

/* * * Basis Pengetahuan * * */

	cara_kerja_mirip(kaki_palsu, pentungan). % kaki palsu yang digunakan saat pembunuhan mirip dengan pentungan
	cara_kerja_mirip(balok, pentungan). % balok yang digunakan untuk pembunuhan mirip dengan petungan 
	cara_kerja_mirip(gunting, pisau). % gunting yang digunakan untuk mirip dengan pisau
	cara_kerja_mirip(sepatu_bola, pentungan). % sepatu bola digunakan untuk pembunuhan mirip dengan pentungan

	kemungkinan_milik(X,sepatu_bola):- % kemungkinan  memiliki sepatu bola, jika memenuhi
	orang(X,_,_,pemain_sepak_bola). % orang dengan pekerjaan sebagai pemain sepak bola
	kemungkinan_milik(X,gunting):- % kemungkinan  memiliki gunting, jika memenuhi
	orang(X,_,_,pekerja_salon). % orang dengan pekerjaan sebagai penatan rambut
	kemungkinan_milik(X,Benda):- % kemungkinan memiliki, jika memenuhi
	milik(X,Benda). % orang yang memiliki benda 

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* dicurigai semua orang yang memiliki senjata yang *
* kerjanya mirip dengan senjata penyebab siti terbunuh. *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * */

	dicurigai(X):- % di katakan tersangka/dicurigai jika memenuhi
	terbunuh_dengan(siti,Senjata) , % siti terbunuh dengan senjata
	cara_kerja_mirip(Benda,Senjata) , % cara kerja benda yang digunakan menyerupai senjata
	kemungkinan_milik(X,Benda). % keterangan pemilik benda adalah X

/* * * * * * * * * * * * * * * * * * * * * * * * * *
* dicurigai laki-laki yang selingkuh dengan siti. *
* * * * * * * * * * * * * * * * * * * * * * * * * */

	dicurigai(X):- % dikatakan tersangka/dicurigai, jika memenuhi
	motif(cemburu), % motif pembunuhan adalah cemburu
	orang(X,_,m,_), % orang dengan jender laki-laki
	selingkuh(siti,X). % siti berselingkuh dengan si X

/* * * * * * * * * * * * * * * * * * * * * * *
* dicurigai perempuan yang selingkuh dengan *
* laki-laki yang juga selingkuh dengan siti *
* * * * * * * * * * * * * * * * * * * * * * */

	dicurigai(X):- % dikatakan tersangka/dicurigai, jika memenuhi 
	motif(cemburu), % motif pembunuhan adalah cemburu
	orang(X,_,f,_), % orang dengan nama X dan jender wanita
	selingkuh(X,Lakilaki), % selingkuh dengan X dengan jender laki-laki
	selingkuh(siti,Lakilaki). % siti selingkuh dengan laki-laki

/* * * * * * * * * * * * * * * * * * * * * * * * * * *
* dicurigai pencopet yang mempunyai motif uang. *
* * * * * * * * * * * * * * * * * * * * * * * * * * */

	dicurigai(X):- % dikatakan tersangka/dicurigai, jika memenuhi 
	motif(uang), % motif pembunuhan adalah uang
	orang(X,_,_,pencopet). % orang dengan nama X yang bekerja sebagai pencopet
	pembunuh(Pembunuh):- % pembunuh
	orang(Pembunuh,_,_,_), %orang dengan nama pembunuh
	terbunuh(Terbunuh), % korban dengan sebutan terbunuh
	Terbunuh <> Pembunuh, /* Bukan bunuh diri */
	dicurigai(Pembunuh), % dicurigai sebagai pembunuh
	ternodai(Pembunuh,Zat), % pembunuh ternodai dengan zat
	ternodai(Terbunuh,Zat). % korban ternodai dengan zat

GOAL
	pembunuh(X). % X adalah pembunuh