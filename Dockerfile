FROM ubuntu:jammy-20231004

ENV \
    DEBCONF_NONINTERACTIVE_SEEN="true" \
    DEBIAN_FRONTEND="noninteractive" \
    APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE="DontWarn"

WORKDIR /app

COPY . .

RUN \
    apt-get -qq update \
    && \
    apt-get -qq install --no-install-recommends -y \
        intel-gpu-tools \
        python3-pip \
        tini \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && apt-get autoremove -y \
    && apt-get clean \
    && pip install --no-cache-dir -r requirements.txt \
    && rm -rf \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/cache/apt/* \
        /var/tmp/*

ENTRYPOINT ["/usr/bin/tini", "--", "/usr/bin/python3"]
#CMD ["/app/exporter.py"]
CMD ["/app/exporter.py", "9101", "http://localhost:9101/metrics" ]

LABEL \
    org.opencontainers.image.title="intel-gpu-exporter" \
    org.opencontainers.image.authors="Andrew Golikov <andrewgolikov55@gmail.com>" \
    org.opencontainers.image.source="https://github.com/AndrewGolikov55/intel_gpu_exporter"
