#!/bin/sh

input_sequence_file=$1

basepath=$(cd `dirname $0`; pwd)

if [ -f result_ssim.csv ]
then
    rm result_ssim.csv
fi

if [ -f result_psnr.csv ]
then
    rm result_psnr.csv
fi

while read -r line
do
    if echo $line | grep -q 'YES'
    then
        sequence_name=$(echo $line | cut -d " " -f 2)
        seq=${sequence_name%.*}
        targetrate=$(echo $line | cut -d " " -f 6)
        while read -r line1
        do
           if  ! echo $line1 | grep -q 'Command' 
           then
               rate=$(echo $line1 | cut -d , -f 5)
               #ssim=$(echo $line1 | cut -d , -f 10)
               #psnr=$(echo $line1 | cut -d , -f 9)
           fi
        done < ${seq}_${targetrate}/${seq}_${targetrate}.csv

        psnr=$(sed -n 1p ${seq}_${targetrate}/${seq}_${targetrate}_vqt.output | cut -d ":" -f 6)
        ssim=$(sed -n 3p ${seq}_${targetrate}/${seq}_${targetrate}_vqt.output | cut -d ":" -f 6)
        #ssim=$(cat ${seq}_${targetrate}/${seq}_${targetrate}_vqt.output | cut -d ":" -f 6)
        #echo -n "${seq}, " >> result.csv
        #echo -n "${rate}, " >> result.csv
        #echo ${ssim} >> result.csv
        echo "${seq}, ${rate}, ${ssim}" >> result_ssim.csv
        echo "${seq}, ${rate}, ${psnr}" >> result_psnr.csv
        echo ${seq}
        echo ${ssim}

    fi

done < ${input_sequence_file}
