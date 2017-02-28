#!/usr/bin/env python2


def get_digits(num, base=10):
    digits = []
    while num > 0:
        digits.append(num%base)
        num /= base
    return digits


def dig_pow_sum(num, pow=5, base=10):
    digits = get_digits(num, base)
    return sum([digit**pow for digit in digits])


def is_dig_pow_sum(num, pow=5, base=10):
    return num == dig_pow_sum(num, pow, base)
    

def test_dig_pow_sum():
    failure = False
    for correct in [1634, 8208, 9474]:
        if not is_dig_pow_sum(correct, pow=4):
            Failure = True
            print 'Error on', correct
    for incorrect in [1343, 2342, 1243]:
        if is_dig_pow_sum(incorrect, pow=4):
            Failure = True
            print 'Error on', incorrect
    if not failure:
        print 'Success'


def get_dig_pow_limit(pow=5):
    l = 2
    while int('9'*l) < 9**pow*l:
        l += 1
    return l
    
    
def find_dig_sums(pow=5):
    nums = []
    for i in xrange(int('9'*get_dig_pow_limit(pow))):
        if is_dig_pow_sum(i,pow=pow):
            nums.append(i)
    return nums


def find_dig_sums_sum(pow=5):
    nums = find_dig_sums(pow)
    my_sum = 0
    for num in nums:
        if len(str(num)) == 1:
            pass
        else:
            my_sum += num
    return my_sum
    

def main():
    print find_dig_sums_sum(5)
    # pass
    
    
    
if __name__ == '__main__':
    main()