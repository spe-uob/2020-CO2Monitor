
# Make sure that mysql server processes are running.
/etc/init.d/mysql start
service mysql start

# Get public ip 
ip = $(curl ifconfig.me)
# Get mysql port
port = $(lsof -i -P -n | grep LISTEN | grep mysql | grep \*)

echo "My public ip = " $ip /n

echo "Info about mysql port:/n" $port
# Run the Spring-Boot program (should change this for final build)
./mvnw spring-boot:run
