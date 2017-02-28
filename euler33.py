#!/usr/bin/env python2


def get_digits(x, base=10):
    digits = []
    while x > 0:
        digits.append(x%base)
        x /= base
    return digits

    
def get_num_from_digits(digits, base=10):
    num = 0
    for index, digit in enumerate(digits):
        num += digit * base**index
    return num
    
    
def digits_cancel(adigits, bdigits):
    pass
    
    
def product(nums):
    prod = 1
    for num in nums:
        prod *= num
    return prod
    
    
def get_factors(x):
    from math import sqrt
    factors = []
    for i in xrange(2, int(sqrt(x))+1):
        while x % i == 0 and x != 1:
            factors.append(i)
            x /= i
            # print '\t', x, factors
    if x != 1:
        factors.append(x)
    return factors

    
def simplify_fraction(num, dem):
    num_factors = get_factors(num)
    dem_factors = get_factors(dem)
    common = []
    for factor in num_factors:
        if factor in dem_factors:
            common.append(factor)
            dem_factors.remove(factor)
    for factor in common:
        num_factors.remove(factor)
    return (product(num_factors), product(dem_factors))

    
def is_curious_fraction(num, dem):
    from copy import deepcopy
    num_digits = get_digits(num)
    dem_digits = get_digits(dem)
    answer = simplify_fraction(num, dem)
    for num_digit in num_digits:
        if num_digit in dem_digits:
            num_copy = deepcopy(num_digits)
            dem_copy = deepcopy(dem_digits)
            num_copy.remove(num_digit)
            dem_copy.remove(num_digit)
            if simplify_fraction(get_num_from_digits(num_copy), \
                get_num_from_digits(dem_copy)) == \
                answer:
                return True
    return False


def is_trivial(num, dem, base=10):
    return num % base == 0 and dem % base == 0
    

def find_curious_fractions():
    fractions = []
    for num in range(10,100):
        for dem in range(num+1,100):
            if is_curious_fraction(num, dem):
                if not is_trivial(num, dem):
                    fractions.append((num,dem))
    return fractions        
            
def main():
    # for i in xrange(13):
        # print i, ':', get_factors(i)
    # for num in range(2,10):
        # for dem in [10,12,13,15,16]:
            # print num, '/', dem, ':', simplify_fraction(num, dem)
    # x = 1
    # while x < 10**4:
        # digits = get_digits(x)
        # print x, digits, get_num_from_digits(digits)
        # x *= 2
    # for tuple in [(49,98),(30,50),(44,55)]:
        # print tuple, is_curious_fraction(tuple[0],tuple[1])
    fractions = find_curious_fractions()
    nums = []
    dems = []
    for fraction in fractions:
        nums.append(fraction[0])
        dems.append(fraction[1])
        print fraction
    print nums
    print dems
    num = product(nums)
    dem = product(dems)
    answer = simplify_fraction(num, dem)
    print answer
    
    
    
if __name__ == '__main__':
    main()