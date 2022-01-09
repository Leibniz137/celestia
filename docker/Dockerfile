FROM golang:1.17
RUN apt update && \
    apt install make bash
COPY submodules/celestiaorg/celestia-node/ /root/celestia-node/
COPY submodules/celestiaorg/celestia-app/ /root/celestia-app/

WORKDIR /root/celestia-node
RUN env GOOS=linux GOARCH=amd64 make install

WORKDIR /root/celestia-app
RUN env GOOS=linux GOARCH=amd64 make install

ENV NODE_TYPE full

COPY docker/entrypoint.sh /
RUN chmod 0755 /entrypoint.sh

EXPOSE 2121

ENTRYPOINT ["celestia-appd"]
CMD ["start"]
WORKDIR /root/
