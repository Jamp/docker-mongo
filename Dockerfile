FROM mongo:3.6.2

MAINTAINER Jaro Marval <jaro at tooldata dot com dot co>
LABEL maintaner="Jaro Marval <jaro at tooldata dot com dot co>"

COPY ./start.sh /start.sh
COPY ./create-user.sh /create-user.sh

RUN chmod +x /start.sh
RUN chmod +x /create-user.sh

EXPOSE 27017

ENTRYPOINT mongo
CMD ["/start.sh"]
