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



%macro stop_LASR(protokoll=https, server=, LASRport=, signerPort=443, Namn=);


	%put NOTE: ============ Stänger LASR-servern &Namn(&LASRport) ============ ;
	proc lasr	stop
				PORT=&LASRport
				signer="&protokoll://&server:&signerPort/SASLASRAuthorization";
		performance host="&server";
	run;

	%statuscheckpoint(maxokstatus=4, varstocheck=SYSERR SYSDBRC);

%mend stop_LASR;



* Hämtar namnet på lasr-servern från property-fil		;
%get_property(property=lasrserver)



%stop_LASR(server=&lasrserver, LASRport=10011, Namn=LASR Analytic Server - rapport);
%stop_LASR(server=&lasrserver, LASRport=10031, Namn=Public LASR Analytic Server - rapport);
%stop_LASR(server=&lasrserver, LASRport=10015, Namn=EPJ LASR);
%stop_LASR(server=&lasrserver, LASRport=10017, Namn=FTV LASR);
%stop_LASR(server=&lasrserver, LASRport=10016, Namn=LRC LASR);
%stop_LASR(server=&lasrserver, LASRport=10029, Namn=Admin LASR);
%stop_LASR(server=&lasrserver, LASRport=10018, Namn=MetaVision LASR)
