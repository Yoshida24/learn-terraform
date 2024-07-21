# Dockerfile
FROM  --platform=linux/amd64 python:3.11-slim

# 作業ディレクトリを設定
WORKDIR /app

# 依存関係をコピーし、インストール
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# アプリケーションのソースコードをコピー
COPY . .

# EXPOSE 8080 と指定すると VM起動時のポート割り当てが -p 8080:8080 相当になる。
EXPOSE 81

# uvicornを使用してアプリケーションを起動
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "81"]
