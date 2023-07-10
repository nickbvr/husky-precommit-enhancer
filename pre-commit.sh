ERROR_COLOR='\033[1;31m'
SUCCESS_COLOR='\033[0;32m'
PROCESS_COLOR='\033[0;34m'
DEFAULT_COLOR='\033[0m'

cleanup() {
  if [[ -n "$animation_pid" ]]; then
    kill "$animation_pid"
  fi
  echo ""
  exit 0
}

echo_with_dots() {
  message="$1"
  max_dots=3

  printf "${PROCESS_COLOR}${message}${DEFAULT_COLOR}"
  i=0
  while true; do
    for ((j=0; j<max_dots; j++)); do
      printf "${PROCESS_COLOR}.${DEFAULT_COLOR}"
      sleep 0.5
    done
    printf "\r\033[K${PROCESS_COLOR}${message}${DEFAULT_COLOR}"
    sleep 0.5
    i=$((i+1))
  done
}

echo_message() {
  message="$1"
  status="$2"
  if [ "$status" = "error" ]; then
    printf "\r\033[K${ERROR_COLOR}${message}${DEFAULT_COLOR}\n"
  else
    printf "\r\033[K${SUCCESS_COLOR}${message} passed${DEFAULT_COLOR}\n"
  fi
}

check_git_index() {
  if [ -z "$(git diff --cached --name-only)" ]; then
    echo "${ERROR_COLOR}Error: Git index is empty. There are no added files${DEFAULT_COLOR}"
    exit 1
  fi
}

run_command() {
  message="$1"
  command="$2 > /dev/null"
  failure_message_text="$3"

  echo_with_dots "${message}" &
  animation_pid=$!
  if eval "${command}"; then
    if [[ -n "$animation_pid" ]]; then
     kill "$animation_pid"
    fi
    disown
    echo_message "${message}"
  else
    if [[ -n "$animation_pid" ]]; then
     kill "$animation_pid"
    fi
    disown
    echo_message "${failure_message_text}" "error"
    exit 1
  fi
}

trap cleanup INT

check_git_index
run_command "Running build check" "yarn tsc" "Build failed"
run_command "Running tests" "yarn test" "Tests failed"
run_command "Running code formatting" "yarn prettier . --write" "Formatting failed"
run_command "Running code linting" "yarn eslint . --fix" "Linting failed"