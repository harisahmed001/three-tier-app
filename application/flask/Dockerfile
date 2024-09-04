FROM python:3.9-alpine
WORKDIR /home/app
COPY . .
RUN pip install -t requirements.txt
CMD python migrate.py && python app.py