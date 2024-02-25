FROM python:3.9-slim as compiler

WORKDIR /app/

RUN python -m venv /opt/venv

ENV PATH="/opt/venv/bin:$PATH"

COPY ShortMe-URL-Shortener/requirements.txt /app/requirements.txt

RUN pip install -r requirements.txt

FROM python:3.9-slim as runner

WORKDIR /app/

COPY --from=compiler /opt/venv /opt/venv

COPY ShortMe-URL-Shortener /app/

ENV PATH="/opt/venv/bin:$PATH"
ENV FLASK_ENV=development
ENV FLASK_APP=run.py

EXPOSE 5000

CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]

