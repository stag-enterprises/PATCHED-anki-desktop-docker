FROM lsiobase/kasmvnc:ubuntujammy

ARG ANKI_VERSION=25.02.5

RUN \
  apt-get update && \
  apt-get install --no-install-recommends -y wget zstd xdg-utils libxcb-xinerama0 libxcb-cursor0 libnss3 && \
  wget https://github.com/ankitects/anki/releases/download/${ANKI_VERSION}/anki-${ANKI_VERSION}-linux-qt6.tar.zst && \
  tar --use-compress-program=unzstd -xvf anki-${ANKI_VERSION}-linux-qt6.tar.zst && \
  cd anki-${ANKI_VERSION}-linux-qt6 && ./install.sh &&  cd .. && \
  rm -rf anki-${ANKI_VERSION}-linux-qt6 anki-${ANKI_VERSION}-linux-qt6.tar.zst && \
  apt-get purge -y --auto-remove wget zstd && \
  apt-get clean && \
  mkdir -p /config/.local/share && \
  ln -s /config/app/Anki  /config/.local/share/Anki && \
  ln -s /config/app/Anki2 /config/.local/share/Anki2 && \
  echo software >/config/.local/share/Anki2/gldriver6

VOLUME "/config/app" 

COPY ./root /
