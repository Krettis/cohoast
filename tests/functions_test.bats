#!/usr/bin/env bats
setup(){
	source .dot/.functions
}

@test "Load the language" {
	skip "Skipping, currently only defining tests"
}

@test "Load the user configuration" {
	skip "Skipping, currently only defining tests"
}

@test "Check on existance of function-name" {
	run chfn_exists "in_array"
	[ "$status" -eq 0 ]

	run chfn_exists "a non existant function"
	[ "$status" -eq 1 ]
}

@test "Check if a value in a array exists" {
	skip "Skipping, currently only defining tests"
}

@test "Parsing the yaml file" {
	skip "Skipping, currently only defining tests"
}

@test "All usages can being loaded" {
	skip "Skipping, currently only defining tests"
}

@test "Gives back a format for prompt" {
	skip "Skipping, currently only defining tests"
}

@test "Return an error message" {
  run error_message "This is dog"
  [ "$output" = "This is dog" ]

  run error_message
  [ "$output" = '' ]
}
