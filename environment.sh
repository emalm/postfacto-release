env_dir="$(cd $(dirname "$BASH_SOURCE[0]") && pwd)"
source "$env_dir/credentials.sh"

export ENV_DIR="${env_dir}"

export APP_NAME=postfacto
export SESSION_TIME=3600
