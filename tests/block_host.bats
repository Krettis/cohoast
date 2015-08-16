#!/usr/bin/env bats
setup(){
  source .dot/block_host.sh
  vcategory="category"
  vip="127.0.0.1"
}


@test "Block: Accepts three arguments" {
  run block_host
  [ "$status" -eq 1 ]
  run block_host "$vcategory"
  [ "$status" -eq 1 ]
  run block_host "$vcategory" "$vip" 
  [ "$status" -eq 1 ]
  run block_host "$vcategory" "$vip" "adecenthost.com" "extra argument"
  [ "$status" -eq 1 ]
}

@test "Block: Categoryname should be at least three characters long" {
  run block_host "" "$vip" "adecenthost.com"
  [ "$status" -eq 1 ]
  run block_host "c" "$vip" "adecenthost.com"
  [ "$status" -eq 1 ]
  run block_host "ca" "$vip" "adecenthost.com"
  [ "$status" -eq 1 ]
}

@test "Block: Should give an IP to block with" {
  run block_host "$vcategory"
  [ "$status" -eq 1 ]
  run block_host "$vcategory" "notagoodip"
  [ "$status" -eq 1 ]
  run block_host "$vcategory" 127.0.0.
  [ "$status" -eq 1 ]
}

@test "Block: Is not alowed to give a short address" {
  run block_host "$vcategory" "$vip" "hjn"
  [ "$status" -eq 1 ]
  run block_host "$vcategory" "$vip" ""
  [ "$status" -eq 1 ]
  run block_host "$vcategory" "$vip" "3321"
  [ "$status" -eq 1 ]
  run block_host "$vcategory" "$vip" "abcde"
  [ "$status" -eq 0 ]
}


@test "Block: Doesn't accept invalid urls" {
  run block_host "$vcategory" "$vip" "www@test.nl"
  [ "$status" -eq 1 ]
  run block_host "$vcatory" "$vip" "test.n"
  [ "$status" -eq 1 ]
  run block_host "$vcatory" "$vip" "hello"
  [ "$status" -eq 1 ]
}



