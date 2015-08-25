#!/usr/bin/env bats
setup(){
  source .dot/.functions
}

@test "Load the language" {
  DEFAULT_LANG='en'
  run load_language
  [ "$status" -eq 0 ]
  DEFAULT_LANG='nl'
  run load_language
  [ "$status" -eq 0 ]
  DEFAULT_LANG='nolanguage'
  run load_language
  [ "$status" -eq 1 ]
}

@test "Load the user configuration" {
  run load_user_config
  echo $output
  [ "$status" -eq 0 ]
  [[ ! "$output" =~ "No such file or directory".* ]]
}

@test "Check on existance of function-name" {
  run chfn_exists "in_array"
  [ "$status" -eq 0 ]

  run chfn_exists "a non existant function"
  [ "$status" -eq 1 ]
}

@test "Check if a value in a array exists" {
  local standard=(one two three this four six seven)
  run in_array "${standard[@]}" "this"
  [ "$status" -eq 0 ]
  run in_array "${standard[@]}" "not found"
  [ "$status" -eq 1 ]
}

@test "Return an error message" {
  run error_message "This is dog"
  [ "$output" = "This is dog" ]

  run error_message
  [ "$output" = '' ]
}
