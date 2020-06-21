FROM debian:buster-slim

RUN wget https://github.com/maxmind/geoipupdate/releases/download/v4.3.0/geoipupdate_4.3.0_linux_amd64.deb -O /tmp/geoipupdate.deb \
    && dpkg -i /tmp/geoipupdate.deb \
    && rm -r /tmp/*