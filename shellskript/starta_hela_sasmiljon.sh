
# Vanligtvis är det en fördröjning på 120 sekunder mellan att man startar olika servrar
FORDROJNING_I_SEKUNDER=120

# ... men man kan skicka in valfri fördröjning som parameter
if [ "$1" -ne "" ]
then
	FORDROJNING_I_SEKUNDER=$1
fi



echo
echo
echo
echo

# Sökväg till egenutvecklade skriptet (RU=Region Uppsala)
export RU_PATH=/opt/sas/RU_Utitlities


echo "Du startar nu SAS-miljön på: $(hostname)"



echo "Försäkra dig om att du är inloggad som root innan du fortsätter."
echo "Avbryt skriptet med Ctrl+C, om du inte är root"
echo "Du är inloggad som $(whoami) på ${THIS_MACHINE}"

echo ""
echo ""

echo "Nästa steg är att rensa några temp-kataloger"
read -t$FORDROJNING_I_SEKUNDER -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om $FORDROJNING_I_SEKUNDER sekunder.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key
SASCONFIG=/opt/sas/config/Lev1
rm -rf $SASCONFIG/Web/WebAppServer/SASServer*_1/temp/*
rm -rf $SASCONFIG/Web/WebAppServer/SASServer*_1/work/Catalina/localhost/*
rm -rf $SASCONFIG/Web/WebAppServer/SASServer*_1/logs/tmlog*.log



read -t$FORDROJNING_I_SEKUNDER -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om $FORDROJNING_I_SEKUNDER sekunder.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key
echo "Starta Hadoop (som hdfs)"
runuser --login hdfs --command='. ~/.bash_profile; $HADOOP_HOME/sbin/start-dfs.sh'




read -t$FORDROJNING_I_SEKUNDER -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om $FORDROJNING_I_SEKUNDER sekunder.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key
echo "Starta Hadoop yarn deamons (som yarn)"
runuser --login yarn --command='. ~/.bash_profile; $HADOOP_HOME/sbin/start-sas-yarn-cluster.sh'





read -t$FORDROJNING_I_SEKUNDER -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om $FORDROJNING_I_SEKUNDER sekunder.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key
echo "Starta Hadoop historyserver (som mapred)"
runuser --login mapred --command='. ~/.bash_profile; $HADOOP_HOME/sbin/start-sas-mr-jobhistory.sh'







read -t$FORDROJNING_I_SEKUNDER -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om $FORDROJNING_I_SEKUNDER sekunder.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key
echo "Starta LASR-monitorn"
runuser --login sas --command='/opt/sas/sashome/SASDeploymentAgent/9.4/agent.sh start'
runuser --login sas --command='/opt/sas/config/Lev1/Applications/SASVisualAnalytics/HighPerformanceConfiguration/LASRMonitor.sh start'






read -t$FORDROJNING_I_SEKUNDER -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om $FORDROJNING_I_SEKUNDER sekunder.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key
echo "Starta Webservern (som root)"
/opt/sas/config/Lev1/Web/WebServer/bin/httpdctl start





read -t$FORDROJNING_I_SEKUNDER -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om $FORDROJNING_I_SEKUNDER sekunder.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key
echo "Starta SAS på huvudnoden"
runuser --login sas --command='/opt/sas/config/Lev1/sas.servers start'





read -t$FORDROJNING_I_SEKUNDER -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om $FORDROJNING_I_SEKUNDER sekunder.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key
echo "Starta SAS på Office Analytics-maskinen"
# Hämtar namnet på OA-servern från en properties-fil.
OA_ENVIRONMENT=$(/opt/sas/RU_Utitlities/shellskript/get_property.sh oaserver)
runuser --login sas --command="ssh $OA_ENVIRONMENT '/opt/sas/config/Lev1/sas.servers start;'"
runuser --login sas --command="ssh $OA_ENVIRONMENT '/opt/sas/sashome/SASDeploymentAgent/9.4/agent.sh start;'"




read -t$FORDROJNING_I_SEKUNDER -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om $FORDROJNING_I_SEKUNDER sekunder.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key
echo "Starta SAS på övriga noder"
runuser --login sas --command="$RU_PATH/shellskript/sasprocesser_pa_noder/startup_nodes.sh"




read -t$FORDROJNING_I_SEKUNDER -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om $FORDROJNING_I_SEKUNDER sekunder.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key
echo "Starta LASR-servrarna (som lasradm)"
# Det här skriptet innehåller ett "runuser"-kommando. Stängningen av LASR-servrarna kommer göras av användaren "lasradm"
$RU_PATH/shellskript/hantera_lasr/starta_lasrServrar.sh




# Här behöver man lägga till skript som laddar LASR-servrarna med data från hadoop
