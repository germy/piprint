import sys

def write():
    print('Creating new text file') 

    name = 'test.txt'  # Name of text file coerced with +.txt

    try:
        file = open(name,'a')   # Trying to create a new file or open one
        file.close()

    except:
        print('Something went wrong! Can\'t tell what?')
        sys.exit(0) # quit Python

write()