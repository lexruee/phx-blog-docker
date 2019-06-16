#!/usr/bin/env sh

cd assets && npm install
cd ..
mix deps.get
mix ecto.create
mix ecto.migrate
mix phx.server
