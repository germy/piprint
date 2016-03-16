#~/usr/bin/env python
import sys
import os
import socket

# from: https://mail.python.org/pipermail/python-list/2000-August/054639.html
# Jeff Bauer

def lpstat(host, printer):
    s = socket.gethostbyname(host)
    fd = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    fd.bind('0.0.0.0')
    fd.connect(s)
    str = '\003%s\n' % printer
    fd.send(str, 0)
    return fd.recv(2048, 0)

def main():
    if len(sys.argv) < 3:
        sys.stderr.write("Not enough arguments!")
        print
    else:
        andrewid = sys.argv[0]
        path = sys.argv[1]
        printer = sys.argv[2]
        print "usage: %s host printer" % os.path.basename(path)
        print lpstat(path, printer)

main()
