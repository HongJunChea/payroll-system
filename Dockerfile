FROM classiccontainers/dosbox

WORKDIR /app

COPY . .

ENTRYPOINT ["dosbox"]