# neo4j-docker
# neo4j server in docker form

## Step:
### Set configuration 
Edit settings in neo4j.cfg

### Run below command to start neo4j
**To start server**
sudo bash run_neo4j.bash up -d

**To Stop server**
sudo bash run_neo4j.bash down


# Backup/Restore of data
## Set Configuration 
Edit settings in neo4j_backup_restore.cfg
### Run below command 
**To perform backup**
sudo bash run_backup.sh
**To perform restore**
sudo bash run_restore.sh
### Note
**Backup will be stored in the backup folder of same DB path in parallel to DB folder**
**For restore, file will be picked from restore folder of same DB path in parallel to DB folder**
**This code picks DB Mount path configuration from neo4j.cfg **
