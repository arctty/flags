FROM kalilinux/kali-rolling:latest

COPY ./apt-intersect /tmp

RUN apt-get update && \
  ( \
    /tmp/apt-intersect kali-linux-headless kali-tools-web | \
    xargs apt-get install -y --no-install-recommends \
  ) && rm /tmp/apt-intersect && \
  rm -rf /var/lib/apt/lists/*

