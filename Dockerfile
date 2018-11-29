from ruby:2.3-alpine

RUN \
rm -rf /app && \
mkdir -p /app

COPY . /app
WORKDIR /app

RUN apk update

RUN apk add mariadb-dev

RUN apk add python python-dev py-pip build-base

RUN echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

RUN apk add --update --no-cache ca-certificates gcc g++ gfortran

RUN ln -s /usr/include/locale.h /usr/include/xlocale.h

RUN \
gem install bundler && \
bundle install

EXPOSE 9393

CMD ["shotgun", "config.ru", "--host=0.0.0.0"]
