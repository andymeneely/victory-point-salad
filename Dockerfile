FROM andymeneely/squib:latest

RUN mkdir ~/.fonts
COPY fonts/*.otf /usr/share/fonts/
COPY fonts/*.ttf /usr/share/fonts/
RUN fc-cache -f -v /usr/share/fonts/

WORKDIR /usr/src/app
