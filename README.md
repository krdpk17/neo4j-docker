# neo4j-docker
#neo4j server in docker form**

##Step:
###Set configuration 
Edit settings in neo4j.cfg

###Run below command to start neo4j
**To start server**
sudo bash run_neo4j.bash up -d

**To Stop server**
sudo bash run_neo4j.bash down


#Backup of data
##Set Configuration 
Edit settings in neo4j_backup.cfg
###Run below command to start backup
sudo bash run_backup.sh

**Backup will be stored in the backup folder of same DB path in parallel to DB folder**
