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

sh scripts/prepare-rib.sh $1

sh scripts/validate-rtr.sh $1 $2 $3

# the RIPE RPKI validator implementation
sh scripts/validate-ripe.sh $1.formatted

# cleanup
printf "Cleanup..."
rm $1.temp $1.formatted*
printf " done!\n"
