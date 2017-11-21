

* Letar i alla metadatatyer efter objekt med ett visst ID	;
* Loopar igenom all metadatatyper	;
data _null_;
    length type object_uri name $256;
    getntyp_rc=1;
    n=1;
   
    do while(getntyp_rc>0);

        /* Walk through all possible types on this server. */
        getntyp_rc=metadata_getntyp(n,type);
        * put type=;
        n=n+1;

		* Bygger ihop en söksträng	;
		search_string=cats("omsobj:", type, "?@Id contains 'A5WAGCCG.BM001DGL'");
		put "Searching for: " search_string=;

		n_object=1;
		object_rc=metadata_getnobj(search_string,n_object,object_uri);

		/* The DO statement specifies a group of statements to be executed as a unit
		for each object that is returned by METADATA_GETNOBJ. The METADATA_GETATTR function
		is used to retrieve the values of the Name, Engine, and Libref attributes of 
		the SASLibrary object.  */
		if object_rc>0 then do;
			put ;
			put "NOTE: Objektet " object_uri "hittades!";
			/* Get Library attributes */
			rc=metadata_getattr(object_uri,'Name',name);
			put "NOTE: " name=;
			put ;
		end;
    end;
run;
