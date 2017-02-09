DUMP_DIR=$( realpath $1 )
RIB_DUMP=$( basename $1 )
EXECUTION_DIR=`dirname "$BASH_SOURCE"`
cd ${EXECUTION_DIR}

#convert the rib dump to readable bgp data
printf "Converting RIB dump to readable BGP...\n"
../bin/bgpdump -M -O ../tmp/$RIB_DUMP.temp $DUMP_DIR
printf " done!\n"

#take only ASN and Prefix and write them to different files
printf "Filter unnecessary data, sort and uniq it..."
awk -F '|' '{print $6 " " $7}' ../tmp/$RIB_DUMP.temp | awk '{ print $1 " " $NF }' | sed '/{/d' | sort -u > ../tmp/$RIB_DUMP.formatted
printf " done!\n"
