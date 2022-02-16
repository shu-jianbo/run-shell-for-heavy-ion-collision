#!/bin/bash
#$ -S /bin/bash
#$ -cwd

#通过命令：crontab -e 编辑任务，将startSn124Sn124.sh加入定时任务

#获取运行的批量运行文件脚本的进程ID
mypid=`pgrep -f Sn124Sn124.sh`
echo $mypid
#获取服务器的cpu剩余率
idle=`top -n 1 -b |  sed -e 's/ //g' | grep "Cpu(s):" | awk -F ":" '{print $2}' | awk -F "," '{print $4}' | awk -F "i" '{print $1}'`
echo $idle
#判断，如果cpu占有率大于等于90，继续执行脚本
if [ $(echo "$idle >= 90"|bc) = 1 ]
then
      kill -CONT $mypid
fi

