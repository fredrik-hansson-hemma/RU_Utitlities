

* Var f�rsiktig!!! ;


/*********************
* Raderar n�gra objekt	;
data _null_;
	* Raderar objektet som inte finns i n�gon mapp	;
	rc=metadata_delobj("OMSOBJ:FavoritesContainer?@Id contains 'A5WAGCCG.BM00067C'");
    put rc=;
	rc=metadata_delobj("OMSOBJ:FavoritesContainer?@Id contains 'A5WAGCCG.BM001E6E'");
    put rc=;
	rc=metadata_delobj("OMSOBJ:FavoritesContainer?@Id contains 'A5WAGCCG.BM001ESW'");
    put rc=;
	rc=metadata_delobj("OMSOBJ:FavoritesContainer?@Id contains 'A5WAGCCG.BM001F77'");
    put rc=;
run;
/*********************/
