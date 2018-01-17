TODAY=$(date +%Y.%m.%d)
grep '^ERROR:' /SASLOG/BatchServer/Logs/*$TODAY*
more $(grep -l '^ERROR:' /SASLOG/BatchServer/Logs/*$TODAY*)