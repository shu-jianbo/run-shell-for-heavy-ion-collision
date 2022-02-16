# run-shell-for-heavy-ion-collision
1. Sn124Sn124.sh 是 实现多组参数组作为输入程序，模拟重离子碰撞过程。我们通过服务器的cpu占有率来判断是否让程序挂起。<br>
2. 用crontab实现定时执行startSn124Sn124.sh，如果cpu占有率充足，我们将继续执行Sn124Sn124.sh。
