set -o allexport
source neo4j.cfg
set +o allexport
CUID=$(id -u)
CGUID=$(id -g)
CUID=CUID CGUID=CGUID docker-compose $@
