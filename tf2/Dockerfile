FROM ubuntu:18.04

ENV STEAMCMDDIR /home/steam/steamcmd
ENV STEAMAPPDIR /home/steam/tf2-dedicated
ENV STEAMAPPID 232250

RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install -y --no-install-recommends --no-install-suggests \
    ca-certificates \
    wget \
    lib32z1 \
    libncurses5:i386 \
    libbz2-1.0:i386 \
    lib32gcc1 \
    lib32stdc++6 \
    libtinfo5:i386 \
    libcurl3-gnutls:i386

WORKDIR ${STEAMCMDDIR}
RUN wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar zxf -
RUN ${STEAMCMDDIR}/steamcmd.sh \
    +login anonymous \
    +force_install_dir ${STEAMAPPDIR} \
    +app_update ${STEAMAPPID} validate \
    +quit
RUN { \
    echo '@ShutdownOnFailedCommand 1'; \
    echo '@NoPromptForPassword 1'; \
    echo 'login anonymous'; \
    echo 'force_install_dir ${STEAMAPPDIR}'; \
    echo 'app_update ${STEAMAPPID}'; \
    echo 'quit'; \
} > /home/steam/tf2_update.txt

RUN mkdir /root/.steam/sdk32
RUN ln -s ${STEAMCMDDIR}/linux32/steamclient.so ~/.steam/sdk32/steamclient.so

RUN apt-get remove --purge -y wget
RUN apt-get clean autoclean
RUN apt-get autoremove -y
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd steam
USER steam
WORKDIR $STEAMAPPDIR
ENV SRCDS_PORT=27015 \
    SRCDS_TV_PORT=27020 \
    SRCDS_MAXPLAYERS=16 \
    SRCDS_RCONPW="changeme" \
    SRCDS_PW="" \
    SRCDS_STARTMAP="ctf_2fort" \
    SRCDS_CONFIG="server.cfg"

USER steam

WORKDIR $STEAMAPPDIR
VOLUME $STEAMAPPDIR
VOLUME $STEAMCMDDIR

ENTRYPOINT ${STEAMCMDDIR}/steamcmd.sh \
        +login anonymous +force_install_dir ${STEAMAPPDIR} +app_update ${STEAMAPPID} +quit \
        && ${STEAMAPPDIR}/srcds_run \
        -game tf -steam_dir ${STEAMCMDDIR} -port $SRCDS_PORT -tv_port $SRCDS_TV_PORT \
        -maxplayers $SRCDS_MAXPLAYERS +ip 0.0.0.0 +map $SRCDS_STARTMAP \
        +rcon_password $SRCDS_RCONPW -steamcmd_script /home/steam/tf2_update.txt \
        +sv_password $SRCDS_PW +servercfgfile $SRCDS_CONFIG -secured +sv_pure 1 -autoupdate



