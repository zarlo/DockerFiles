find /etc/GeoIP.conf -type f -exec sed -i 's/YOUR_AccountID_HERE/${GEOIP_AccountID}/g' {} \;
find /etc/GeoIP.conf -type f -exec sed -i 's/YOUR_LICENSE_KEY_HERE/${GEOIP_LicenseKey}/g' {} \;

find /opt/hlstatsx/hlstats.conf -type f -exec sed -i 's/DBHost ""/DBHost "${DBHost}"/g' {} \;
find /opt/hlstatsx/hlstats.conf -type f -exec sed -i 's/DBUsername ""/DBUsername "${DBUsername}"/g' {} \;
find /opt/hlstatsx/hlstats.conf -type f -exec sed -i 's/DBPassword ""/DBPassword "${DBPassword}"/g' {} \;
find /opt/hlstatsx/hlstats.conf -type f -exec sed -i 's/DBName ""/DBName "${DBName}"/g' {} \;
find /opt/hlstatsx/hlstats.conf -type f -exec sed -i 's/EventQueueSize "10"/EventQueueSize "${EventQueueSize}"/g' {} \;
find /opt/hlstatsx/hlstats.conf -type f -exec sed -i 's/DebugLevel "1"/DebugLevel "${DebugLevel}"/g' {} \;

if [ ! -f /opt/GeoIP2-Country/GeoLite2-City.mmdb ]; then
    /usr/bin/geoipupdate
fi

/opt/hlstatsx/run_hlstats start "$@" >> /dev/stdout 2>&1
while true
do
    sleep 1
done
