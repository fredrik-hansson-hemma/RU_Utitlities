

echo "Försäkra dig om att du är inloggad som root innan du fortsätter."
echo "Avbryt skriptet med Ctrl+C, om du inte är root"
whoami

read -t120 -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om 2 minuter.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key
echo "Starta Hadoop (som hdfs)"
runuser --login hdfs --command='. ~/.bash_profile; $HADOOP_HOME/sbin/start-dfs.sh'




read -t120 -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om 2 minuter.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key
echo "Starta Hadoop yarn deamons (som yarn)"
runuser --login yarn --command='. ~/.bash_profile; $HADOOP_HOME/sbin/start-sas-yarn-cluster.sh'





read -t120 -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om 2 minuter.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key
echo "Starta Hadoop historyserver (som mapred)"
runuser --login mapred --command='. ~/.bash_profile; $HADOOP_HOME/sbin/start-sas-mr-jobhistory.sh'







read -t120 -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om 2 minuter.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key
echo "Starta LASR-monitorn"
runuser --login sas --command='/opt/sas/sashome/SASDeploymentAgent/9.4/agent.sh start'
runuser --login sas --command='/opt/sas/config/Lev1/Applications/SASVisualAnalytics/HighPerformanceConfiguration/LASRMonitor.sh start'






read -t120 -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om 2 minuter.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key
echo "Starta Webservern (som root)"
/opt/sas/config/Lev1/Web/WebServer/bin/httpdctl start





read -t120 -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om 2 minuter.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key
echo "Starta SAS på huvudnoden"
runuser --login sas --command='/opt/sas/config/Lev1/sas.servers start'





read -t120 -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om 2 minuter.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key
echo "Starta SAS på Office Analytics-maskinen"
runuser --login sas --command='ssh bs-ap-19 "/opt/sas/config/Lev1/sas.servers start;"'
runuser --login sas --command='ssh bs-ap-19 "/opt/sas/sashome/SASDeploymentAgent/9.4/agent.sh start;"'




read -t120 -n1 -r -p $'\n\n Tryck Ctrl+C för att avbryta skriptet, annars fortsätter det automatiskt om 2 minuter.\n Tryck Enter om du vill fortsätta utan att vänta.\n\n' key
echo "Starta SAS på övriga noder"
runuser --login sas --command='/opt/sas/config/Lev1/startup_nodes.sh'




echo ""
echo ""
echo "Gå till https://bs-ap-20.lul.se/SASVisualAnalyticsAdministrator/?EVMode=ManageEnvironment&StartupTab=com.sas.adminClient.plugins.dataAcquisition.components.lasrview.Lasr2TableSnapInTab och starta alla LASR-servrar"
