#
# Copyright © 2016-2026 The Thingsboard Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FROM eclipse-temurin:17-jre

ENV DATA_FOLDER=/data
ENV HTTP_BIND_PORT=9090

# Create thingsboard user
RUN groupadd -r thingsboard && useradd -r -g thingsboard thingsboard

# Create necessary directories
RUN mkdir -p ${DATA_FOLDER} /var/log/thingsboard && \
    chown -R thingsboard:thingsboard ${DATA_FOLDER} /var/log/thingsboard

# Copy the built JAR file (Spring Boot creates a -boot.jar file)
COPY application/target/thingsboard-*-boot.jar /usr/share/thingsboard/bin/thingsboard.jar

# Set permissions
RUN chmod 555 /usr/share/thingsboard/bin/thingsboard.jar && \
    chown thingsboard:thingsboard /usr/share/thingsboard/bin/thingsboard.jar

USER thingsboard

WORKDIR /usr/share/thingsboard

EXPOSE 9090
EXPOSE 1883
EXPOSE 5683/udp
EXPOSE 5685/udp
EXPOSE 5686/udp

VOLUME ["/data"]

# Run ThingsBoard
ENTRYPOINT ["java", "-jar", "/usr/share/thingsboard/bin/thingsboard.jar"]
