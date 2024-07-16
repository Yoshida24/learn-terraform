# Dockerfile
FROM python:3.9

# 作業ディレクトリを設定
WORKDIR /app

# 依存関係をコピーし、インストール
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# アプリケーションのソースコードをコピー
COPY . .

# uvicornを使用してアプリケーションを起動
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]
