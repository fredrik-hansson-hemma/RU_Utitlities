* Letar efter objekt av typen "FavoritesContainer" som inte ligger i någon mapp	;

data reports;
	length label $200 path $500 tmp $500;
	length uri $256 asnuri $256;
	call missing(label, tmp, uri, asnuri);
	nobj=1;
	n=1;
	keep uri label path;

	do while(nobj >= 0);
		nobj=metadata_getnobj("omsobj:FavoritesContainer?@Id contains '.'",n,uri);
		rc=metadata_getattr(uri,"Name",label);
		rc=metadata_getnasn(uri,"Trees",1,asnuri);
		arc=metadata_getattr(asnuri,"Name",path);

		/* walk through all the trees on this ClassifierMap object. */
		rc = 1;

		do while(rc>0);
			rc=metadata_getnasn(asnuri,"ParentTree",1,asnuri);
			arc=metadata_getattr(asnuri,"Name",tmp);

			if (rc>0) then do;
				path = trim(tmp) || "/" || trim(path);
			end;
		end;

		/* building the stored process full qualified path*/
		path = "/" || trim(path) || "/" || trim(label) || "(StoredProcess)";
		n=n+1;
		output;
	end;
run;

title "De fem första";
proc sort data=reports;
	by path;
run;
proc print data=&syslast(obs=5) noobs label;
run;

title "De fem sista";
proc sort data=reports;
	by descending path;
run;
proc print data=&syslast(obs=5) noobs label;
run;




* Kontrollerar sökvägen till två objekt som man känner till ID på	;
data _null_;

	* Kollar om ett objekt har en mapp att existera i ;
	length asnuri path $256;
	call missing(asnuri, path);
	rc=metadata_getnasn("OMSOBJ:FavoritesContainer?@Id contains 'A5WAGCCG.BM001DGL'","Trees",1,asnuri);
	put asnuri=;
	arc=metadata_getattr(asnuri,"Name",path);
	put path=;
	output;

	* Kollar om ett annat objekt har en mapp att existera i ;
	call missing(asnuri, path);
	rc=metadata_getnasn("OMSOBJ:FavoritesContainer?@Id contains 'A5WAGCCG.BM00067C'","Trees",1,asnuri);
	put asnuri=;
	arc=metadata_getattr(asnuri,"Name",path);
	put path=;
	output;

run;

