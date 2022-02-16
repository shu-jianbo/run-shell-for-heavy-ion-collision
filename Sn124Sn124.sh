#!/bin/bash
#$ -S /bin/bash
#$ -cwd

    bak=$IFS                                         #定义一个变量bak保存IFS的值
   if [ $# -ne 1 ];then                          #判断位置参数是否为1
       echo "Usage $0 skyrme-parameter-BUU-20.txt"  #skyrme-parameter-BUU-20.txt用于存放参数组名和对应的各个参数取值
       exit
   fi
   if [ ! -f $1 ];then                              #判断位置参数是否为文件
      echo "the $1 is not a file"
      exit
  fi 
  IFS=$'\n'                                        #将环境变量IFS的值修改为换行符
  for line in `cat $1`                                #逐行读取文件内容并打印到屏幕
  do
    para=`echo $line | awk '{print $1}'`      #获取文件名
    value=`echo $line | awk '{print $2,$3,$4,$5,$6,$7,$8,$9,$10}'`  #获取Skyrme各个参数取值
	#实现批量复制文件，配置好程序运行所需要的文件
    mkdir $para
    cd $para
    cp ../../Sn124/$para/Sn124pn.dat   .
    cp ../../Sn124/$para/Sn124pn.dat   .
    cp ../Au197Au197.inp .
    cp ../skyrme-BUU.for . 
    sed -i '26i '$value'' Au197Au197.inp
    for ((hh=1;hh<51;hh++)); do
    mkdir part$hh
    cd part$hh
    mkdir result
    cp ../skyrme-BUU.for . 
    cp ../Au197Au197.inp .
    cp ../Sn124pn.dat .
    cp ../Sn124pn.dat .
    sed -i 's/9999/9'$hh'9/' Au197Au197.inp
    ifort skyrme-BUU.for -check bounds -g -o shujianbo$hh
    ./shujianbo$hh &
    cd ..
    done
    cd ..
	#获取服务器的cpu剩余率
    idle=`top -n 1 -b |  sed -e 's/ //g' | grep "Cpu(s):" | awk -F ":" '{print $2}' | awk -F "," '{print $4}' | awk -F "i" '{print $1}'`
    #获取运行的批量运行文件脚本的进程ID
	mypid=`pgrep -f Sn124Sn124.sh`
    echo $idle
	#判断，如果cpu占有率小于90，将脚本挂起
    if [ $(echo "$idle <= 90"|bc) = 1 ]
    then
	kill -STOP $mypid
   fi
  done
  IFS=$bak                                    #将环境变量IFS的值改回原值
