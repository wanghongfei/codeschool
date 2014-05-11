#!/bin/bash

if [ "dep" == "$1" ]; then
	echo "仅部署"
	cp -f ./target/codeschool.war $JBOSS_HOME/standalone/deployments
	exit 0
fi

if [ "undeploy" == "$1" ]; then
	echo "取消部署"
	rm -f $JBOSS_HOME/standalone/deployments/codeschool.war
	exit 0
fi

mvn clean install
cp -f ./target/codeschool.war $JBOSS_HOME/standalone/deployments
