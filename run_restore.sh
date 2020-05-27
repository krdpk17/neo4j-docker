set -o allexport
source neo4j.cfg
source neo4j_backup_restore.cfg
set +o allexport

echo "starting restore at" `date`
echo running script $PWD/$0
echo DB file path is ${NEO_DB_MNT_PATH}
RESTORE_NEO4J_DIR_HOSTPATH=${NEO_DB_MNT_PATH}/restore/
echo "starting restore at" `date`
cp ${RESTORE_NEO4J_DIR_HOSTPATH}/${NEO4J_DUMP_FILE_NAME} ${RESTORE_NEO4J_DIR_HOSTPATH}/${NEO4J_DUMP_FILE_NAME}_bkp
docker stop ${NEO4J_SVR_NAME}
echo "stopped ${NEO4J_SVR_NAME} server for restore at" `date`
docker run --rm  -i --name ${NEO4J_TMP_CONTAINER_NAME} -v ${NEO_DB_MNT_PATH}/data:/data -v ${NEO_DB_MNT_PATH}/restore:/restore neo4j:4.0.1 /bin/bash -c "bin/neo4j-admin load --database=neo4j --from=/restore/${NEO4J_DUMP_FILE_NAME} --force"
echo "finished ${NEO4J_SVR_NAME} restore at" `date`
chown -R neo4jadmin ${NEO_DB_MNT_PATH}/data
chgrp -R neo4jadmin ${NEO_DB_MNT_PATH}/data
sleep 2
docker start ${NEO4J_SVR_NAME}
echo "restarted server at" `date`
