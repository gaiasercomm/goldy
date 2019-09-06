FROM alpine:3.9 as builder

RUN apk add --update build-base curl git

ARG SRC_TAG=master
RUN git clone https://github.com/gaiasercomm/goldy.git -b $SRC_TAG /src
WORKDIR /src

# ADD . /src

RUN make deps && make

FROM alpine:3.9

COPY --from=builder /src/goldy /usr/local/bin/

ADD entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
