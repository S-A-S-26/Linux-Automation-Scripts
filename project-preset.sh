
#!/bin/bash

CONFIG="$HOME/.project_presets"

# Load config
source "$CONFIG"

set_preset() {
  local idx=$1
  local path=$2
  sed -i "s|^PRESET$idx=.*|PRESET$idx=\"$path\"|" "$CONFIG"
  echo "Preset $idx set to $path"
}

run_preset() {
  local idx=$1
  local var="PRESET$idx"
  local path="${!var}"

  if [ -z "$path" ]; then
    echo "Preset $idx is not set!"
    exit 1
  fi

  echo "Opening terminals for preset $idx at: $path"

  # Terminal 1 - dev server
  gnome-terminal -- bash -c "cd \"$path\" && npm run dev; exec bash"

  # Terminal 2 - editor
  gnome-terminal -- bash -c "cd \"$path\" && nvim .; exec bash"

  # Terminal 3 - free shell
  gnome-terminal -- bash -c "cd \"$path\"; exec bash"
}

case "$1" in
  set)
    set_preset "$2" "$3"
    ;;
  run)
    run_preset "$2"
    ;;
  *)
    echo "Usage:"
    echo "  $0 set <1|2|3> <path>   # Set a preset path"
    echo "  $0 run <1|2|3>          # Run a preset"
    ;;
esac


# project-preset.sh set 1 ~/dev/my-app
# project-preset.sh run 1
