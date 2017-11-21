

* Loopar igenom all metadatatyper	;
data _null_;
    length type $256;
    rc=1;
    n=1;
   
    do while(rc>0);

        /* Walk through all possible types on this server. */
        rc=metadata_getntyp(n,type);
        put type=;
        n=n+1;
    end;
run;
