import sys
import os
from os import path

sys.path.append(path.abspath('./'))

commands = {
    "-all-s1": "robot -v device:s1 ./src/test",
    "-all-s2": "robot -v device:s2 ./src/test",
    "-all-s3": "robot -v device:s3 ./src/test",
    "-login": "robot -v device:s1 ./src/test/login.robot",
    "-web": "robot -v device:s1 ./src/test",
}

for param in sys.argv[1:]:
    if param in commands:
        command = commands[param]
    else :
        print(f"Parâmetro inválido ou inexistente: {param}")

os.system(command)