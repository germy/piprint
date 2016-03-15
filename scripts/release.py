#~/usr/bin/env python
import sys
import os
import socket

if len(sys.argv) < 3:
  sys.stderror.write("Not enough arguments!")
else:
  id = sys.argv[0]
  path = sys.argv[1]
  printer = sys.argv[2]
