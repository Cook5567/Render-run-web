# Sử dụng Ubuntu làm base image
FROM ubuntu:20.04

# Thiết lập các biến môi trường để tự động bỏ qua các yêu cầu nhập tay
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Cập nhật danh sách gói và cài đặt các gói cần thiết
RUN apt-get update && apt-get install -y \
    wget \
    sudo \
    libnss3-dev \
    gconf-service \
    libasound2 \
    libatk1.0-0 \
    libc6 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libexpat1 \
    libfontconfig1 \
    libgcc1 \
    libgconf-2-4 \
    libgdk-pixbuf2.0-0 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libstdc++6 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    ca-certificates \
    fonts-liberation \
    libappindicator1 \
    lsb-release \
    xdg-utils \
    libgbm-dev

# Tải về và cài đặt Google Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    sudo dpkg -i google-chrome-stable_current_amd64.deb || sudo apt-get install -f -y && \
    rm google-chrome-stable_current_amd64.deb

# Expose port 9222 cho remote debugging
EXPOSE 9222

# Chạy Google Chrome ở chế độ headless
CMD google-chrome --headless --disable-gpu --no-sandbox --remote-debugging-port=9222 --enable-logging --log-level=0 --noerrdialogs --disable-session-crashed-bubble --disable-infobars --disable-dev-shm-usage --user-data-dir=/tmp https://cook5567.github.io/Web/ > chrome.log 2>&1
