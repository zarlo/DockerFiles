FROM debian:buster-slim

ENV HLSTATSX=/opt/hlstatsx/


ENV GEOIP_AccountID="0" \
    GEOIP_LicenseKey="" \
    DBHost="" \
    DBUsername="" \
    DBPassword="" \
    DBName="" \
    EventQueueSize="10" \
    DebugLevel="0"

VOLUME /opt/GeoIP2-Country/

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
    cpm

RUN apt-get install --reinstall ca-certificates

RUN set -x \
    && cpm install MaxMind::DB::Reader \
    && cpm install GeoIP2::Database::Reader \
    && cpm install Syntax::Keyword::Try 

COPY cron /etc/cron.d/hlstats-cron
COPY entry.sh /entry.sh

RUN chmod +x /etc/cron.d/hlstats-cron
RUN crontab /etc/cron.d/hlstats-cron
RUN service cron reload
RUN service cron restart

RUN git clone https://github.com/NomisCZ/hlstatsx-community-edition.git /tmp/hlstatsx
RUN cp -r /tmp/hlstatsx/scripts ${HLSTATSX}

WORKDIR ${HLSTATSX}


RUN wget https://github.com/maxmind/geoipupdate/releases/download/v4.3.0/geoipupdate_4.3.0_linux_amd64.deb -O /tmp/geoipupdate.deb
RUN dpkg -i /tmp/geoipupdate.deb
COPY GeoIP.conf /etc/GeoIP.conf

RUN ln -s /opt/GeoIP2-Country/ ${HLSTATSX}GeoLiteCity/

ENTRYPOINT ["/entry.sh"]

EXPOSE 27500/udp