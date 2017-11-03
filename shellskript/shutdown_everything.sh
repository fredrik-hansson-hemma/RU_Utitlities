

echo "Försäkra dig om att du är inloggad som root innan du fortsätter."
echo "Avbryt skriptet med Ctrl+C, om du inte är root"
whoami


echo ""
echo "Gå till https://bs-ap-20.lul.se/SASVisualAnalyticsAdministrator/?EVMode=ManageEnvironment&StartupTab=com.sas.adminClient.plugins.dataAcquisition.components.lasrview.Lasr2TableSnapInTab och stäng alla LASR-servrar"

read -n1 -r -p $'\n\n Tryck Enter när Du är klar,\n Tryck Ctrl+C om Du vill avbryta.\n\n' key


echo "Stänger ner noderna"
runuser --login sas --command='/opt/sas/config/Lev1/shutdown_nodes.sh'







read -t120 -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om 2 minuter.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key

echo 'Stäng ner Office Analytics-delarna'
runuser --login sas --command='ssh bs-ap-19 "/opt/sas/config/Lev1/sas.servers stop;"'
runuser --login sas --command='ssh bs-ap-19 "/opt/sas/sashome/SASDeploymentAgent/9.4/agent.sh stop;"'







read -t120 -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om 2 minuter.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key

echo "Stäng ner SAS på huvudnoden"
runuser --login sas --command='/opt/sas/config/Lev1/sas.servers stop'




read -t120 -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om 2 minuter.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key

echo "Stäng av webservern (som root)"
/opt/sas/config/Lev1/Web/WebServer/bin/httpdctl stop




read -t120 -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om 2 minuter.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key
echo "Stäng av LASR-monitorn"
runuser --login sas --command='/opt/sas/config/Lev1/Applications/SASVisualAnalytics/HighPerformanceConfiguration/LASRMonitor.sh stop'
runuser --login sas --command='/opt/sas/sashome/SASDeploymentAgent/9.4/agent.sh stop'



read -t120 -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om 2 minuter.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key
echo "Stäng av Hadoop historyserver som mapred"
runuser --login mapred --command='. ~/.bash_profile; $HADOOP_HOME/sbin/stop-sas-mr-jobhistory.sh'



read -t120 -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om 2 minuter.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key
echo "Stäng av Hadoop yarn deamons som yarn"
runuser --login yarn --command='. ~/.bash_profile; $HADOOP_HOME/sbin/stop-sas-yarn-cluster.sh'


read -t120 -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om 2 minuter.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key
echo "Stäng av Hadoop som hdfs"
runuser --login hdfs --command='. ~/.bash_profile; $HADOOP_HOME/sbin/stop-dfs.sh'


echo ""
echo ""
echo "Om allt har fungerat som det skulle, är all SAS-relaterad programvara nedstängd nu."