service cron start
/opt/hlstatsx/GeoLiteCity/install_binary.sh >> /var/log/cron.log 2>&1
/opt/hlstatsx/run_hlstats start >> /var/log/cron.log 2>&1
while true
do
	sleep 1
done
