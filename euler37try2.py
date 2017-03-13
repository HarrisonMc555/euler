#!/usr/bin/env python2
"""euler37try2.py"""

import time

def enumerate_rev(l):
    for i in reversed(xrange(len(l))):
        yield i, l[i]

def erat_primes(max_n,primes=None):
    sieve = [False]*max_n
    if primes:
        start = primes[-1]
    else:
        primes = []
        start = 2
    for i in xrange(start,max_n):
        if not sieve[i]:
            primes.append(i)
        multiple = 2*i
        while multiple < max_n:
            sieve[multiple] = True
            multiple += i
    return primes

def create_primes(max_n):
    return set(erat_primes(max_n))

prime_max = 25
prime_set = create_primes(prime_max)
    
def init_primes():
    global prime_max, prime_set
    prime_max = 100000
    prime_set = create_primes(prime_max)
    print 'Num of primes:', len(prime_set)
    print 'Max prime    :', prime_max

def single_is_prime(n):
    global prime_max, prime_set
    for prime in prime_set:
        if n % prime == 0:
            return False
    import math
    for i in xrange(prime_max,int(math.ceil(math.sqrt(n)))):
        if n % i == 0:
            return False
    return True

def is_prime(n):
    global prime_max, prime_set
    if n < prime_max:
        return n in prime_set
    else:
        return single_is_prime(n)

def num2dig(n):
    return list(str(n))
    
def dig2num(d):
    return sum(int(v) * 10**i for i,v in enumerate(reversed((d))))
    
def sub_lists(l,smallfirst=True):
    if smallfirst:
        g = xrange(1,len(l))
    else:
        yield l
        g = reversed(xrange(1,len(l)))
    for i in g:
        yield l[:i]
        yield l[-i:]
    if smallfirst: yield l
    
def is_trun_prime(n):
    for sub in sub_lists(num2dig(n)):
        if not is_prime(dig2num(sub)):
            return False
    else:
        return True

def list_add_rec(l,n,choices):
    # print 'n', n, 'l', l, 'choices', choices
    if n <= 0:
        yield l
    else:
        for choice in choices:
            # l.append(choice)
            l.insert(1,choice)
            # yield from list_add_rec(l,n-1,choices)
            for i in list_add_rec(l,n-1,choices):
                yield i
            #l.pop()
            l.pop(1)
            
def trun_prime_gen(length):
    begs = [2,3,5,7]
    mids = [1,3,7,9]
    ends = [3,7]
    for first in begs:
        for last in ends:
            # yield from list_add_rec([first,last],length-2,mids)
            for trun_try in list_add_rec([first,last],length-2,mids):
                yield dig2num(trun_try)
    # for first in begs:
        ##x yield from list_add_rec([first,last],length-2,mids)
        # for trun_try in list_add_rec([first],length-1,mids):
            # yield dig2num(trun_try)

def find_trun_primes():
    # s = time.time()
    trun_primes, cur_len = [], 2
    max_l = 11
    while len(trun_primes) < max_l:
        for trun_try in trun_prime_gen(cur_len):
            if is_trun_prime(trun_try):
                trun_primes.append(trun_try)
                if len(trun_primes) >= max_l:
                    break
        cur_len += 1
    return trun_primes
                
def main():
    # for l in list_add_rec(['begin','end'],3,['a','b']):
        # print l
    # return
    # test = range(25)+[37,1299827,1299827+1]
    # for num in test:
        # print num, is_prime(num)
    # t = [33,37,3397,3797]
    # for num in t:
        # print num, is_trun_prime(num)
    # for s in sub_lists(num2dig(3797)):
        # print dig2num(s)
    # for trun_try in trun_prime_gen(4):
        # print trun_try, is_trun_prime(trun_try)
    start = time.time()
    init_primes()
    trun_primes = find_trun_primes()
    print trun_primes
    print 'sum =', sum(trun_primes)
    print 'time =', time.time()-start
        
if __name__ == '__main__':
    main()