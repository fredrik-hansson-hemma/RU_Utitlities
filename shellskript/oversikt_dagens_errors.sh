TODAY=$(date +%Y.%m.%d)
echo  
echo "Söker efter filer vars namn innehåller $TODAY och som innehåller rader som börjar med ERROR:"
echo  
grep '^ERROR:' /SASLOG/BatchServer/Logs/*$TODAY*
if [ $? -ne "0" ]
then
	echo "Hurra! Inga fel i dagens loggar!"
else
	more $(grep -l '^ERROR:' /SASLOG/BatchServer/Logs/*$TODAY*)
fi

echo  
