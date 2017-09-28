#!/bin/bash

echo "Build..."
javac ./src/* -sourcepath ./src/ -d ./bin/
#jar -cv0 ./bin/* -e Lab4/FileIO/Lab01.class > out.jar
cd bin && java lab4/FileIO/Poly
#java lab4/FileIO/TestCSV
#java lab4/FileIO/Chessboard
#java lab4/FileIO/Poly
cd ..
