all:
	make build
	make assignment

build:
	mkdir bin -p
	javac ./src/* -sourcepath ./src/ -d ./bin/

assignment:
	echo "Zipping assignment..."
	zip -r "Peter East - 1604513.zip" ./src/
	
demo:
	make build
	cd bin && java Assignment/Exercise1 && cd ..

clean:
	rm -fr ./bin/*
	rm -f *.zip
	
pre:
	echo "Installing dependancies using APT"
	apt install oracle-java7-jdk zip

