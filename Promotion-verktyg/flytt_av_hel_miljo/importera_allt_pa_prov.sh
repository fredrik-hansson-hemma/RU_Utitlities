# Innan man kör skarpt:
# 1. Ta bort -noexecute (och backslashen innan)
# 2. Aktivera backuperna






######################################################################################################
# Importerar "security objects" (including users, user groups, roles, and ACTs)
# Antingen får man göra det här manuellt och exkludera användarkatalogen, eller så 
# får vi gör om exporten så att den bara tar med mapparna:
#	/SAS Folders/System/Security/User Groups
#	/System/Security/Roles
#	/System/Security/Authentication Domains
#	/System/Security/Access Control Templatesom den här, 
######################################################################################################

# file=Security
# /opt/sas/sashome/SASPlatformObjectFramework/9.4/ImportPackage \
#  -profile "SASAdmin" \
#  -package "/home/sas/flytt_av_metadata/paket/$file.spk" \
#  -log "/home/sas/flytt_av_metadata/$file.log" \
#  -target "/" \
#  -preservePaths \
#  -includeACL \
#  -subprop "/home/sas/flytt_av_metadata/paket/$file.subprop" \
#  -noexecute


# Gör en backup mellan varje steg. Det kan vara bra att ha en backup att gå tillbaka till om något går fel, men framförallt
# sväller metadatakatalogen enormt i samband med import av stora mängder metadata. Detta rättas till om man kör "-reorganize".
# datetime=DAGENS_DATUM=`date +%Y-%m-%d_%H_%M`
# /opt/sas/sashome/SASPlatformObjectFramework/9.4/tools/admin/sas-backup-metadata -reorg -log "/SASLOG/import_av_metadata/backup_och_reorg_$datetime.log"




# file=Libraries	---		Den här behöver vi inte ta en gång till




file=Nastan_allt_ej_libraries_ej_dependecies_LUL
/opt/sas/sashome/SASPlatformObjectFramework/9.4/ImportPackage \
 -profile "SASAdmin" \
 -package "/home/sas/flytt_av_metadata/paket/$file.spk" \
 -log "/home/sas/flytt_av_metadata/$file.log" \
 -target "/" \
 -preservePaths \
 -includeACL \
 -subprop "/home/sas/flytt_av_metadata/paket/$file.subprop" \
 -noexecute


# Gör en backup mellan varje steg. Det kan vara bra att ha en backup att gå tillbaka till om något går fel, men framförallt
# sväller metadatakatalogen enormt i samband med import av stora mängder metadata. Detta rättas till om man kör "-reorganize".
datetime=DAGENS_DATUM=`date +%Y-%m-%d_%H_%M`
# /opt/sas/sashome/SASPlatformObjectFramework/9.4/tools/admin/sas-backup-metadata -reorg -log "/SASLOG/import_av_metadata/backup_och_reorg_$datetime.log"





 
file=Nastan_allt_ej_libraries_ej_dependecies_LUL_gemensam
/opt/sas/sashome/SASPlatformObjectFramework/9.4/ImportPackage \
 -profile "SASAdmin" \
 -package "/home/sas/flytt_av_metadata/paket/$file.spk" \
 -log "/home/sas/flytt_av_metadata/$file.log" \
 -target "/" \
 -preservePaths \
 -includeACL \
 -subprop "/home/sas/flytt_av_metadata/paket/$file.subprop" \
 -noexecute


# Gör en backup mellan varje steg. Det kan vara bra att ha en backup att gå tillbaka till om något går fel, men framförallt
# sväller metadatakatalogen enormt i samband med import av stora mängder metadata. Detta rättas till om man kör "-reorganize".
datetime=DAGENS_DATUM=`date +%Y-%m-%d_%H_%M`
# /opt/sas/sashome/SASPlatformObjectFramework/9.4/tools/admin/sas-backup-metadata -reorg -log "/SASLOG/import_av_metadata/backup_och_reorg_$datetime.log"




 
 
file=Nastan_allt_ej_libraries_ej_dependecies_Rapporter_mm
/opt/sas/sashome/SASPlatformObjectFramework/9.4/ImportPackage \
 -profile "SASAdmin" \
 -package "/home/sas/flytt_av_metadata/paket/$file.spk" \
 -log "/home/sas/flytt_av_metadata/$file.log" \
 -target "/" \
 -preservePaths \
 -includeACL \
 -subprop "/home/sas/flytt_av_metadata/paket/$file.subprop" \
 -noexecute


# Gör en backup mellan varje steg. Det kan vara bra att ha en backup att gå tillbaka till om något går fel, men framförallt
# sväller metadatakatalogen enormt i samband med import av stora mängder metadata. Detta rättas till om man kör "-reorganize".
datetime=DAGENS_DATUM=`date +%Y-%m-%d_%H_%M`
# /opt/sas/sashome/SASPlatformObjectFramework/9.4/tools/admin/sas-backup-metadata -reorg -log "/SASLOG/import_av_metadata/backup_och_reorg_$datetime.log"




 
 
file=Nastan_allt_ej_libraries_ej_dependecies_Shared_Data
/opt/sas/sashome/SASPlatformObjectFramework/9.4/ImportPackage \
 -profile "SASAdmin" \
 -package "/home/sas/flytt_av_metadata/paket/$file.spk" \
 -log "/home/sas/flytt_av_metadata/$file.log" \
 -target "/" \
 -preservePaths \
 -includeACL \
 -subprop "/home/sas/flytt_av_metadata/paket/$file.subprop" \
 -noexecute


# Gör en backup mellan varje steg. Det kan vara bra att ha en backup att gå tillbaka till om något går fel, men framförallt
# sväller metadatakatalogen enormt i samband med import av stora mängder metadata. Detta rättas till om man kör "-reorganize".
datetime=DAGENS_DATUM=`date +%Y-%m-%d_%H_%M`
# /opt/sas/sashome/SASPlatformObjectFramework/9.4/tools/admin/sas-backup-metadata -reorg -log "/SASLOG/import_av_metadata/backup_och_reorg_$datetime.log"




 
 
file=Nastan_allt_ej_libraries_ej_dependecies_User_Folders
/opt/sas/sashome/SASPlatformObjectFramework/9.4/ImportPackage \
 -profile "SASAdmin" \
 -package "/home/sas/flytt_av_metadata/paket/$file.spk" \
 -log "/home/sas/flytt_av_metadata/$file.log" \
 -target "/" \
 -preservePaths \
 -includeACL \
 -subprop "/home/sas/flytt_av_metadata/paket/$file.subprop" \
 -noexecute


# Gör en backup mellan varje steg. Det kan vara bra att ha en backup att gå tillbaka till om något går fel, men framförallt
# sväller metadatakatalogen enormt i samband med import av stora mängder metadata. Detta rättas till om man kör "-reorganize".
datetime=DAGENS_DATUM=`date +%Y-%m-%d_%H_%M`
# /opt/sas/sashome/SASPlatformObjectFramework/9.4/tools/admin/sas-backup-metadata -reorg -log "/SASLOG/import_av_metadata/backup_och_reorg_$datetime.log"




 
 
file=SAS_Visual_Analytics_Hub
/opt/sas/sashome/SASPlatformObjectFramework/9.4/ImportPackage \
 -profile "SASAdmin" \
 -package "/home/sas/flytt_av_metadata/paket/$file.spk" \
 -log "/home/sas/flytt_av_metadata/$file.log" \
 -target "/" \
 -preservePaths \
 -includeACL \
 -subprop "/home/sas/flytt_av_metadata/paket/$file.subprop" \
 -noexecute


# Gör en backup mellan varje steg. Det kan vara bra att ha en backup att gå tillbaka till om något går fel, men framförallt
# sväller metadatakatalogen enormt i samband med import av stora mängder metadata. Detta rättas till om man kör "-reorganize".
datetime=DAGENS_DATUM=`date +%Y-%m-%d_%H_%M`
# /opt/sas/sashome/SASPlatformObjectFramework/9.4/tools/admin/sas-backup-metadata -reorg -log "/SASLOG/import_av_metadata/backup_och_reorg_$datetime.log"




