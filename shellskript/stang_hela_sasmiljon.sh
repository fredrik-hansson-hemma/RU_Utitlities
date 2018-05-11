
# Vanligtvis är det en fördröjning på 120 sekunder mellan att man startar olika servrar
FORDROJNING_I_SEKUNDER=120

# ... men man kan skicka in valfri fördröjning som parameter
if [ "$1" -ne "" ]
then
	FORDROJNING_I_SEKUNDER=$1
fi


# Sökväg till egenutvecklade skriptet (RU=Region Uppsala)
export RU_PATH=/opt/sas/RU_Utitlities



echo "Försäkra dig om att du är inloggad som root innan du fortsätter."
echo "Avbryt skriptet med Ctrl+C, om du inte är root"
echo "Du är inloggad som:"
whoami

echo ""

# Sätter miljövariabler beroende på om man kör i test eller prod. Informationen borde hellre läsas från en config-fil!
THIS_MACHINE="$(hostname)"
if [ "${THIS_MACHINE}" = "bs-ap-20.lul.se" ]
then
    OA_ENVIRONMENT=bs-ap-19
elif [ "${THIS_MACHINE}" = "bst-apx-20.lul.se" ]
then
    OA_ENVIRONMENT=bst-apx-19
else
    echo "Unknown host ${THIS_MACHINE}"
fi

echo "THIS_MACHINE: ${THIS_MACHINE}"


read -t$FORDROJNING_I_SEKUNDER -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om $FORDROJNING_I_SEKUNDER sekunder.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key




echo "Stänger ner LASR-servrarna (som lasradm)"
# Det här skriptet innehåller ett "runuser"-kommando. Stängningen av LASR-servrarna kommer göras av användaren "lasradm"
$RU_PATH/shellskript/hantera_lasr/stang_av_lasrServrar.sh








read -t$FORDROJNING_I_SEKUNDER -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om $FORDROJNING_I_SEKUNDER sekunder.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key

echo "Stänger ner noderna"
runuser --login sas --command="$RU_PATH/shellskript/sasprocesser_pa_noder/shutdown_nodes.sh"







read -t$FORDROJNING_I_SEKUNDER -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om $FORDROJNING_I_SEKUNDER sekunder.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key

echo 'Stäng ner Office Analytics-delarna'
runuser --login sas --command="ssh $OA_ENVIRONMENT '/opt/sas/config/Lev1/sas.servers stop;'"
runuser --login sas --command="ssh $OA_ENVIRONMENT '/opt/sas/sashome/SASDeploymentAgent/9.4/agent.sh stop;'"







read -t$FORDROJNING_I_SEKUNDER -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om $FORDROJNING_I_SEKUNDER sekunder.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key

echo "Stäng ner SAS på huvudnoden"
runuser --login sas --command='/opt/sas/config/Lev1/sas.servers stop'




read -t$FORDROJNING_I_SEKUNDER -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om $FORDROJNING_I_SEKUNDER sekunder.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key

echo "Stäng av webservern (som root)"
/opt/sas/config/Lev1/Web/WebServer/bin/httpdctl stop




read -t$FORDROJNING_I_SEKUNDER -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om $FORDROJNING_I_SEKUNDER sekunder.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key
echo "Stäng av LASR-monitorn"
runuser --login sas --command='/opt/sas/config/Lev1/Applications/SASVisualAnalytics/HighPerformanceConfiguration/LASRMonitor.sh stop'
runuser --login sas --command='/opt/sas/sashome/SASDeploymentAgent/9.4/agent.sh stop'



read -t$FORDROJNING_I_SEKUNDER -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om $FORDROJNING_I_SEKUNDER sekunder.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key
echo "Stäng av Hadoop historyserver som mapred"
runuser --login mapred --command='. ~/.bash_profile; $HADOOP_HOME/sbin/stop-sas-mr-jobhistory.sh'



read -t$FORDROJNING_I_SEKUNDER -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om $FORDROJNING_I_SEKUNDER sekunder.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key
echo "Stäng av Hadoop yarn deamons som yarn"
runuser --login yarn --command='. ~/.bash_profile; $HADOOP_HOME/sbin/stop-sas-yarn-cluster.sh'


read -t$FORDROJNING_I_SEKUNDER -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om $FORDROJNING_I_SEKUNDER sekunder.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key
echo "Stäng av Hadoop som hdfs"
runuser --login hdfs --command='. ~/.bash_profile; $HADOOP_HOME/sbin/stop-dfs.sh'


echo ""
echo ""
echo "Om allt har fungerat som det skulle, är all SAS-relaterad programvara nedstängd nu."
