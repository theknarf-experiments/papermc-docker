FROM openjdk:11

ARG JAR_DOWNLOAD_PATH="https://papermc.io/api/v2/projects/paper/versions/1.16.5/builds/651/downloads/paper-1.16.5-651.jar"
WORKDIR /prepare
EXPOSE 25565
VOLUME [ "/minecraft" ]

# Download server jar and accept eula
RUN \
	wget -O server.jar $JAR_DOWNLOAD_PATH && \
	chmod +x server.jar && \
	echo "eula=true" > eula.txt

# To support volumes we copy files on start over from the /prepare directory to the volume
run \
	echo "#!/bin/sh" > script.sh && \
	echo "cp /prepare/* /minecraft" >> script.sh && \
	echo "cd /minecraft" >> script.sh && \
	echo "java -Xmx1024M -Xms1024M -jar ./server.jar nogui" >> script.sh && \
	chmod +x script.sh

CMD [ "./script.sh" ]
