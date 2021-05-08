
# Make sure that mysql server processes are running.
/etc/init.d/mysql start
service mysql start
# Get public ip 
echo "My public ip = "
curl ifconfig.me
echo $ip
# Get mysql port
echo "Info about mysql port:\n"
lsof -i -P -n | grep LISTEN | grep mysql | grep \*
# Run the Spring-Boot program (should change this for final build)
./mvnw spring-boot:run
