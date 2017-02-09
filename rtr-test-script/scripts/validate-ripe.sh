DUMP_DIR=$( pwd )
RIB_DUMP=$( basename $1 )
EXECUTION_DIR=`dirname "$BASH_SOURCE"`
cd ${EXECUTION_DIR}

if [ -f ../tmp/$RIB_DUMP.apiresult ]
then
    rm ../tmp/$RIB_DUMP.apiresult
fi
printf "Validate prefix data with RIPE API (this takes about a day)...\n"
maxlines=$( wc -l ../tmp/$RIB_DUMP.formatted | awk '{ print $1 }' )
counter=1
while read -r prefix asn
do
    result=$( curl -s "localhost:8080/api/v1/validity/AS$asn/$prefix" | jq '.validated_route.validity.state' )
    echo "$prefix $asn $result" >> ../tmp/$RIB_DUMP.apiresult
    echo -ne "${counter}/${maxlines} lines processed.\r"
    counter=$((counter+1))
done < ../tmp/$RIB_DUMP.formatted
printf " done!\n"

# filter and sort the RPKI validation result
sed '/{/d' ../tmp/$RIB_DUMP.apiresult | sort -u > ../results/rpki-result.txt
