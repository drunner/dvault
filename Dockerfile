# Docker file to run Hashicorp Vault (vaultproject.io)
FROM drunner/baseimage-alpine
MAINTAINER drunner

RUN apk add --update bash curl wget gnupg python py-pip && rm -rf /var/cache/apk/*

RUN wget https://releases.hashicorp.com/vault/0.5.1/vault_0.5.1_linux_amd64.zip \
    && unzip vault_0.5.1_linux_amd64.zip \
    && mv vault /usr/local/bin/vault
    
RUN pip install hvac

# add in the assets.
COPY ["./drunner","/drunner"]
RUN chmod a-w -R /drunner

COPY ["entrypoint.sh", "/entrypoint.sh"]
RUN mkdir -p /output && chown druser:drgroup /output && chmod a+w /output && chmod a+x /entrypoint.sh

COPY ["usrlocalbin", "/usr/local/bin"]

RUN chmod a+x /usr/local/bin/*

VOLUME ["/config"]

# lock in druser.
ENTRYPOINT ["/entrypoint.sh"]
USER druser
