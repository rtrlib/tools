CURRENT_DIR=$( pwd )
EXECUTION_DIR=`dirname "$BASH_SOURCE"`
cd ${EXECUTION_DIR}

rm ../tmp/*.short* ../tmp/merge*

printf "Prepare temp files for analysis..."
awk '{ print $NF }' $CURRENT_DIR/$1 >> ../tmp/lpfst.short
awk '{ print $NF }' $CURRENT_DIR/$2 >> ../tmp/trie.short
awk '{ print $NF }' $CURRENT_DIR/$3 >> ../tmp/spfst.short
awk '{ print $NF }' $CURRENT_DIR/$4 >> ../tmp/rpki.short

sed 's/\"//g' ../tmp/lpfst.short > ../tmp/lpfst.short.tmp
sed 's/\"//g' ../tmp/trie.short > ../tmp/trie.short.tmp
sed 's/\"//g' ../tmp/spfst.short > ../tmp/spfst.short.tmp
sed 's/\"//g' ../tmp/rpki.short > ../tmp/rpki.short.tmp

:|paste -d' ' ../tmp/lpfst.short.tmp - ../tmp/trie.short.tmp - ../tmp/spfst.short.tmp - ../tmp/rpki.short.tmp > ../tmp/merge.txt

sed 's/\s\+/ /g' ../tmp/merge.txt > ../tmp/merge.txt.tmp
sed 's/\"//g' ../tmp/merge.txt.tmp > ../tmp/merge.txt
printf " done!\n"

maxlines=$( wc -l ../tmp/merge.txt | awk '{ print $1 }' )
counter=1

printf "%-18s %-6s | %-8s | %-8s | %-8s | %-8s\n" "Prefix/Length" "ASN" "lpfst" "trie" "spfst" "RPKI" > ../results/statistics.txt
echo "----------------------------------------------------------------" >> ../results/statistics.txt
printf "Analyze data..."
while read -r column1 column2 column3 column4
do
    if [ "$column1" != "$column2" -o "$column1" != "$column3" -o "$column1" != "$column4" ]
    then
        line=$( sed -n "$counter p" $CURRENT_DIR/$1 | awk '{ print $1 " " $2 }' )
        #echo -e "$line\t\t|\t$column1\t|\t$column2\t|\t$column3" >> statistics.txt
        printf "%-18s %-6s | %-8s | %-8s | %-8s | %-8s\n" $line $column1 $column2 $column3 $column4 >> ../results/statistics.txt
    fi
    counter=$((counter+1))
    echo -ne "${counter}/${maxlines} lines processed.\r"

done < ../tmp/merge.txt

printf " \ndone!\n"

printf "Cleanup temp data..."
rm ../tmp/*.short* ../tmp/merge*
printf " done!\n"
