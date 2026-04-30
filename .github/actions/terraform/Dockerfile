FROM ubuntu-latest@sha256:7607b6f97024ef850f1bd6e91a89273beb5973d04432c5b87f15f813d64b9c05

RUN apt-get update && apt-get install -y --no-install-recommends gnupg software-properties-common curl

RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

RUN apt-get update && apt-get install -y terraform

WORKDIR /github/workspace

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
