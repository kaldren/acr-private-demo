FROM python:3.13
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 9696
# Run streamlit app on container's port 9696
CMD ["streamlit", "run", "main.py", "--server.port=9696", "--server.address=0.0.0.0"]