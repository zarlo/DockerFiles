FROM debian:buster-slim

ENV HLSTATSX=/opt/hlstatsx/

ENV GEOIP_AccountID="0" \
    GEOIP_LicenseKey="" \
    DBHost="" \
    DBUsername="" \
    DBPassword="" \
    DBName="" \
    EventQueueSize="10" \
    DebugLevel="0" \
    COUNT="5"

VOLUME /opt/GeoIP2-Country/
VOLUME /logs

RUN set -x \
    && dpkg --add-architecture i386 \
    && apt-get update

RUN set -x \
    && apt-get install -y --no-install-recommends --no-install-suggests \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libdbd-mysql-perl \
    openssl \
    unzip \
    cron \
    wget \
    git \
    cpanminus

RUN apt-get install --reinstall ca-certificates

RUN set -x \
    && cpanm install MaxMind::DB::Reader \
    && cpanm install GeoIP2::Database::Reader \
    && cpanm install Syntax::Keyword::Try 

RUN git clone https://github.com/NomisCZ/hlstatsx-community-edition.git /tmp/hlstatsx \
    && cp -r /tmp/hlstatsx/scripts ${HLSTATSX} \
    && rm -r /tmp/*

RUN wget https://github.com/maxmind/geoipupdate/releases/download/v4.3.0/geoipupdate_4.3.0_linux_amd64.deb -O /tmp/geoipupdate.deb \
    && dpkg -i /tmp/geoipupdate.deb \
    && rm -r /tmp/*

WORKDIR ${HLSTATSX}

RUN ln -s /opt/GeoIP2-Country/ ${HLSTATSX} \
    && ln -s ${HLSTATSX}/logs /logs

COPY entry.sh ${HLSTATSX}entry.sh
COPY geoipupdate.sh ${HLSTATSX}geoipupdate.sh
COPY hlstats-awards.sh ${HLSTATSX}hlstats-awards.sh
RUN chmod +x ${HLSTATSX}entry.sh ${HLSTATSX}run_hlstats ${HLSTATSX}hlstats-awards.pl ${HLSTATSX}geoipupdate.sh ${HLSTATSX}hlstats-awards.sh

RUN (crontab -l ; echo "* 0  * * *   /opt/hlstatsx/hlstats-awards.sh >> /dev/stdout 2>&1") | crontab -
RUN (crontab -l ; echo "0 0  * * *   /opt/hlstatsx/run_hlstats restart >> /dev/stdout 2>&1") | crontab -
RUN (crontab -l ; echo "5 22 * * *   /usr/bin/geoipupdate >> /dev/stdout 2>&1") | crontab -

RUN service cron reload \
    && service cron restart


ENTRYPOINT [ "${HLSTATSX}entry.sh"]

EXPOSE 27500/udp