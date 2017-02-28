#!/usr/bin/env python2


def get_rotations(x, base=10):
    rotations = []
    l = len(str(x))
    for i in range(l):
        rotations.append(x)
        temp = x%base
        x /= base
        x += temp * base**(l-1)
    return rotations
        

def num_from_digits(digits, base=10):
    num = 0
    for index, digit in enumerate(digits):
        num += digit * base**index
    return num
    

def is_circular_prime(x):
    from prime import prime
    rots = get_rotations(x)
    for rot in rots:
        if not prime.is_prime(rot):
            return False
    return True

    
def create_nums_rec(current_digits, digit_options, length, base=10):
    # Only want 2 or more digit numbers
    nums = []
    if len(current_digits) >= 2:
        nums.extend([num_from_digits(current_digits)])
    if length == 0:
        return nums
        # return [num_from_digits(current_digits)]
    for digit in digit_options:
        current_digits.append(digit)
        nums.extend(create_nums_rec(current_digits, digit_options, length-1, base))
        current_digits.pop()
    return nums

    
def create_nums(digits, max_length, base=10):
    # nums = []
    # digits = [1,3,7,9]
    # for i in xrange(length):
        # nums.extend(create_nums_rec([], digits, length, base))
    # return nums
    return create_nums_rec([], digits, max_length, base)
    
    
def get_circular_primes():
    circs = []
    for i in xrange(2,10):
        if is_circular_prime(i):
            circs.append(i)
    # Circular primes with two or more digits can only contain the 
    # digits 1,3,7,9 because those are the only digits that a number 
    # can end with and still be prime.
    # To get all the numbers composed of these digits below a million 
    # We'll set the max length of the digits to be 6
    nums = create_nums([1,3,7,9], 6)
    for num in nums:
        if num not in circs:
            if is_circular_prime(num):
                circs.append(num)
    return circs
    
def main():
    # from prime import prime
    # for circ in [2,3,5,7,11,13,37,79,75,23]:
        # print circ, prime.is_prime(circ), is_circular_prime(circ)
    # print sorted(create_nums([1,2], 3))
    # print filter(lambda x: x%2==0, range(20))
    from prime import prime
    from time import time
    start = time()
    prime.get_primes(10**6)
    circs = get_circular_primes()
    end = time()
    print len(circs)
    print 'Took {} seconds'.format(end-start)
    
    
if __name__ == '__main__':
    main()