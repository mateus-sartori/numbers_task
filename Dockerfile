FROM hexpm/elixir:1.12.2-erlang-24.0.4-debian-stretch-20210326

ENV ERL_AFLAGS="-kernel shell_history enabled"
ENV TZ="America/Sao_Paulo"

RUN mix do \
  local.hex --force, \
  local.rebar --force, \
  archive.install --force hex phx_new 1.6.5

RUN apt-get update && \
  apt-get install -y postgresql-client

# Create app directory and copy the Elixir projects into it.
RUN mkdir /app
COPY . /app
WORKDIR /app

# Install Hex package manager.
RUN mix local.hex --force

# Compile the project.
RUN mix do compile