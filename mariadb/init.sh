#!/bin/bash

mysqld &

sleep 5

mysql -u root < ./init.sql

wait