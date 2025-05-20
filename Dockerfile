FROM lsiobase/kasmvnc:ubuntujammy

ARG ANKI_VERSION=25.02.5

RUN \
  apt-get update && \
  apt-get install -y wget zstd xdg-utils libxcb-xinerama0 libxcb-cursor0 libnss3 libxcb-icccm4 libxcb-keysyms1 libxkbcommon-x11-0 && \
  wget https://github.com/ankitects/anki/releases/download/${ANKI_VERSION}/anki-${ANKI_VERSION}-linux-qt6.tar.zst && \
  tar --use-compress-program=unzstd -xvf anki-${ANKI_VERSION}-linux-qt6.tar.zst && \
  cd anki-${ANKI_VERSION}-linux-qt6 && ./install.sh &&  cd .. && \
  rm -rf anki-${ANKI_VERSION}-linux-qt6 anki-${ANKI_VERSION}-linux-qt6.tar.zst && \
  apt-get purge -y --auto-remove wget zstd && \
  apt-get clean && \
  mkdir -p /config/.local/share/Anki2 && \
  echo software >/config/.local/share/Anki2/gldriver6

VOLUME "/config/.local/share/Anki2" 

COPY ./root /
