FROM quay.io/lyfe00011/md:beta

RUN if command -v apt-get >/dev/null 2>&1; then \
      apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*; \
    elif command -v apk >/dev/null 2>&1; then \
      apk add --no-cache git; \
    elif command -v dnf >/dev/null 2>&1; then \
      dnf install -y git && dnf clean all; \
    elif command -v yum >/dev/null 2>&1; then \
      yum install -y git && yum clean all; \
    else \
      echo "No supported package manager found"; exit 1; \
    fi

WORKDIR /app

COPY . .

RUN yarn install

CMD ["npm", "start"]
