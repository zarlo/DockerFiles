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

COPY start.sh ${HLSTATSX}

RUN chmod 0644 /etc/cron.d/hlstats-cron
RUN crontab /etc/cron.d/hlstats-cron
RUN ln -sf /dev/stdout /var/log/cron.log
WORKDIR ${HLSTATSX}

CMD ["start.sh"]

EXPOSE 27500/tcp 27500/udp