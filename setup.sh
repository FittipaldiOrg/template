#!/bin/bash

# Default values
SERVICE_NAME=""

# Parse arguments
while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --service_name)
      SERVICE_NAME="$2"
      shift 2
      ;;
    *)
      echo "Unknown parameter: $1"
      exit 1
      ;;
  esac
done

# Check if service name was provided
if [[ -z "$SERVICE_NAME" ]]; then
  echo "Error: --service_name is required"
  exit 1
fi

# Replace {service_name} in README.md
if [[ -f "README.md" ]]; then
  sed -i "" "s/{service_name}/$SERVICE_NAME/g" README.md
  echo "README.md updated successfully."
else
  echo "Error: README.md not found"
  exit 1
fi
