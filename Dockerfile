FROM registry.access.redhat.com/ubi8/ubi AS builder
RUN dnf install -y python3-pip
RUN mkdir /app
WORKDIR /app
COPY requirements.txt .
RUN pip3 install  --prefix=/app -r requirements.txt


FROM registry.access.redhat.com/ubi8/ubi-minimal
RUN microdnf install -y python3
RUN mkdir /app
WORKDIR /app
COPY --from=builder /app /app 
COPY hello_world.py .
ENV PYTHONPATH=/app/lib64/python3.6/site-packages:$PYTHONPATH
CMD [ "python3", "./hello_world.py" ]