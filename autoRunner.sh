#!/bin/bash
rm output.csv
touch output.csv
echo "Sort Name, Date & Time, Run Number, Branch Name, Git Hash, Command, Text File Name, Word Count, File Type, Execution Time (s), Execution Time (ms), Average Time (s)" >> output.csv
for direct in Bubble-Sort Insertion-Sort Selection-Sort
do
    cd $direct
    swiftc main.swift
    touch temp.txt
    echo $direct
    for list in ../wordLists/ordered.txt ../wordLists/reverse-ordered.txt ../wordLists/random.txt
    do
	fileName=${list##*/}
	fileName=${fileName%.txt}
	echo "   $fileName"
	for x in 0 1 2 3 4 5
	do
	    let count=10**$x
	    echo "      $count"
	    for j in 1 2 3 4 5
	    do
		cat $list | head -n $count > temp.txt
		time=$(TIMEFORMAT=%R; { time ./main < temp.txt > /dev/null; } 2>&1)
		mile=$((time*1000))
		date=$(date +"%D %T")
		echo "$direct,$date,$j,main,REDO,time ./main < wordLists/$fileName-10e$x.txt > /dev/null, $fileName-10e$x.txt,$count,$fileName,$time,$mile" >> ../output.csv
	    done
	done
    done
    rm temp.txt
    cd ..
done
