#!/usr/bin/env bats

@test "A test I don't want to execute for now" {
  skip "This command will return zero soon, but not now"
  run foo
  [ "$status" -eq 0 ]
}

