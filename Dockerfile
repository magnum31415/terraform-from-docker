FROM centos:7
RUN yum install -y yum-utils
RUN yum install -y unzip
RUN yum install -y git

ARG TERRAFORM_VERSION=0.12.31
ENV TERRAFORM_FILE=terraform_${TERRAFORM_VERSION}_linux_amd64.zip

RUN curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/${TERRAFORM_FILE} -o  ${TERRAFORM_FILE}\
    && unzip ${TERRAFORM_FILE} -d /bin \
    && rm -rf ${TERRAFORM_FILE}

RUN curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o "awscliv2.zip"; \
    unzip awscliv2.zip; \
    ./aws/install --update; \
    rm -rf ./aws awscliv2.zip;


COPY files/credentials /root/.aws/credentials
COPY files/config /root/.aws/config
COPY files/id_rsa /root/.ssh/
COPY files/id_rsa.pub /root/.ssh/
EXPOSE 80
