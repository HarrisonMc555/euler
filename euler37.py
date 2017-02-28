#!/usr/bin/env python2


def get_digits(x, base=10):
    digits = []
    while x > 0:
        digits.append(x%base)
        x /= base
    return digits


def num_from_digits(digits, base=10):
    return sum([digit * base**index for index, digit in enumerate(digits)])
    num = 0
    for index, digit in enumerate(digits):
        num += digit * base**index
    return num
    
    
def create_nums_rec(current_digits, digit_options, length):
    result = []
    if current_digits:
        result.append(num_from_digits(current_digits))
    if length == 0:
        return result
    for digit in digit_options:
        result += create_nums_rec(current_digits + [digit], digit_options, length-1)
    return result
    

def create_nums(digit_options, length):
    return create_nums_rec([], digit_options, length)


def is_truncatable_prime(num):
    from prime.prime import is_prime
    digits = get_digits(num)
    for i in xrange(1,len(digits)):
        print '\tleft:', num_from_digits(digits[i:])
        if not is_prime(num_from_digits(digits[i:])):
            print '\t\t', num_from_digits(digits[i:]), 'isn\'t prime'
            return False
        if i != 0:
            print '\tright:', num_from_digits(digits[:i])
            if not is_prime(num_from_digits(digits[:i])):
                print '\t\t', num_from_digits(digits[:i]), 'isn\'t prime'
                return False
    return True
    
    
def find_truncatable_primes(length):
    # length = len(str(max))
    digit_options = [3,7,9]
    print 'create_nums ...',
    nums = create_nums(digit_options, length)
    print 'done.'
    print 'filter out ones that end with 9 ...',
    nums = filter(lambda x: get_digits(x)[0]!=9, nums)
    print 'done.'
    print 'reverse ...',
    nums.sort(reverse=True)
    print 'done.'
    # nums = filter(lambda x: x<max, nums)
    print 'filter out non-truncatable primes ...',
    return filter(is_truncatable_prime, nums)
    print 'done.'
    
    
def find_trunc_primes_rec(current_digits, digit_options):
    from prime.prime import is_prime
    num = num_from_digits(current_digits)
    result = []
    if not is_prime(num):
        print num, 'is not prime.'
        return result
    else:
        print num, 'is prime.'
    if is_truncatable_prime(num):
        print num, 'is truncatable prime.'
        result.append(num)
    else:
        print num, 'is not truncatable prime.'
    for digit in digit_options:
        import copy
        digs = copy.deepcopy(current_digits).insert(1,digit)
        result += find_trunc_primes_rec(digs, digit_options)
        # result += find_trunc_primes_rec(current_digits + [digit], digit_options)

        # print 'before1:', current_digits
        # current_digits.insert(1, digit)
        # print 'before2:', current_digits
        # result += find_trunc_primes_rec(current_digits, digit_options)
        # print 'after1:', current_digits
        # current_digits.pop(1)
        # print 'after2:', current_digits
    print result
    return result
    
    
def find_truncatable_primes2():
    first_options = [3,7]
    later_options = [1,3,7,9]
    result = []
    for first_digit1 in first_options:
        for first_digit2 in first_options:
            result += find_trunc_primes_rec([first_digit1, first_digit2], later_options)
    return result
    
    
def main():
    # from math import sin
    # nums = [sin(x) for x in range(10)]
    # print nums
    # nums.sort()
    # print nums
    # print sin(2)
    # index = binary_search(nums, sin(2))
    # print index
    # index2 = binary_search(nums, 2.0)
    # print index2
    # from prime.prime import is_prime
    # for i in xrange(50,0,-1):
        # print i, is_prime(i)
    # nums = find_truncatable_primes(8)
    # print nums
    # print sum(nums)
    # print 'Success :', len(nums) == 11
    print find_truncatable_primes2()

        
if __name__ == '__main__':
    main()