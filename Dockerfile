FROM php:7-cli

ENV PHPSTAN_VERSION 0.11.5
ENV PHPCS_VERSION 3.4.2
ENV PHAN_VERSION 1.2.8
ENV REVIEWDOG_VERSION 0.9.11

RUN curl -sL "http://static.phpmd.org/php/latest/phpmd.phar" -o /usr/bin/phpmd
RUN curl -sL "https://github.com/phpstan/phpstan/releases/download/${PHPSTAN_VERSION}/phpstan.phar" -o /usr/bin/phpstan
RUN curl -sL "https://github.com/squizlabs/PHP_CodeSniffer/releases/download/${PHPCS_VERSION}/phpcs.phar" -o /usr/bin/phpcs
RUN curl -sL "https://github.com/phan/phan/releases/download/${PHAN_VERSION}/phan.phar" -o /usr/bin/phan
RUN curl -sL "https://github.com/reviewdog/reviewdog/releases/download/${REVIEWDOG_VERSION}/reviewdog_linux_amd64" -o /usr/bin/reviewdog

RUN chmod +x /usr/bin/phpmd \
    && chmod +x /usr/bin/phpcs \
    && chmod +x /usr/bin/phan \
    && chmod +x /usr/bin/reviewdog

RUN apt-get update && apt-get install -y git \
    && rm -r /var/lib/apt/lists/*

VOLUME ["/app"]
WORKDIR /app

ENTRYPOINT ["reviewdog"]
