# Initially generated using ChatGPT - chat.openai.com
# Update the package manager cache
sudo apt update

# Install dependencies
sudo apt install -y libcairo2-dev libjpeg62-turbo-dev libpng-dev libossp-uuid-dev \
  libavcodec-dev libavutil-dev libswscale-dev libfreerdp-dev libpango1.0-dev \
  libssh2-1-dev libtelnet-dev libvncserver-dev libpulse-dev libssl-dev \
  libvorbis-dev libwebp-dev mysql-server mysql-client mysql-common mysql-utilities

# Download the latest version of Apache Guacamole
wget https://downloads.apache.org/guacamole/1.4.0/source/guacamole-server-1.4.0.tar.gz

# Extract the downloaded tarball
tar -xzf guacamole-server-1.4.0.tar.gz

# Change into the extracted directory
cd guacamole-server-1.4.0

# Run the configure script
./configure --with-init-dir=/etc/init.d

# Build and install Apache Guacamole
make
sudo make install

# Add the guacd user and group
sudo adduser --system --no-create-home --disabled-login guacd

# Start the Guacamole daemon
sudo systemctl enable guacd
sudo systemctl start guacd

# Set the MySQL password for root
mysql -u root -p <<EOF
  SET PASSWORD FOR 'root'@'localhost' = PASSWORD('mypassword');
  CREATE DATABASE guacamole_db;
  CREATE USER 'guacamole_user'@'localhost' IDENTIFIED BY 'mypassword';
  GRANT SELECT,INSERT,UPDATE,DELETE ON guacamole_db.* TO 'guacamole_user'@'localhost';
  FLUSH PRIVILEGES;
EOF

# Install the Guacamole client
sudo apt install -y libcairo2-dev libjpeg62-turbo-dev libpng-dev libossp-uuid-dev \
  libavcodec-dev libavutil-dev libswscale-dev libfreerdp-dev libpango1.0-dev \
  libssh2-1-dev libtelnet-dev libvncserver-dev libpulse-dev libssl-dev \
  libvorbis-dev libwebp-dev mysql-client mysql-common mysql-utilities

# Download the latest version of the Guacamole client
wget https://downloads.apache.org/guacamole/1.3.0/binary/guacamole-1.4.0.war

# Move the downloaded war file to the Tomcat webapps directory
sudo mv guacamole-1.4.0.war /etc/tomcat9/webapps/

# Restart Tomcat
sudo systemctl restart tomcat9

# Set the MySQL password for root
mysql -u root -p <<EOF
  SET PASSWORD FOR 'root'


# to add: libssl, libogg, libvorbis, libvorbisenc, libpulse, FreeRDP (libfreerdp2 /(libfreerdp2 / libfreerdp-client2 / libwinpr2)
# libwebp, libwebsockets, libjpeg62-turbo-dev, libfreerdp-dev, mysql-utilities
# TO DO: scrub dependencies, fix some of the mysql stuff, make it work 