
# Make sure that mysql server processes are running.
/etc/init.d/mysql start
service mysql start
# Show the user their public ip
echo "My public ip = "
curl ifconfig.me
# Show user the mysql port
echo "Info about mysql port:"
lsof -i -P -n | grep LISTEN | grep mysql | grep \*
# Run the Spring-Boot program (should change this for final build)
./mvnw spring-boot:run
