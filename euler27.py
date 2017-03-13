#!/usr/bin/env python2

# from prime import is_prime
import prime
    

def quad_num(n, a, b):
    return n**2 + a*n + b
    
    
def num_primes(a, b, debug=False):
    n = 0
    if debug:
        print '(a,b) =', (a,b)
    while prime.prime.is_prime(quad_num(n,a,b)):
        if debug:
            print '\t', quad_num(n,a,b), ' is prime'
        n += 1
    return n
    # n = 0
    # num = 3
    # print 'num_primes for a =', a, ' and b =', b
    # while n < 50:
        # num = n**2 + a*n + b
        # print '\tn=', n, '->', num, ':', prime.prime.is_prime(num)
        # n += 1
    # n = 0
    # while not prime.prime.is_prime(n**2 + a*n + b):
        # n += 1
    # return n+1  
    # pass


def get_pos_odd(x):
    # from math import abs
    if x%2 == 0:
        x = x-1
    return abs(x)
    

def best_coeff(amax, bmax):
    amax = get_pos_odd(amax)
    bmax = get_pos_odd(bmax)
    max_len = 0
    best_tuple = (0,0)
    for a in xrange(-amax,amax,2):
        for b in xrange(-bmax,bmax,2):
            my_len = num_primes(a,b)
            if max_len < my_len:
                max_len = my_len
                best_tuple = (a,b)
    return best_tuple
 
    
def main():
    best_tuple = best_coeff(1000,1000)
    print best_tuple
    print best_tuple[0]*best_tuple[1]


if __name__ == '__main__':
    main()