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

# Base on the official ThingsBoard PostgreSQL image
FROM thingsboard/tb-postgres:latest

# Switch to root to modify files
USER root

# Replace the ThingsBoard server JAR with your forked build
COPY application/target/thingsboard-4.4.0-SNAPSHOT-boot.jar \
     /usr/share/thingsboard/bin/thingsboard.jar

# Fix ownership (ThingsBoard does not run as root)
RUN chown thingsboard:thingsboard /usr/share/thingsboard/bin/thingsboard.jar

# Switch back to the thingsboard user
USER thingsboard

# Expose required ports
EXPOSE 9090 1883