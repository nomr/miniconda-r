FROM continuumio/miniconda

# By keeping a lot of discrete steps in a single RUN we can clean up after
# ourselves in the same layer. This is gross but it saves ~100MB in the image
RUN set -ex \
    && apt-get update -yqq \
    && apt-get install -y lsb-release binutils \
    && apt-get install -y libc-dev libcloog-isl4 libmpfr4 libmpc3 make \
    # \
    # create r environment \
    && conda create -n r -c r -c conda-forge r-base openjdk gcc \
    && mv /opt/conda/envs/r/include/include/* /opt/conda/envs/r/include \
    # \
    # clean up to minimize image layer size
    && rm -rf /var/lib/apt/lists/* \
    && apt-get purge -y --auto-remove $buildDeps \
