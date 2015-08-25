#!/usr/bin/env bats
setup(){
  source .dot/usage.sh
}

@test "Usage: every call function exists" {
  run usage
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" =~ "usage".* ]]
  run usage_add
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" =~ "usage".* ]]
  run usage_remove
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" =~ "usage".* ]]
  run usage_backup
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" =~ "usage".* ]]
  run usage_block
  [[ "${lines[0]}" =~ "usage".* ]]
  [ "$status" -eq 0 ]
}

@test "Usage: use every text call" {
  run usagetxt "main"
  [[ "${lines[0]}" =~ "usage".* ]]
  [ "$status" -eq 0 ]
  run usagetxt add
  [[ "${lines[0]}" =~ "usage".* ]]
  [ "$status" -eq 0 ]
  run usagetxt backup
  [[ "${lines[0]}" =~ "usage".* ]]
  [ "$status" -eq 0 ]
  run usagetxt block
  [[ "${lines[0]}" =~ "usage".* ]]
  [ "$status" -eq 0 ]
  run usagetxt remove
  [[ "${lines[0]}" =~ "usage".* ]]
  [ "$status" -eq 0 ]
}

@test "Usage: Give non existant argument" {
  run usagetxt "hello"
  [[ "$output" =~ "No such file or directory".* ]]
  [ ! "$status" -eq 0 ]
}

