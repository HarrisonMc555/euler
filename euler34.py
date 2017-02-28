#!/usr/bin/env python2


def get_digits(x, base=10):
    digits = []
    while x > 0:
        digits.append(x%base)
        x /= base
    return digits

    
digit_factorials = [1]
for i in range(1,10):
    digit_factorials.append(i*digit_factorials[i-1])

    
def factorial(x):
    if x < 10:
        global digit_factorials
        return digit_factorials[x]
    result = 1
    for i in xrange(1,x+1):
        result *= i
    return result


def is_curious(x):
    return x == sum([factorial(digit) for digit in get_digits(x)])
    
    
def find_curious_numbers():
    result = []
    for x in xrange(10,10**6):
        if is_curious(x):
            result.append(x)
    return result
    
    
def main():
    import time
    for x in xrange(10):
        print (x,factorial(x))
    for x in [145,9,100]:
        print x, is_curious(x)
    start = time.time()
    result = find_curious_numbers()
    stop = time.time()
    print result
    print sum(result)
    print 'Took: {} seconds'.format(stop-start)
        
if __name__ == '__main__':
    main()