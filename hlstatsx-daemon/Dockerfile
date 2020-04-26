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

COPY cron /etc/cron.d/hlstats-cron

RUN chmod 0644 /etc/cron.d/hlstats-cron
RUN crontab /etc/cron.d/hlstats-cron

RUN touch /var/log/cron.log
CMD cron && /opt/hlstatsx/GeoLiteCity/install_binary.sh && /opt/hlstatsx/run_hlstats start && tail -f /var/log/cron.log

EXPOSE 27500/tcp 27500/udp