FROM python:3

WORKDIR /flask

RUN mkdir -p flask

COPY . /flask

# Install the application dependencies
# COPY requirements.txt ./

RUN  pip install --no-cache-dir --upgrade pip && pip install --no-cache-dir -r /flask/requirements.txt

# Copy in the source code
# COPY src ./src
EXPOSE 5000

CMD ["python3","/flask/app.py"]

