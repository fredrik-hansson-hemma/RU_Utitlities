######################################################################################################
# Exportera servrar manuellt (om det behövs)
# Se katalogen /System/Servers/
######################################################################################################



######################################################################################################
# Exporterar "security objects" (except users)
######################################################################################################

outfile=Security_except_users
/opt/sas/sashome/SASPlatformObjectFramework/9.4/ExportPackage  \
 -profile "SASAdmin"  \
 -package "/home/sas/flytt_av_metadata/paket/$outfile.spk"  \
 -log $outfile.log \
 -objects "/System/Security/User Groups" "/System/Security/Roles" "/System/Security/Authentication Domains" "/System/Security/Access Control Templates" \
 -subprop  \
 -includeDep \
 -includeEmptyFolders

 
######################################################################################################
# Exporterar users
######################################################################################################

outfile=users
/opt/sas/sashome/SASPlatformObjectFramework/9.4/ExportPackage  \
 -profile "SASAdmin"  \
 -package "/home/sas/flytt_av_metadata/paket/$outfile.spk"  \
 -log $outfile.log \
 -objects "/System/Security/Users" \
 -subprop  \
 -includeDep \
 -includeEmptyFolders
  


######################################################################################################
# Exporterar libnames (Importera dessa manuellt!)
######################################################################################################
outfile=Libraries
/opt/sas/sashome/SASPlatformObjectFramework/9.4/ExportPackage \
 -profile "SASAdmin" \
 -package "/home/sas/flytt_av_metadata/paket/$outfile.spk"  \
 -log $outfile.log \
 -objects "/" \
 -subprop \
 -includeDep \
 -types "Library"
 
 



######################################################################################################
# Exportera utvalda kataloger. Alla typer utom libnames
######################################################################################################
  
# Nastan_allt_ej_libraries_ej_dependecies.spk en katalog åt gången
outfile=Nastan_allt_ej_libraries_ej_dependecies_LUL
/opt/sas/sashome/SASPlatformObjectFramework/9.4/ExportPackage \
 -profile "SASAdmin" \
 -package "/home/sas/flytt_av_metadata/paket/$outfile.spk"  \
 -log $outfile.log \
 -objects "/LUL" \
 -subprop \
 -types "BusinessRuleFlow,CommonTaskTemplate,CommonTaskModel,Note,User,UserGroup,Server.Aster,AuthenticationDomain,DecisionLogic,VisualExplorationDataSource,VisualExplorationData,DataExploration,Server.DB2UNXPC,Server.DB2zOS,SharedDimension,Document,Server.ESRIMap,ExternalFile,FavoritesFolder,DocumentCSV,Prompt,PromptGroup,Server.Ftp,GeneratedTransform,GraphTemplate,Server.Greenplum,GridOptionsSet,Server.GridMonitor,Server.Hadoop,Server.Hawq,Server.Http,EventSubscriber,SubscriberGroup.Event,Server.Impala,InformationMap.OLAP,InformationMap.Relational,Server.Informix,ContentSubscriber,SubscriberGroup.Content,JMSDestination,Job,Job.CubeBuild,CodeSnippet,Cube,MQM.JMS,MQM.MSMQ,MQM.Websphere,StoredProcess,Report.StoredProcess,Server.LASR,LogicalServer.Federation,MessageQueue,DocumentMSExcel,Project.AMOExcel,Server.MsExcel,DocumentMSPowerPoint,Project.AMOPowerPoint,Server.MsSQLUnix,DocumentMSWord,Project.AMOWord,Server.MySQL,Server.Neoview,Server.Netezza,Spawner.IOM,Server.ODBC,OLAPSchema,Server.OLEDB,Server.Oozie,Server.Oracle,DocumentPDF,Server.PiAssetFramework,Server.PIsystem,Server.Postgres,Application,ApplicationServer,ProxyList,Channel,Server.Redshift,Role,Server.HANA,Server.SAP,Spawner.Connect,Server.SASDistributedInProcess,Project.EG,Server.SASInProcess,Server.SPDS,Server.SASInfrastructureData,Report,Report.BI,BIReportGallery,BIReportTemplate,Report.Image,Report.Component,Server.Share,Server.OSScheduler,Server.PlatformProcessManager,Server.MQPolling,DeployedFlow,DeployedJob,Server.SybaseIQ,Server.Sybase,SecuredLibrary,SearchFolder,Table,Server.Teradata,BurstDefinition,MiningResults,Server.Vertica,Condition,ConditionActionSet,VisualStatisticsProject,VisualDataQuery,VisualExploration,VisualExplorationEntity,Service.SoapGenerated,Action,ACT,DocumentCSS"
 

outfile=Nastan_allt_ej_libraries_ej_dependecies_LUL_gemensam
/opt/sas/sashome/SASPlatformObjectFramework/9.4/ExportPackage \
 -profile "SASAdmin" \
 -package "/home/sas/flytt_av_metadata/paket/$outfile.spk"  \
 -log $outfile.log \
 -objects "/LUL gemensam" \
 -subprop \
 -types "BusinessRuleFlow,CommonTaskTemplate,CommonTaskModel,Note,User,UserGroup,Server.Aster,AuthenticationDomain,DecisionLogic,VisualExplorationDataSource,VisualExplorationData,DataExploration,Server.DB2UNXPC,Server.DB2zOS,SharedDimension,Document,Server.ESRIMap,ExternalFile,FavoritesFolder,DocumentCSV,Prompt,PromptGroup,Server.Ftp,GeneratedTransform,GraphTemplate,Server.Greenplum,GridOptionsSet,Server.GridMonitor,Server.Hadoop,Server.Hawq,Server.Http,EventSubscriber,SubscriberGroup.Event,Server.Impala,InformationMap.OLAP,InformationMap.Relational,Server.Informix,ContentSubscriber,SubscriberGroup.Content,JMSDestination,Job,Job.CubeBuild,CodeSnippet,Cube,MQM.JMS,MQM.MSMQ,MQM.Websphere,StoredProcess,Report.StoredProcess,Server.LASR,LogicalServer.Federation,MessageQueue,DocumentMSExcel,Project.AMOExcel,Server.MsExcel,DocumentMSPowerPoint,Project.AMOPowerPoint,Server.MsSQLUnix,DocumentMSWord,Project.AMOWord,Server.MySQL,Server.Neoview,Server.Netezza,Spawner.IOM,Server.ODBC,OLAPSchema,Server.OLEDB,Server.Oozie,Server.Oracle,DocumentPDF,Server.PiAssetFramework,Server.PIsystem,Server.Postgres,Application,ApplicationServer,ProxyList,Channel,Server.Redshift,Role,Server.HANA,Server.SAP,Spawner.Connect,Server.SASDistributedInProcess,Project.EG,Server.SASInProcess,Server.SPDS,Server.SASInfrastructureData,Report,Report.BI,BIReportGallery,BIReportTemplate,Report.Image,Report.Component,Server.Share,Server.OSScheduler,Server.PlatformProcessManager,Server.MQPolling,DeployedFlow,DeployedJob,Server.SybaseIQ,Server.Sybase,SecuredLibrary,SearchFolder,Table,Server.Teradata,BurstDefinition,MiningResults,Server.Vertica,Condition,ConditionActionSet,VisualStatisticsProject,VisualDataQuery,VisualExploration,VisualExplorationEntity,Service.SoapGenerated,Action,ACT,DocumentCSS"
 

outfile=Nastan_allt_ej_libraries_ej_dependecies_Rapporter_mm
/opt/sas/sashome/SASPlatformObjectFramework/9.4/ExportPackage \
 -profile "SASAdmin" \
 -package "/home/sas/flytt_av_metadata/paket/$outfile.spk"  \
 -log $outfile.log \
 -objects "Rapporter under annat innehåll" \
 -subprop \
 -types "BusinessRuleFlow,CommonTaskTemplate,CommonTaskModel,Note,User,UserGroup,Server.Aster,AuthenticationDomain,DecisionLogic,VisualExplorationDataSource,VisualExplorationData,DataExploration,Server.DB2UNXPC,Server.DB2zOS,SharedDimension,Document,Server.ESRIMap,ExternalFile,FavoritesFolder,DocumentCSV,Prompt,PromptGroup,Server.Ftp,GeneratedTransform,GraphTemplate,Server.Greenplum,GridOptionsSet,Server.GridMonitor,Server.Hadoop,Server.Hawq,Server.Http,EventSubscriber,SubscriberGroup.Event,Server.Impala,InformationMap.OLAP,InformationMap.Relational,Server.Informix,ContentSubscriber,SubscriberGroup.Content,JMSDestination,Job,Job.CubeBuild,CodeSnippet,Cube,MQM.JMS,MQM.MSMQ,MQM.Websphere,StoredProcess,Report.StoredProcess,Server.LASR,LogicalServer.Federation,MessageQueue,DocumentMSExcel,Project.AMOExcel,Server.MsExcel,DocumentMSPowerPoint,Project.AMOPowerPoint,Server.MsSQLUnix,DocumentMSWord,Project.AMOWord,Server.MySQL,Server.Neoview,Server.Netezza,Spawner.IOM,Server.ODBC,OLAPSchema,Server.OLEDB,Server.Oozie,Server.Oracle,DocumentPDF,Server.PiAssetFramework,Server.PIsystem,Server.Postgres,Application,ApplicationServer,ProxyList,Channel,Server.Redshift,Role,Server.HANA,Server.SAP,Spawner.Connect,Server.SASDistributedInProcess,Project.EG,Server.SASInProcess,Server.SPDS,Server.SASInfrastructureData,Report,Report.BI,BIReportGallery,BIReportTemplate,Report.Image,Report.Component,Server.Share,Server.OSScheduler,Server.PlatformProcessManager,Server.MQPolling,DeployedFlow,DeployedJob,Server.SybaseIQ,Server.Sybase,SecuredLibrary,SearchFolder,Table,Server.Teradata,BurstDefinition,MiningResults,Server.Vertica,Condition,ConditionActionSet,VisualStatisticsProject,VisualDataQuery,VisualExploration,VisualExplorationEntity,Service.SoapGenerated,Action,ACT,DocumentCSS"
 

outfile=Nastan_allt_ej_libraries_ej_dependecies_Shared_Data
/opt/sas/sashome/SASPlatformObjectFramework/9.4/ExportPackage \
 -profile "SASAdmin" \
 -package "/home/sas/flytt_av_metadata/paket/$outfile.spk"  \
 -log $outfile.log \
 -objects "Shared Data" \
 -subprop \
 -types "BusinessRuleFlow,CommonTaskTemplate,CommonTaskModel,Note,User,UserGroup,Server.Aster,AuthenticationDomain,DecisionLogic,VisualExplorationDataSource,VisualExplorationData,DataExploration,Server.DB2UNXPC,Server.DB2zOS,SharedDimension,Document,Server.ESRIMap,ExternalFile,FavoritesFolder,DocumentCSV,Prompt,PromptGroup,Server.Ftp,GeneratedTransform,GraphTemplate,Server.Greenplum,GridOptionsSet,Server.GridMonitor,Server.Hadoop,Server.Hawq,Server.Http,EventSubscriber,SubscriberGroup.Event,Server.Impala,InformationMap.OLAP,InformationMap.Relational,Server.Informix,ContentSubscriber,SubscriberGroup.Content,JMSDestination,Job,Job.CubeBuild,CodeSnippet,Cube,MQM.JMS,MQM.MSMQ,MQM.Websphere,StoredProcess,Report.StoredProcess,Server.LASR,LogicalServer.Federation,MessageQueue,DocumentMSExcel,Project.AMOExcel,Server.MsExcel,DocumentMSPowerPoint,Project.AMOPowerPoint,Server.MsSQLUnix,DocumentMSWord,Project.AMOWord,Server.MySQL,Server.Neoview,Server.Netezza,Spawner.IOM,Server.ODBC,OLAPSchema,Server.OLEDB,Server.Oozie,Server.Oracle,DocumentPDF,Server.PiAssetFramework,Server.PIsystem,Server.Postgres,Application,ApplicationServer,ProxyList,Channel,Server.Redshift,Role,Server.HANA,Server.SAP,Spawner.Connect,Server.SASDistributedInProcess,Project.EG,Server.SASInProcess,Server.SPDS,Server.SASInfrastructureData,Report,Report.BI,BIReportGallery,BIReportTemplate,Report.Image,Report.Component,Server.Share,Server.OSScheduler,Server.PlatformProcessManager,Server.MQPolling,DeployedFlow,DeployedJob,Server.SybaseIQ,Server.Sybase,SecuredLibrary,SearchFolder,Table,Server.Teradata,BurstDefinition,MiningResults,Server.Vertica,Condition,ConditionActionSet,VisualStatisticsProject,VisualDataQuery,VisualExploration,VisualExplorationEntity,Service.SoapGenerated,Action,ACT,DocumentCSS"
 

outfile=Nastan_allt_ej_libraries_ej_dependecies_User_Folders
/opt/sas/sashome/SASPlatformObjectFramework/9.4/ExportPackage \
 -profile "SASAdmin" \
 -package "/home/sas/flytt_av_metadata/paket/$outfile.spk"  \
 -log $outfile.log \
 -objects "User Folders" \
 -subprop \
 -types "BusinessRuleFlow,CommonTaskTemplate,CommonTaskModel,Note,User,UserGroup,Server.Aster,AuthenticationDomain,DecisionLogic,VisualExplorationDataSource,VisualExplorationData,DataExploration,Server.DB2UNXPC,Server.DB2zOS,SharedDimension,Document,Server.ESRIMap,ExternalFile,FavoritesFolder,DocumentCSV,Prompt,PromptGroup,Server.Ftp,GeneratedTransform,GraphTemplate,Server.Greenplum,GridOptionsSet,Server.GridMonitor,Server.Hadoop,Server.Hawq,Server.Http,EventSubscriber,SubscriberGroup.Event,Server.Impala,InformationMap.OLAP,InformationMap.Relational,Server.Informix,ContentSubscriber,SubscriberGroup.Content,JMSDestination,Job,Job.CubeBuild,CodeSnippet,Cube,MQM.JMS,MQM.MSMQ,MQM.Websphere,StoredProcess,Report.StoredProcess,Server.LASR,LogicalServer.Federation,MessageQueue,DocumentMSExcel,Project.AMOExcel,Server.MsExcel,DocumentMSPowerPoint,Project.AMOPowerPoint,Server.MsSQLUnix,DocumentMSWord,Project.AMOWord,Server.MySQL,Server.Neoview,Server.Netezza,Spawner.IOM,Server.ODBC,OLAPSchema,Server.OLEDB,Server.Oozie,Server.Oracle,DocumentPDF,Server.PiAssetFramework,Server.PIsystem,Server.Postgres,Application,ApplicationServer,ProxyList,Channel,Server.Redshift,Role,Server.HANA,Server.SAP,Spawner.Connect,Server.SASDistributedInProcess,Project.EG,Server.SASInProcess,Server.SPDS,Server.SASInfrastructureData,Report,Report.BI,BIReportGallery,BIReportTemplate,Report.Image,Report.Component,Server.Share,Server.OSScheduler,Server.PlatformProcessManager,Server.MQPolling,DeployedFlow,DeployedJob,Server.SybaseIQ,Server.Sybase,SecuredLibrary,SearchFolder,Table,Server.Teradata,BurstDefinition,MiningResults,Server.Vertica,Condition,ConditionActionSet,VisualStatisticsProject,VisualDataQuery,VisualExploration,VisualExplorationEntity,Service.SoapGenerated,Action,ACT,DocumentCSS"




######################################################################################################
# Exporterar "SharedCollections"
######################################################################################################
outfile=SAS_Visual_Analytics_Hub
/opt/sas/sashome/SASPlatformObjectFramework/9.4/ExportPackage \
 -profile "SASAdmin" \
 -package "/home/sas/flytt_av_metadata/paket/$outfile.spk" \
 -log $outfile.log \
 -objects "/System/Applications/SAS Visual Analytics Hub" \
 -subprop \
 -includeDep
 


 
######################################################################################################
# Exporterar senaste veckans ändringar i katalogen /Shared Data/Batchjobb/Schemalagda
#  subprop:		skapar en extern fil med "Substitution Properties"
#  noexecute:	Skapar ingen fil. Skriver bara ut info. Bra för testning av kommandot.
######################################################################################################

# Sätter dagens datum
#DAGENS_DATUM=`date +%Y-%m-%d`

# /opt/sas/sashome/SASPlatformObjectFramework/9.4/ExportPackage \
#  -profile "SASAdmin" \
#  -package "/home/sas/flytt_av_metadata/paket/Shared Data.Batchjobb.Schemalagda_$DAGENS_DATUM.spk" \
#  -objects "/Shared Data/Batchjobb/Schemalagda" \
#  -includeDep \
#  -since "Week to date" \
#  -modified \
#  -subprop \
#  -includeEmptyFolders \
#  -disableX11 \
#  -noexecute
