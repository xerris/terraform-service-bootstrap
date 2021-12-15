FROM public.ecr.aws/lambda/nodejs:12

RUN yum install -y amazon-linux-extras fontconfig && \
  yum clean metadata


WORKDIR /usr/src/app

ARG NODE_ENV
ENV NODE_ENV=$NODE_ENV
RUN echo "NODE_ENV = $NODE_ENV"

#
