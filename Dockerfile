FROM alpine/git:latest as code
WORKDIR /srv
RUN git clone https://github.com/ztj-archived/uni-app-dev.git .
RUN rm -rf .git

FROM node:latest as builder
COPY --from=code /srv /srv
WORKDIR /srv
RUN yarn install

FROM node:latest
LABEL maintainer="Ztj <ztj1993@gmail.com>"
COPY --from=builder /srv /srv
WORKDIR /srv
EXPOSE 80
CMD ["yarn", "serve"]
