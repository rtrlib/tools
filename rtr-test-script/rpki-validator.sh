MAIN_DUMP_DIR=$( realpath $1 )
EXECUTION_DIR=`dirname "$BASH_SOURCE"`
cd ${EXECUTION_DIR}
CURRENT_DIR=$( pwd )

#printf "Removing old cache data..."
#rm rpki-validator-app-*/data_backup/* -rf
#mv rpki-validator-app-*/data/ rpki-validator-app*/data_backup/
#printf " done!\n"

#printf "Starting Cache and waiting for it to sync...\n"
#./rpki-validator-app-*/rpki-validator.sh start
#while [ ! -f rpki-validator-app-*/data/data.json ]
#do
    ## wait for sync...
    #sleep 1
#done
#printf " done!\n"

sh $CURRENT_DIR/scripts/prepare-rib.sh $MAIN_DUMP_DIR

sh $CURRENT_DIR/scripts/validate-rtr.sh $MAIN_DUMP_DIR $2 $3

# the RIPE RPKI validator implementation
sh $CURRENT_DIR/scripts/validate-ripe.sh $MAIN_DUMP_DIR

# cleanup
printf "Cleanup..."
rm $CURRENT_DIR/tmp/*
printf " done!\n"
