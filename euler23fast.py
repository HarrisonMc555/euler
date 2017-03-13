#!/usr/bin/env python2
import math


def seive(max):
    lim = int(math.sqrt(max))
    sums = [0]*max
    # sums = [[]]*max
    # print sums
    for i in xrange(2,lim):
        # print 'i:', i
        for k in xrange(i, max/i):
            # print '\tk:', k, 'i*k:', i*k
            # sums[i*k].append(i*k)
            sums[i*k] += i*k
        # sums[i*i] -= i
    return sums
    
    
def foo(max):
    lim = int(math.sqrt(max))
    sums = [0]*max
    for i in xrange(2, lim):
        
    
def main():
    for i, x in enumerate(seive(25)):
        print i, ':', x
    import os
    os.system('pause')

    
if __name__ == '__main__':
    main()