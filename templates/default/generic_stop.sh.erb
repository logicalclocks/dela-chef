#!/bin/bash
set -e

SERVICE_NAME=$1
PID_FILE=$2 
#LOG=/srv/delabootstrap/srv.log
#touch $LOG

function kill_named {
  PID=`ps aux | grep -i ${SERVICE_NAME}.jar | grep -i java | grep -v grep | grep -v karamel | grep -v chef | awk 'NR==1{print $2}'`
  #echo $PID >> $LOG
  if [ "$PID" != "" ] ; then
    kill -9 $PID > /dev/null 2>&1 
    res=$?
  else
    res=0
  fi
  return $res
}

res=1

if [ -f $PID_FILE ] ; then
  PID=`cat $PID_FILE`
  if ps -p $PID > /dev/null 
  then
    kill $PID > /dev/null 2>&1
    res=$?
  fi
fi

if [ $res -ne 0 ] ; then
  kill_named
fi

rm -f ${PID_FILE}

if [ $res -eq 0 ] ; then
    echo "Killed $SERVICE_NAME"
    #echo "Killed $SERVICE_NAME" >> $LOG
else
    echo "Could not find $SERVICE_NAME process to kill"
    #echo "Could not find $SERVICE_NAME process to kill" >> $LOG
fi

exit $res