FROM bitwalker/alpine-elixir-phoenix:latest AS builder

# # install build dependencies
RUN apk add --update git build-base python3

RUN mkdir /app
WORKDIR /app






# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force


# set build ENV
ENV MIX_ENV=prod

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN HEX_HTTP_CONCURRENCY=1 HEX_HTTP_TIMEOUT=480 mix do deps.get, deps.compile


# build project
COPY . .
RUN mix compile

# build release
# at this point we should copy the rel directory but
# we are not using it so we can omit it
# COPY rel rel
RUN mix release

# prepare release image
FROM bitwalker/alpine-elixir:latest AS app

ENV MIX_ENV=prod

# prepare app directory
RUN mkdir /app
WORKDIR /app

# copy release to app container
COPY --from=builder /app/_build/prod/rel/google_meet_api .
COPY entrypoint.sh .
RUN chown -R nobody: /app
USER nobody

ENV HOME=/app

EXPOSE 4000

CMD ["bash", "/app/entrypoint.sh"]