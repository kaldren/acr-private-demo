FROM python:3.13
WORKDIR /app
ENV HELLO_MESSAGE="Hello from the backend!"
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 8686
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8686"]