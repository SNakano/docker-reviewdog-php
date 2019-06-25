FROM php:7-cli

ENV PHPSTAN_VERSION 0.11.8
ENV PHPCS_VERSION 3.4.2
ENV PHAN_VERSION 2.2.3
ENV REVIEWDOG_VERSION v0.9.12

RUN curl -sL "https://github.com/phpstan/phpstan/releases/download/${PHPSTAN_VERSION}/phpstan.phar" -o /usr/bin/phpstan
RUN curl -sL "https://github.com/squizlabs/PHP_CodeSniffer/releases/download/${PHPCS_VERSION}/phpcs.phar" -o /usr/bin/phpcs
RUN curl -sL "https://github.com/phan/phan/releases/download/${PHAN_VERSION}/phan.phar" -o /usr/bin/phan
RUN curl -sfL https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh | sh -s -- -b /usr/bin

RUN chmod +x /usr/bin/phpstan \
    && chmod +x /usr/bin/phpcs \
    && chmod +x /usr/bin/phan

RUN apt-get update \
    && apt-get install -y git \
    && rm -r /var/lib/apt/lists/*

COPY --from=snakano/javascript-lint /usr/local/bin/jsl /usr/bin/jsl

VOLUME ["/app"]
WORKDIR /app

ENTRYPOINT ["reviewdog"]
