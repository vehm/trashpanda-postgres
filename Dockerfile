ARG PG_MAJOR=17
FROM postgres:${PG_MAJOR}

ARG PG_MAJOR
ARG PG_UUIDV7_VERSION=1.7.0

RUN apt-get update && apt-get install -y --no-install-recommends \
    postgresql-${PG_MAJOR}-pgvector \
    postgresql-${PG_MAJOR}-cron \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN cd /tmp \
    && curl -LO "https://github.com/fboulnois/pg_uuidv7/releases/download/v${PG_UUIDV7_VERSION}/{pg_uuidv7.tar.gz,SHA256SUMS}" \
    && tar xf pg_uuidv7.tar.gz \
    && sha256sum -c SHA256SUMS \
    && cp "${PG_MAJOR}/pg_uuidv7.so" "$(pg_config --pkglibdir)" \
    && cp pg_uuidv7--1.7.sql pg_uuidv7.control "$(pg_config --sharedir)/extension" \
    && rm -rf /tmp/*

CMD ["postgres", "-c", "shared_preload_libraries=pg_cron"]