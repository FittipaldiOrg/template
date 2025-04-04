#!/bin/bash
set -e  # Stop script on error
set -x  # Print each command before executing

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
      echo "Unknown parameter: $1" | tee -a setup.log
      exit 1
      ;;
  esac
done

# Check if service name was provided
if [[ -z "$SERVICE_NAME" ]]; then
  echo "Error: --service_name is required" | tee -a setup.log
  exit 1
fi

# Check if README.md exists
if [[ ! -f "README.md" ]]; then
  echo "Error: README.md not found" | tee -a setup.log
  exit 1
fi

# Ensure write permission on README.md
if [[ ! -w "README.md" ]]; then
  echo "Error: No write permission for README.md" | tee -a setup.log
  exit 1
fi

# Replace {service_name} in README.md
if [[ "$OSTYPE" == "darwin"* ]]; then
  sed -i '' "s/{service_name}/$SERVICE_NAME/g" README.md  # macOS
else
  sed -i "s/{service_name}/$SERVICE_NAME/g" README.md    # Linux
fi

if [[ $? -eq 0 ]]; then
  echo "README.md updated successfully with service name: $SERVICE_NAME" | tee -a setup.log
else
  echo "Error: Failed to update README.md" | tee -a setup.log
  exit 1
fi
