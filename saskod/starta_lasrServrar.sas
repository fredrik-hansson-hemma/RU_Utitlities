

/* Status Checkpoint Macro */
%macro statuscheckpoint(maxokstatus=4, varstocheck=SYSERR SYSLIBRC SYSDBRC );
	%GLOBAL LASTSTEPRC;
	%LET pos=1;
	%let var=notset;
	%let var=%SCAN(&varstocheck.,&pos.);

	%DO %WHILE ("&VAR." ne "");
		/* Retrieve the next return code to check */
		%if (%symexist(&VAR.)) %then %do;
			%let val=&&&VAR..;

			%if (("&VAL." ne "") and %eval(&VAL. > &maxokstatus.)) %then %do;
				%put %str(ER)ROR: Variabeln &VAR har ett oväntat värde. Se SAS dokumentation för mer information.;
				%put FAIL = &VAR.=&VAL. / SYSCC=&SYSCC.;
				%let LASTSTEPRC=&VAL.;
			%end;
		%end;
		%let pos = %eval(&pos.+1);
		%let var=%SCAN(&varstocheck.,&pos.);
	%END;
%mend;
%statuscheckpoint;





%macro start_LASR(protokoll=https, server=, LASRport=, signerPort=443, Namn=);
	
	%put NOTE: ============ Startar LASR-servern &Namn(&LASRport) ============ ;

	proc lasr create PORT=&LASRport
		path="/opt/sas/sigfiles"
		signer="&protokoll://&server:&signerPort/SASLASRAuthorization"
		tablemem=80;

		performance host="&server"
			install="/opt/sas/TKGrid"
			nodes=ALL;
	run;


	libname test_lib sasiola host="rapport.lul.se" port=&LASRport tag='test';

	* Anropar macro som kollar olika felreturkodsvariabler i SAS		;
	%statuscheckpoint;


	libname test_lib;


%mend start_LASR;

* Hämtar namnet på lasr-servern från property-fil		;
%get_property(property=lasrserver)


options locale="sv_SE";

%put Observera att alla LASR-servrar (tyvärr) inte finns i test-mijön.		;
%put Det gör att det här programmet kan fallera när det körs i testmiljön.	;

%start_LASR(server=&lasrserver, LASRport=10011, Namn=LASR Analytic Server - rapport)
%start_LASR(server=&lasrserver, LASRport=10031, Namn=Public LASR Analytic Server - rapport)
%start_LASR(server=&lasrserver, LASRport=10015, Namn=EPJ LASR)
%start_LASR(server=&lasrserver, LASRport=10017, Namn=FTV LASR)
%start_LASR(server=&lasrserver, LASRport=10016, Namn=LRC LASR)
%start_LASR(server=&lasrserver, LASRport=10029, Namn=Admin LASR)
%start_LASR(server=&lasrserver, LASRport=10018, Namn=MetaVision LASR)
