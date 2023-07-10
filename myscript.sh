#!/bin/bash

echo "Hello, World!"

# Проверка наличия файла
if [ -f myfile.txt ]; then
  echo "File myfile.txt exists."
else
  echo "File myfile.txt does not exist."
fi
