#!/bin/bash
######################################################
# retrieves a set of key-value-pairs for namespace,
# application, user and password and then creates a
# kubernetes configmap under the name
#
#     {application}-db-credentials
#
# in given namespace for holding the database
# credentials
######################################################
echo initializing postgres data base
read -p "namespace: " -r namespace
read -p "application: " -r application
read -p "user: " -r user
read -p "password: " -s -r password
dbName=${application}-db
kubectl -n "$namespace" create configmap "${dbName}-credentials"\
 --from-literal=user="$user"\
 --from-literal=password="$password"