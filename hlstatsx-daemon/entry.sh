#!/bin/bash

crontab /etc/cron.d/hlstats-cron
service cron reload
service cron restart

echo "
AccountID $GEOIP_AccountID
LicenseKey $GEOIP_LicenseKey
EditionIDs GeoLite2-ASN GeoLite2-City GeoLite2-Country
DatabaseDirectory /opt/GeoIP2-Country/" > /etc/GeoIP.conf


find hlstats.conf -type f -exec sed -i 's/DBHost ""/DBHost "$DBHost"/g' {} \;
find hlstats.conf -type f -exec sed -i 's/DBUsername ""/DBUsername "$DBUsername"/g' {} \;
find hlstats.conf -type f -exec sed -i 's/DBPassword ""/DBPassword "$DBPassword"/g' {} \;
find hlstats.conf -type f -exec sed -i 's/DBName ""/DBName "$DBName"/g' {} \;
find hlstats.conf -type f -exec sed -i 's/EventQueueSize "10"/EventQueueSize "$EventQueueSize"/g' {} \;
find hlstats.conf -type f -exec sed -i 's/DebugLevel "1"/DebugLevel "$DebugLevel"/g' {} \;
echo "" >> hlstats.conf
if [ ! -f /opt/GeoIP2-Country/GeoLite2-City.mmdb ]; then
    echo "running geoipupdate"
    /usr/bin/geoipupdate
fi

./run_hlstats start $COUNT >> /dev/stdout 2>&1
while true
do
    sleep 1
done
