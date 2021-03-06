/*******************************************************************************************************************************
							TUGAS 1 #POSTTEST
NAMA : GIDION LUNG TUMANAN
NIM : 1515015129
KELAS : C 2015
KELOMPOK PRAKTIKUM : C2
********************************************************************************************************************************/ 

predicates
	ayah(STRING,STRING)
	putra((STRING,STRING)
	
	
	kakek(STRING,STRING)
	cucu((STRING,STRING)
	buyut(STRIBG,STRING)
	cicit(STRIBG,STRING)
	
clauses
	putra("Nando","Kelvin")
	putra("Kelvin","Erik")
	putra("Erik","Jodi")
	putra("Jodi","Wahyu")
	putra("Wahyu","Yoga")
	
	ayah(A,B) :-putra(B,A)
	kakek(A,B) :-ayah(A,C),ayah(C,B).
	buyut(A,B) :-kakek(A,C),ayah(C,B),ayah(A,D),kakek(D,B).
	cucu(A,B) :-putra(A,C),ayah(B,C).
	cicit(A,B) :-cucu(A,C),ayah(B,C),kakek(B,D),ayah(C,D).
	
goal
	cicit("Kelvin",Cicit)