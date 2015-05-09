#!/usr/bin/env bats

@test "shouting out an echo" {
	result=$(echo "this is a test")
	[ "$result" == "this is a test" ]
}
