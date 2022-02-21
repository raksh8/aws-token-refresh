FROM scratch

WORKDIR /app

ADD . /app

CMD ["sh", "aws-token-refresh.sh"]
