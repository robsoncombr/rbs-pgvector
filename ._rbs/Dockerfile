ARG PG_MAJOR=17

# Stage 1: Use postgres image to get the apt lists
FROM postgres:$PG_MAJOR AS postgres_lists
ARG PG_MAJOR

# Stage 2: Use pgvector image and copy the apt lists from Stage 1
FROM pgvector/pgvector:0.8.0-pg17

# Copy the apt lists from the postgres image
COPY --from=postgres_lists /var/lib/apt/lists /var/lib/apt/lists

# Install the required packages
RUN apt-get update && \
	apt-mark hold locales && \
	apt-get install -y --no-install-recommends \
	curl \
	wget \
	unzip \
	osm2pgsql \
	osmium-tool \
	postgis \
	postgresql-17-pgrouting && \
	apt-get autoremove -y && \
	apt-mark unhold locales && \
	apt-get clean autoclean && \
	apt-get autoremove --yes && \
	rm -rf /var/lib/{apt,dpkg,cache,log}/
