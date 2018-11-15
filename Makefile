build:
	sudo docker build -t sbdemo .
run:
	sudo docker run -d -p 8080:8080 sbdemo
	sleep 7
test:
	curl http://127.0.0.1:8080
