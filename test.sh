#!/usr/bin/env bash

cmd=./maccess+
td=./testdir

setup(){
  # create directory for test file
  mkdir $td
}

teardown(){
  # remove test directory
  rm -r $td
}

testHaveAllPerms(){
  echo -n "Test 1 ... "
  touch $td/file
  chmod 700 $td/file
  ($cmd -rwx $td/file && echo "OK") || echo "FAIL"
  rm $td/file
}

testHaveNoPerms(){
  echo -n "Test 2 ... "
  touch $td/file
  chmod 000 $td/file
  ($cmd -r $td/file && echo "FAIL") || (
    ($cmd -w $td/file && echo "FAIL") || (
      ($cmd -x $td/file && echo "FAIL") || echo "OK"
    )
  )
  rm -f $td/file
}

testHaveOnePerms(){
  echo -n "Test 3 ... "
  touch $td/file
  chmod 100 $td/file
  ($cmd -r $td/file && echo "FAIL") || (
    ($cmd -w $td/file && echo "FAIL") || (
      ($cmd -x $td/file && echo "OK") || echo "FAIL"
    )
  )
  rm -f $td/file
}

testNotExist(){
  echo -n "Test 4 ... "
  ($cmd -r $td/blabla && echo "FAIL") || (
    ($cmd -w $td/blabla && echo "FAIL") || (
      ($cmd -x $td/blabla && echo "FAIL") || echo "OK"
    )
  )
}

main(){
  setup

  testHaveAllPerms
  testHaveNoPerms
  testHaveOnePerms
  testNotExist

  teardown
}

main
