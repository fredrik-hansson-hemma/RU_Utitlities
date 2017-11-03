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
				%put %str(ER)ROR: Variabeln &VAR har ett ov�ntat v�rde. Se SAS dokumentation f�r mer information.;
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


	libname test_lib sasiola host="bs-ap-20.lul.se" port=10011 tag='hr';

	* Anropar macro som kollar olika felreturkodsvariabler i SAS		;
	%statuscheckpoint;


	libname test_lib;


%mend start_LASR;



%start_LASR(server=bs-ap-20.lul.se, LASRport=10011, Namn=LASR Analytic Server - bs-ap-20)
%start_LASR(server=bs-ap-20.lul.se, LASRport=10031, Namn=Public LASR Analytic Server - bs-ap-20)
%start_LASR(server=bs-ap-20.lul.se, LASRport=10015, Namn=EPJ LASR)
%start_LASR(server=bs-ap-20.lul.se, LASRport=10017, Namn=FTV LASR)
%start_LASR(server=bs-ap-20.lul.se, LASRport=10016, Namn=LRC LASR)
%start_LASR(server=bs-ap-20.lul.se, LASRport=10029, Namn=Admin LASR)



