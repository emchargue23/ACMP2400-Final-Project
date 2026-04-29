FROM python:3.13.13-slim-trixie@sha256:2ba73a4dc380f21137fc75296abfa2add90b51fd10b609ce530b40cc097269b1

WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
