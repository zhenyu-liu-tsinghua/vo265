#!/bin/sh

cfg_file=$1
basepath=$(cd `dirname $0`; pwd)
bdbrpath=/Users/liuzhenyu/matlab-project/bdbrbdpsnr

sh parallel_read_file.sh ${cfg_file} 
echo "collect"
sh collect_vqt_result.sh ${cfg_file}

cp result_ssim.csv ${bdbrpath}/result_ssim.csv
cd ${bdbrpath}

#sed -ie 's/count=24/count=24/g' x265_ssim.m

octave x265_ssim.m >> ${basepath}/statistic.csv

cd ${basepath}


