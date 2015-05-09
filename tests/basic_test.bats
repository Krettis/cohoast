#!/usr/bin/env bats

@test "addition using bc" {
	result="$(echo 2+2 | bc)"
	[ "$result" -eq 4 ]
}

@test "shouting out an echo" {
	result=$(echo "this is a test")
	[ "$result" == "this is a test" ]
}
