#~/usr/bin/env python
import sys
import os
import socket

# from: https://mail.python.org/pipermail/python-list/2000-August/054639.html
# Jeff Bauer

def connectToPrint(host, printer):
    s = socket.gethostbyname(host) # cmu socket
    own = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    jer = "73.154.246.138"
    jer2 = "192.168.1.113"
    own.bind((jer2, 24)) # Jeremy's IP
    own.connect(s) # connect IP to cmu print

    return (s, own) 

def main():
    if len(sys.argv) < 1: # change back to 3 when queue is added
        sys.stderr.write("Not enough arguments!")
        print
    else:
        sendToPharos(sys.argv)

def sendToPharos(params):
    #assert(len(params) >= 3)
    andrewid = params[1]
    path = params[2]
    path = os.path.join(os.path.expanduser("~"), "piprint/scripts/testpage.docx")
    printer = "andrew" # change back to cmd line arg
    host = andrewid + "@printing.andrew.cmu.edu/ChosenQueue/" + printer

    print "Andrew ID: ", andrewid
    print "Path: ", path
    print host
    f = open(path, "wb")
    host = "printing.andrew.cmu.edu"
    (cmu, own) = connectToPrint(host, printer)
    cmu.send(f)
    f.close()
        
main()
