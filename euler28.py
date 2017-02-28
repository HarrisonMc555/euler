#!/usr/bin/env python2


def fun(x):
    return 4*(x**2) - (10*x) + 7


def get_seq(length):
    seq = []
    for x in range(2,length+2):
        seq.append(fun(x))
    return seq
    
    
def get_diag_sum(width):
    length = (width-1)/2
    total = 1 # Include the 1 in the middle
    for i, x in enumerate(get_seq(length)):
        # total += 4*x + 3!*2*i
        total += 4*x + 12*(i+1)
    return total
    
def main():
    print get_seq(5)
    print get_diag_sum(1001)
    
    
if __name__ == '__main__':
    main()