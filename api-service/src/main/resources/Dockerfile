FROM eclipse-temurin:17.0.8_7-jre-centos7
LABEL authors="wck"
ENV PORT 8564
ENV AGGENT 8815
ENV JARNAME gpsiot.jar
ENV XMX 4096m
ENV XMS 512m
ENV TZ Asia/Shanghai
WORKDIR /src
EXPOSE ${PORT}
EXPOSE ${AGGENT}
ADD  ./${JARNAME} /src/${JARNAME}
CMD ["/bin/bash", "-c", "java --add-opens java.base/java.lang.invoke=ALL-UNNAMED --add-opens java.base/java.util=ALL-UNNAMED -Xms${XMS} -Xmx${XMX}  -XX:ReservedCodeCacheSize=240m  -XX:SoftRefLRUPolicyMSPerMB=50 -server -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:${AGGENT}  -jar /src/${JARNAME}"]

ENTRYPOINT ["top", "-b"]