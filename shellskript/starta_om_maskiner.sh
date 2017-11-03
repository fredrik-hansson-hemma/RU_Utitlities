#!/bin/bash

local_host="$(hostname)"
# Tar bort allt efter första punkten
local_host="${local_host%%.*}"

# Loopar igenom servrarna i filen /etc/gridhosts. Kör inte kommandot för local host.
for hst in `tac /etc/gridhosts`
do
	echo 
	if [ "$local_host" != "$hst" ]
	then
		ssh $hst "hostname; echo \ shutdown -r now; shutdown -r now;"
		echo 
	else
		echo "=========================================================================================================================="
		echo "Command was not run for $hst (local host). Local host should have been started manually before running this script.";
		echo "=========================================================================================================================="
	fi
	echo 
done 


ssh bs-ap-19 "hostname; echo \ shutdown -r now; shutdown -r now;"

hostname
echo \ shutdown -r now
shutdown -r now;