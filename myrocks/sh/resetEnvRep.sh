#! /bin/bash
#
# resetEnvRep.sh applies only when MYRRUNMODE is set to 1
   if [ "$MYRRUNMODE" != "1" ]; then
      exit
   fi   
#
# setup directories
   buildName=$1
   if [ "$buildName" = "" ]; then
      echo Missing build name
      echo Usage: $0 reptest
      exit 
   fi
#
   testDir=$MYRRELHOME/$buildName
   echo Module: $0 TestDir=$testDir
#
# stop mysqld servers if exist
   killall mysqld
   sleep 3
#
# Get a fresh copy of the databases
   echo 1. Copying a fresh copy of databases
   $MYRHOME/myrocks/sh/copyDBRep.sh $buildName
#
# Start replication stack, master and slave
   echo 2. Starting replication stack
   $MYRHOME/myrocks/sh/startEnvRep.sh $buildName
#
# Sync replication between master and slave
  echo 3. Syncing replication master and slave
  sleep 3
   $MYRHOME/myrocks/sh/syncEnvRep.sh $buildName
#
   ps -ef |grep mysqld
#