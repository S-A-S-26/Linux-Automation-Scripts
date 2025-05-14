
#!/bin/bash

KEY_FILE="$HOME/gitKeys"
KEY_NAME="$1"  # passed as the first argument

if [[ ! -f "$KEY_FILE" ]]; then
    echo "Key file not found: $KEY_FILE" >&2
    exit 1
fi

# Load the key from the file using grep
KEY_VALUE=$(grep "^$KEY_NAME=" "$KEY_FILE" | cut -d'=' -f2-)

if [[ -z "$KEY_VALUE" ]]; then
    echo "Key '$KEY_NAME' not found." >&2
    exit 1
fi

echo -n "$KEY_VALUE" | xclip -selection clipboard
echo "Copied $KEY_NAME to clipboard."
