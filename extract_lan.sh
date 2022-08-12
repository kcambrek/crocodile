#!/usr/bin/env bash
# this is a bash script to bootstart the project including downloading of datasets - setup of additional tools.
# pass a language code as a variable to install a certain language. Defaults to English if no language code given.

################################
# Download Data #
###############################
echo "downloading wikipedia and wikidata dumps..."
mkdir data/$1
 wikimapper download $1wiki-latest --dir data/$1/
 echo "Create wikidata database"
 wikimapper create $1wiki-latest --dumpdir data/$1/ --target data/$1/index_$1wiki-latest.db
 echo "Extract abstracts"
# download by hand and place in data folder: https://dumps.wikimedia.org/nlwiki/latest/nlwiki-latest-pages-articles-multistream.xml.bz2
# make sure to use fork https://github.com/LittlePea13/wikiextractor.git for wikiextractor
python -m wikiextractor.WikiExtractor data/$1/$1wiki-latest-pages-articles-multistream.xml.bz2 --links --language nl --output text/$1 --templates data/$1/templates.txt
#### fix the data tags by hand. This does not seem to work
echo "Fix first and last file by hand and continue."
## echo "Fix first and last file: "
## echo `ls -1 text/$1/**/* | tail -1`
## echo "</data>" >> `ls -1 text/$1/**/* | tail -1`
## sed -i '$ d' text/$1/AA/wiki_00
## echo "</data>" >> text/$1/AA/wiki_00
# echo "Create triplets db"
# #TEMP
# python wikidata-triplets.py --input text/$1/ --output data/$1/wikidata-triples-$1-subj.db --input_triples wikidata/wikidata-triples.csv --format db
# python wikidata-triplets.py --input text/$1/ --output data/$1/wikidata-triples-$1-subj.csv --input_triples wikidata/wikidata-triples.csv
# echo "Extract triplets to out/$1"
#Multicore does not seem to work for some reason.
##python multicore_run.py --input text/$1/ --output ./out/$1/ --input_triples data/$1/wikidata-triples-$1-subj.db --language $1
# python single_score_run.py --input text/$1/ --output ./out/$1/ --input_triples data/$1/wikidata-triples-$1-subj.db --language $1
# echo "Clean triplets to out_clean/$1"
# # python filter_relations.py --folder_input out/$1
# python add_filter_relations.py --folder_input out/$1

