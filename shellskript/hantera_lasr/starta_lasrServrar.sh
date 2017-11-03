# Skapar en logg-katalog
mkdir /tmp/RU_Utilities_Loggs 2> /dev/null
chmod -R 777 /tmp/RU_Utilities_Loggs

echo ""
echo "Inleder start av LASR-servrar. Det här kan ta några minuter..."
# Anropar sas-programmet
runuser --login lasradm --command='/opt/sas/config/Lev1/SASApp_VA/BatchServer/sasbatch.sh -sysin /opt/sas/RU_Utitlities/saskod/starta_lasrServrar.sas -log /tmp/RU_Utilities_Loggs/starta_lasrServrar_ -batch -noterminal -PRINT /tmp/RU_Utilities_Loggs/starta_lasrServrar.lst'
# Fånga upp returkoden från SAS-anropet
SAS_RETURN_CODE=$?


echo ""
echo ""
if [ "$SAS_RETURN_CODE" != "0" ]
then
	echo "=========================================================================================================================="
	echo "ERROR: Det verkar som om något gick galet vid uppstarten av LASR-servrarna. Kontrollera den senaste loggfilen för mer info"
	echo "=========================================================================================================================="
	ls -lrt /tmp/RU_Utilities_Loggs/starta_lasrServrar_*
	echo "=========================================================================================================================="
else
	echo "=========================================================================================================================="
	echo "Uppstarten av LASR-servrarna verkar ha gått bra"
	echo "=========================================================================================================================="
fi





# Gör ett litet trick för att sätta skriptets returkod till den returkod som SAS-kommandot gav
(exit $SAS_RETURN_CODE)