FROM alpine:latest

RUN apk --no-cache add bash dash zsh gettext && \
    apk --no-cache add --virtual .builddeps build-base gettext gettext-dev ncurses-dev gcc asciidoc git && \
        git clone --depth "1" --branch "trunk" https://github.com/magicant/yash "yash_src" && \
            cd "yash_src" && ./configure && make && make install && \
    apk del .builddeps
