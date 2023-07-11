ERROR_COLOR='\033[1;31m'
SUCCESS_COLOR='\033[0;32m'
PROCESS_COLOR='\033[0;34m'
DEFAULT_COLOR='\033[0m'
RESET_LINE="\r\033[K"

ANIMATION_SPEED=0.5
GIT_INDEX_ERROR_MESSAGE="Git index is empty. There are no added files"

cleanup() {
  if [[ -n "$animation_pid" ]]; then
    kill "$animation_pid" >/dev/null 2>&1
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
      sleep ${ANIMATION_SPEED}
    done
    printf "${RESET_LINE}${PROCESS_COLOR}${message}${DEFAULT_COLOR}"
    sleep ${ANIMATION_SPEED}
    i=$((i+1))
  done
}

echo_message() {
  message="$1"
  status="$2"
  if [ "$status" = "error" ]; then
    printf "${RESET_LINE}${ERROR_COLOR}${message}${DEFAULT_COLOR}\n"
  else
    printf "${RESET_LINE}${SUCCESS_COLOR}${message}${DEFAULT_COLOR}\n"
  fi
}

check_git_index() {
  if [ -z "$(git diff --cached --name-only)" ]; then
    printf "${ERROR_COLOR}${GIT_INDEX_ERROR_MESSAGE}${DEFAULT_COLOR}\n"
    exit 1
  fi
}

run_command() {
  command="$1"
  process_message="$2"
  success_message="$3"
  failure_message="$4"

  echo_with_dots "${process_message}" &
  animation_pid=$!
  if output=$(eval "${command}" 2>&1); then
    if [[ -n "$animation_pid" ]]; then
      kill "$animation_pid"
    fi
    disown
    echo_message "${success_message}"
  else
    if [[ -n "$animation_pid" ]]; then
      kill "$animation_pid"
    fi
    disown
    echo "${output}\n"
    echo_message "${failure_message}" "error"
    exit 1
  fi
}

trap cleanup INT

check_git_index
run_command "yarn tsc" "Running build check" "Build passed" "Build failed"
run_command "yarn test" "Running tests" "Tests are passed" "Tests failed"
run_command "yarn lint-staged" "Running code linting and formatting" "Linting and formatting passed" "Linting and formatting failed"
