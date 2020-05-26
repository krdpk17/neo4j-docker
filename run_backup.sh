set -o allexport
source neo4j.cfg
source neo4j_backup.cfg
set +o allexport

echo "starting backup at" `date`
echo running script $PWD/$0
echo DB file path is ${NEO_DB_MNT_PATH}
BACKUP_NEO4J_DIR_HOSTPATH=${NEO_DB_MNT_PATH}/backup/
echo "starting backup at" `date`
mv /backup/neo4j_dump.dump /backup/neo4j_dump.dump_bkp
docker stop ${NEO4J_BKP_SVR_NAME}
echo "stopped server for backup at" `date`
docker run --rm  -i --name ${NEO4J_BKP_TMP_CONTAINER_NAME} -v ${NEO_DB_MNT_PATH}/data:/data -v ${NEO_DB_MNT_PATH}/backup:/backup neo4j:4.0.1 /bin/bash -c "bin/neo4j-admin dump --database=neo4j --to=/backup/neo4j_dump.dump"
echo "finished backup at" `date`
chown -R neo4jadmin ${NEO_DB_MNT_PATH}/data
chgrp -R neo4jadmin ${NEO_DB_MNT_PATH}/data
sleep 2
docker start ${NEO4J_BKP_SVR_NAME}
echo "restarted server at" `date`