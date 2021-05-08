# Make sure that mysql server processes are running.
/etc/init.d/mysql start
service mysql start

# Run the Spring-Boot program (should change this for final build)
./mvnw spring-boot:run
