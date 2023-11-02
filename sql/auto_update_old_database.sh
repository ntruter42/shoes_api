#!/bin/zsh
while inotifywait -e close_write sql/prod.reset_old.sql; do
    psql postgresql://codex-coder:codex123@localhost:5432/codex42 -f sql/prod.reset_old.sql
done