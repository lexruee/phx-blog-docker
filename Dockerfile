FROM elixir:1.8.1-alpine
RUN apk add --update nodejs-current nodejs-npm \
    && rm -rf /var/cache/apk/*
RUN mix local.hex --force \
    && mix local.rebar --force \
    && mix archive.install --force hex phx_new 1.4.3
WORKDIR /app
#RUN cd assets && npm install
#CMD ["mix", "phx.server"]
EXPOSE 4000
