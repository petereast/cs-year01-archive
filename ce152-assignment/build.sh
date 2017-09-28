#!/bin/bash
echo "Building project..."
javac ./src/* -sourcepath ./src/ -d ./bin/
echo "Build complete!"

