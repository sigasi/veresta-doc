# Based on a light-weight python container
FROM python:3-slim-bullseye

# Unpack Sigasi Veresta in the current directory before building the container
COPY sigasi-veresta /opt/sigasi-veresta

# Configure the correct license for your setup
ENV PATH="/opt/sigasi-veresta:${PATH}" \
    SIGASI_LM_LICENSE_FILE=27040@elvis
