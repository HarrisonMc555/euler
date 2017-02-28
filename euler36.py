#!/usr/bin/env python2


def get_digits(x, base=10):
    digits = []
    while x > 0:
        digits.append(x%base)
        x /= base
    return digits


def num_from_digits(digits, base=10):
    num = 0
    for index, digit in enumerate(digits):
        num += digit * base**index
    return num
    

def is_palindrome(l):
    for index in xrange(len(l)/2):
        if l[index] != l[-1-index]:
            return False
    return True
    
    
def is_num_palindrome(x, base=10):
    return is_palindrome(get_digits(x, base))
    
    
def is_double_palindrome(x):
    if not is_num_palindrome(x, 10):
        return False
    return is_num_palindrome(x, 2)
    
    
def find_double_palindromes(max):
    result = []
    temp = 1
    for x in xrange(max):
        if is_double_palindrome(x):
            result.append(x)
        if x == temp:
            print temp
            temp *= 10
    return result


def create_bin_palin_rec(digits, length, max=10):
    # print 'length = {}, digits = {}'.format(length, digits)
    result = [num_from_digits(digits,2)]
    if length <= 0:
        return result
    digits.insert(len(digits)/2, 0)
    # print 'length = {}, digits = {}'.format(length, digits)
    result.append(num_from_digits(digits, 2))
    digits.pop(len(digits)/2)
    digits.insert(len(digits)/2, 1)
    # print 'length = {}, digits = {}'.format(length, digits)
    result.append(num_from_digits(digits, 2))
    digits.pop(len(digits)/2)
    if length == 1:
        return result
    digits.insert(1,0)
    digits.insert(-1,0)
    # print '\tlength = {}, digits = {}'.format(length, digits)
    result += create_bin_palin_rec(digits, length-2, max)
    digits.pop(1)
    digits.pop(-2)
    # print '\tlength = {}, digits = {}'.format(length, digits)
    digits.insert(1,1)
    digits.insert(-1,1)
    # print '\tlength = {}, digits = {}'.format(length, digits)
    result += create_bin_palin_rec(digits, length-2, max)
    # print '\tlength = {}, digits = {}'.format(length, digits)
    digits.pop(1)
    digits.pop(-2)
    # print '\tlength = {}, digits = {}'.format(length, digits)
    # print 'length = {}, result = {}'.format(length, [bin(x) for x in result])
    return result


def create_binary_palindromes(max):
    bin_pals = [1] + create_bin_palin_rec([1,1], len(get_digits(max,2)))
    # print 'create_binary_palindromes bin_pals =', [bin(x) for x in bin_pals]
    # print 'create_binary_palindromes bin_pals =', bin_pals
    # print 'create_binary_palindromes max =', max
    result = filter(lambda x: x<max, bin_pals)
    # print 'create_binary_palindromes result =', [bin(x) for x in result]
    return result

    
def fast_find_double_palindromes(max):
    bin_pals = create_binary_palindromes(max)
    return filter(lambda x: is_num_palindrome(x, 10), bin_pals)
    
    
def main():
    # for x in [585, int('1001001001',2), 123, int('101',2)]:
        # print x, bin(x), is_double_palindrome(x)
    # print sum(find_double_palindromes(10**6))
    # print 10**6, bin(10**6)
    # print get_digits(10**6,2), len(get_digits(10**6,2))
    # bin_pals = create_binary_palindromes(32)
    # print 'bin_pals', bin_pals
    # print 'bin_pals', [bin(x) for x in bin_pals]
    # print [0] + [1,2]
    # result = []
    # result += [1,2] + [3]
    # print result
    # print [bin(x) for x in result]
    # result = [1,1]
    # print result
    # result.insert(1,2)
    # print result
    # result.insert(-1,'*')
    # print result
    doubles = fast_find_double_palindromes(10**6)
    # print doubles
    # print [bin(x) for x in doubles]
    success = True
    for x in doubles:
        success |= False
    print 'Success =', success
    print 'Sum of all double palindromes:', sum(doubles)
    # print '1 in doubles :', 1 in doubles
    
if __name__ == '__main__':
    main()