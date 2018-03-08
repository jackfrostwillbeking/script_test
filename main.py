import subprocess
import sys

res = subprocess.call(["/bin/bash","-c","./test_script.sh"])

sys.exit(0)
