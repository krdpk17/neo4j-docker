set -o allexport
source neo4j.cfg
set +o allexport
docker-compose $@
