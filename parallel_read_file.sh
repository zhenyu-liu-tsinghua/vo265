#!/bin/sh

input_sequence_file=$1

basepath=$(cd `dirname $0`; pwd)
echo ${basepath}

args_file=parallel-arg.txt

if [ -f ${args_file} ]
then
    rm -f ${args_file}
fi

while read line
do
    if echo $line | grep -q 'YES'
    then
        sequence_dir=$(echo $line | cut -d " " -f 1)
        sequence_name=$(echo $line | cut -d " " -f 2)
        width=$(echo $line | cut -d " " -f 3)
        height=$(echo $line | cut -d " " -f 4)
        framerate=$(echo $line | cut -d " " -f 5)
        crf=$(echo $line | cut -d " " -f 6)
        ypixelnum=$(echo "$width * $height"|bc)
        keyinterval=$(echo "2 * $framerate"|bc)

        qgsize=32;
        if [ ${width} -ge 1280 ]
        then
            qgsize=64
        fi

        seq=${sequence_name%.*}
        if [ -d ${seq}_${crf} ]
        then
            rm -rf ${seq}_${crf}
        fi

        mkdir ${seq}_${crf}

        echo ${seq}_${crf}
        echo "${sequence_dir}/${sequence_name} ${width}x${height} ${framerate} ${crf} ${qgsize} ${basepath}/${seq}_${crf}/output.265 ${basepath}/${seq}_${crf}/${seq}_${crf}.csv ${keyinterval}" >> ${args_file}
    fi
done < ${input_sequence_file}

#parallel --colsep ' ' -j 2 ./x265 --preset medium --tune ssim --rc-lookahead 64 --rdpenalty 0 --min-keyint 1 --input {1} --input-res {2} --fps {3} --crf {4} --ssim --qg-size {5} --aq-mode 1 --aq-strength 1.0 --b-adapt 1 --bframes 15 --keyint 100 --no-b-multquant -o {6} --csv {7} :::: ${args_file}

parallel --colsep ' ' -j 4 ./x265 --preset placebo --tune ssim --b-mctf --rc-lookahead 64 --rdpenalty 0 --min-keyint 1 --input {1} --input-res {2} --fps {3} --ref 5 --crf {4} --ssim --qg-size {5} --aq-mode 1 --aq-strength 1.0 --b-adapt 1 --bframes 31 --keyint 8000 -o {6} --weightp --weightb --subme 7 --csv {7} :::: ${args_file}

#parallel --colsep ' ' -j 2 ./x265 --preset placebo --tune ssim --b-mctf --rc-lookahead 64 --rdpenalty 0 --min-keyint 1 --input {1} --input-res {2} --fps {3} --ref 5 --crf {4} --ssim --qg-size 32 --aq-mode 1 --aq-strength 1.0 --b-adapt 1 --bframes 31 --keyint {8} -o {6} --weightp --weightb --subme 7 --qcomp 1.0 --csv {7} :::: ${args_file}

#parallel --colsep ' ' -j 2 ./x265 --preset placebo --b-mctf --tune ssim --rc-lookahead 32 --rdpenalty 0 --min-keyint 1 --input {1} --input-res {2} --fps {3} --ref 5 --crf {4} --ssim --qg-size {5} --aq-mode 1 --aq-strength 1.0 --b-adapt 1 --bframes 7 --keyint 8000 -o {6} --csv {7} :::: ${args_file}

#x265 veryslow
#parallel --colsep ' ' -j 2 /Users/liuzhenyu/x265_2.4/build/linux/x265 --preset veryslow --tune ssim --input {1} --input-res {2} --fps {3} --crf {4} --ssim --qg-size {5} -o {6} --csv {7} :::: ${args_file}

dec_args_file=parallel-dec-arg.txt

if [ -f ${dec_args_file} ]
then
    rm -f ${dec_args_file}
fi

while read line
do
    if echo $line | grep -q 'YES'
    then
        sequence_name=$(echo $line | cut -d " " -f 2)
        crf=$(echo $line | cut -d " " -f 6)
        seq=${sequence_name%.*}

        echo "${basepath}/${seq}_${crf}/output.265 ${basepath}/${seq}_${crf}/${seq}_${crf}.yuv" >> ${dec_args_file}
    fi
done < ${input_sequence_file}

parallel --colsep ' ' -j 5 /opt/homebrew/bin/ffmpeg -i {1} -vcodec rawvideo -an {2} :::: ${dec_args_file}

vqt_args_file=parallel-vqt-arg.txt

if [ -f ${vqt_args_file} ]
then
    rm -f ${vqt_args_file}
fi

while read line
do
    if echo $line | grep -q 'YES'
    then
        sequence_dir=$(echo $line | cut -d " " -f 1)
        sequence_name=$(echo $line | cut -d " " -f 2)
        width=$(echo $line | cut -d " " -f 3)
        height=$(echo $line | cut -d " " -f 4)
        crf=$(echo $line | cut -d " " -f 6)
        seq=${sequence_name%.*}
        echo "${basepath}/${seq}_${crf}/${seq}_${crf}.yuv ${sequence_dir}/${sequence_name} ${width}x${height} ${basepath}/${seq}_${crf}/${seq}_${crf}_vqt.output" >> ${vqt_args_file}
    fi
done < ${input_sequence_file}

parallel --result {4} --colsep ' ' -j 5 ./vqt -rec {1} -org {2} -res {3} -thread 8 -ssim -psnr :::: ${vqt_args_file}
