Install front end javascript with npm install.
Navigate to resources/static 
Run "npm install"


Launch docker: 
docker build --build-arg JAR_FILE=build/libs/*.jar -t erw444/website-frontend .

docker run -p 8080:5000 erw444/website-frontend

Run with active profiles:
docker run -e "SPRING_PROFILES_ACTIVE=prod" -p 8080:8080 -t erw444/website-frontend

docker run -e "JAVA_TOOL_OPTIONS=-agentlib:jdwp=transport=dt_socket,address=5005,server=y,suspend=n" -p 8080:8080 -p 5005:5005 -t erw444/website-frontend