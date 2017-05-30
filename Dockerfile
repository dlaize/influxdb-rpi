

    FROM resin/rpi-raspbian

    WORKDIR /tmp

    RUN apt-get update && apt-get install -y --no-install-recommends wget && apt-get clean  
    RUN rm -rf /var/lib/apt/lists/ /tmp/ /var/tmp/* 
    RUN wget https://storage.googleapis.com/golang/go1.8.linux-armv6l.tar.gz  
    RUN tar -C /usr/local -xzvf go1.8.linux-armv6l.tar.gz 
    RUN rm -rf go1.8.linux-armv6l.tar.gz
    RUN echo 'export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games:/usr/local/go/bin' >> /etc/profile 
    RUN wget https://dl.influxdata.com/influxdb/releases/influxdb-1.2.4_linux_armhf.tar.gz 
    RUN tar -C / --strip-components=2 --show-transformed-names -xzvf influxdb-1.2.4_linux_armhf.tar.gz 
    RUN rm -rf influxdb-1.2.4_linux_armhf.tar.gz

    ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games:/usr/local/go/bin

    VOLUME ["/var/lib/influxdb", "/var/log/influxdb"]

    EXPOSE 8086

    CMD ["influxd"]
