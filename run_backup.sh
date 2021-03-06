set -o allexport
source neo4j.cfg
source neo4j_backup_restore.cfg
set +o allexport

echo "starting backup at" `date`
echo running script $PWD/$0
echo DB file path is ${NEO_DB_MNT_PATH}
BACKUP_NEO4J_DIR_HOSTPATH=${NEO_DB_MNT_PATH}/backup/
echo "starting backup at" `date`
mv ${BACKUP_NEO4J_DIR_HOSTPATH}/${NEO4J_DUMP_FILE_NAME} ${BACKUP_NEO4J_DIR_HOSTPATH}/${NEO4J_DUMP_FILE_NAME}_bkp
docker stop ${NEO4J_SVR_NAME}
echo "stopped ${NEO4J_SVR_NAME} server for backup at" `date`
docker run --rm  -i --name ${NEO4J_TMP_CONTAINER_NAME} -v ${NEO_DB_MNT_PATH}/data:/data -v ${NEO_DB_MNT_PATH}/backup:/backup neo4j:4.0.1 /bin/bash -c "bin/neo4j-admin dump --database=neo4j --to=/backup/${NEO4J_DUMP_FILE_NAME}"
echo "finished backup at" `date`
chown -R ${NEO4J_DB_OWNER} ${NEO_DB_MNT_PATH}/data
chgrp -R ${NEO4J_DB_GROUP} ${NEO_DB_MNT_PATH}/data
sleep 2
docker start ${NEO4J_SVR_NAME}
echo "restarted ${NEO4J_SVR_NAME} server at" `date`
