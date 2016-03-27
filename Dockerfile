# Docker file to run Hashicorp Vault (vaultproject.io)
FROM drunner/baseimage-alpine
MAINTAINER drunner

RUN apk add --update bash curl wget gnupg python py-pip sudo && rm -rf /var/cache/apk/*
RUN echo "druser ALL= (ALL) NOPASSWD:ALL" > /etc/sudoers.d/druser

RUN wget https://releases.hashicorp.com/vault/0.5.1/vault_0.5.1_linux_amd64.zip \
    && unzip vault_0.5.1_linux_amd64.zip \
    && mv vault /usr/local/bin/vault

RUN pip install hvac

# add in the assets.
COPY ["./drunner","/drunner"]
RUN chmod a-w -R /drunner

RUN mkdir -p /output && chown druser:drgroup /output && chmod a+w /output 

COPY ["usrlocalbin", "/usr/local/bin"]

RUN chmod a+x /usr/local/bin/*

VOLUME ["/config"]

# commented out this entrypoint, as configuration is stored in environment variables now
#ENTRYPOINT ["/entrypoint.sh"]

# lock in druser.
USER druser
