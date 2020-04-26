FROM debian:buster-slim

ENV HLSTATSX=/opt/hlstatsx/

VOLUME ${HLSTATSX}

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
    cron

    
RUN set -x \
    && cpan install MaxMind::DB::Reader \
    && cpan GeoIP2::Database::Reader \
    && cpan Syntax::Keyword::Try 

RUN set -x \
    wget https://github.com/NomisCZ/hlstatsx-community-edition/archive/master.zip -o /tmp/hlstatsx.zip \
    unzip /tmp/hlstatsx.zip \
    mkdir ${HLSTATSX} \
    mv /tmp/hlstatsx-community-edition-master/scripts/* ${HLSTATSX}

RUN chmod +x ${HLSTATSX}hlstats-awards.pl ${HLSTATSX}hlstats.pl ${HLSTATSX}hlstats-resolve.pl ${HLSTATSX}run_hlstats ${HLSTATSX}GeoLiteCity/install_binary.sh

COPY cron /etc/cron.d/hlstats-cron


RUN chmod 0644 /etc/cron.d/hlstats-cron
RUN crontab /etc/cron.d/hlstats-cron

RUN touch /var/log/cron.log
CMD cron && ${HLSTATSX}GeoLiteCity/install_binary.sh && ${HLSTATSX}run_hlstats start && tail -f /var/log/cron.log

EXPOSE 27500/tcp 27500/udp