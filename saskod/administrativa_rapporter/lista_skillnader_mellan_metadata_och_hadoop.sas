

%macro compare_metadata_and_phys_tables(Metadata_Library_name=);

	libname lib_meta meta metaout=all library=&Metadata_Library_name;
	libname lib_phys meta metaout=data library=&Metadata_Library_name;


	proc SQL noprint;
		create table work.metadatatables as
		select memname as meta_memname label="Finns i metadata (med tillägget '_stg')" from dictionary.tables
		where libname="%upcase(lib_meta)";

		create table work.phys_tables as
		select memname as phys_memname label="Finns i Hadoop" from dictionary.tables
		where libname="%upcase(lib_phys)";

	   CREATE TABLE WORK.compare AS 
	   SELECT t1.meta_memname,
 	         t2.phys_memname
  	    FROM WORK.METADATATABLES t1
   	        FULL JOIN WORK.PHYS_TABLES t2 ON (t1.meta_memname = t2.phys_memname);

	quit;

	
	proc report data=work.compare nowd;
		column (&Metadata_Library_name meta_memname phys_memname) ;
		define meta_memname / display missing;
		define phys_memname / display missing;
		compute meta_memname;

			if meta_memname = '' then do;
				call define(_ROW_,'style','style={background=red font_weight=bold}');
			end;
		endcomp;

		compute phys_memname;

			if phys_memname = '' then do;
				call define(_ROW_,'style','style={background=orange font_weight=bold}');
			end;
		endcomp;
	run;

	
	libname lib_meta clear;
	libname lib_phys clear;

%mend compare_metadata_and_phys_tables;




%let output_path=/opt/sas/config/Lev1/Web/WebServer/htdocs/adminrapporter/hdfs_vs_metadata;

* Skapar sökvägen om den inte redan finns	;
* (Fungerar inte helt automatiskt. Katalogerna måste skapas med följande behörighet för
* att programmet ska kunna skriva och webservern ska kunna läsa:
*	drwxrwxr-x. 2 sas sasusers 102 Mar 13 10:33 hdfs_vs_metadata						;
options dlcreatedir;
libname ___temp "/opt/sas/config/Lev1/Web/WebServer/htdocs/adminrapporter";
libname ___temp "/opt/sas/config/Lev1/Web/WebServer/htdocs/adminrapporter/hdfs_vs_metadata";
libname ___temp clear;
options nodlcreatedir;

Title1 "Tabeller som finns i Metadata, men sakanas i Hadoop, och vice versa";
Title2 "Senast uppdaterad %sysfunc(today(), yymmdd10.) kl %sysfunc(time(),hhmm6.)";
Title3 "Observera att användaren som kör programmet måste ha läsrättigheter till både metadata och fysiskt data om rapporten ska visa rätt.";

ods html4 path="&output_path"(URL="./") file="forgotten_files_in_Hadoop.html" style=seaside /*base="./"*/
	stylesheet="forgotten_files_in_Hadoop.css"
	options(body_toc='yes'
			toc_type='menu'
			scroll_tables='yes'
			scroll_control_images='yes'
			panelling='yes');


ods layout gridded columns=3 column_gutter=20pct style={background=lightgray};

ods region;
%compare_metadata_and_phys_tables(	Metadata_Library_name="Visual Analytics EPJ Hadoop")

ods region;
%compare_metadata_and_phys_tables(	Metadata_Library_name="Visual Analytics FTV Hadoop")

* ods region;
%compare_metadata_and_phys_tables(	Metadata_Library_name="Visual Analytics LRC Hadoop")

* ods region;
%compare_metadata_and_phys_tables(	Metadata_Library_name="Visual Analytics MetaVision Hadoop")

* ods region;
%compare_metadata_and_phys_tables(	Metadata_Library_name="Visual Analytics Public HDFS")

ods region;
%compare_metadata_and_phys_tables(	Metadata_Library_name="Visual Analytics HDFS")

ods layout end;
ods html close;


/******
data _null_;
	file "/opt/sas/config/Lev1/Web/WebServer/htdocs/adminrapporter/hdfs_vs_metadata/example10.css";
	put "sdlkajfdalsdkfjasdf";
run;

****/