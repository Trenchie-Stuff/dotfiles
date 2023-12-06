#!/bin/bash

function artist
{
  playerctl metadata --format '{{ trunc(artist,35) }}' -F
}

function albumartist
{
  playerctl metadata --format '{{ trunc(albumartist,35) }}' -F
}

function album
{
  playerctl metadata --format '{{ trunc(album,35) }}' -F
}

function title
{
  playerctl metadata --format '{{ trunc(title,35) }}' -F
}

function lyrics
{
  sptlrc pipe
}

function year
{
  playerctl metadata --format '{{ trunc(year,35) }}' -F
}

case $1 in
  artist) artist;;
  album) album;;
  title) title;;
  lyrics) lyrics;;
  year) year;;
  *) echo "-- artist|album|title|year|lyrics"
esac;
