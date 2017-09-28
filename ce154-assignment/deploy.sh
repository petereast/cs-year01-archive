#!/bin/env bash

echo "Deploying website..."

echo "\tAdding timestamp..."

echo "Deploy: $(date)" > timestamp.html

echo "\tGenerating .war file..."
jar cvf 1604513.war *

echo "\tDeploying to server..."
smbclient //csee5/tomcat-user --user="$USER" -W CAMPUS -c="put 1604513.war"

echo "\tCleaning up..."
rm 1604513.war

echo "Done :)"

