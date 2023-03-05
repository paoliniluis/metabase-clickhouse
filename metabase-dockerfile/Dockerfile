FROM eclipse-temurin:11-jre-focal as runner

ENV FC_LANG en-US LC_CTYPE en_US.UTF-8

WORKDIR /app/

ADD run_metabase.sh .
ADD https://github.com/ClickHouse/metabase-clickhouse-driver/releases/download/1.1.0/clickhouse.metabase-driver.jar plugins/clickhouse.metabase-driver.jar

RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends ttf-dejavu && \
    # cleaning everything to reduce container size
    apt-get autoremove -y && apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* && \
    # providing permissions to the nobody user
    curl https://downloads.metabase.com/enterprise/v1.46.0-RC2/metabase.jar -o metabase.jar && \
    chmod +x run_metabase.sh && \
    chmod -R a+rwX /app/

# expose our default runtime port
EXPOSE 3000

# run it
ENTRYPOINT ["/app/run_metabase.sh"]