#!/usr/bin/env python2

def factorial(n):
    result = 1
    while n > 1:
        result *= n
        n -= 1
    return result


def permutation(index, length):
    
    digits = range(length)
    result = []
    
    while length > 0:
        length -= 1
        width = factorial(length)
        pos = index/width
        index -= pos*width
        # print pos
        result.append(digits[pos])
        del digits[pos]
    
    return result + digits
    

def combine_digits(digits, base=10, reverse=False):
    result = 0
    if reverse:
        digits.reverse()
    for digit in digits:
        result *= base
        result += digit
    return result
    
    
def main():
    
    index = 10**6-1
    length = 10
    answer = permutation(index, length)
    print combine_digits(answer)
    

if __name__ == '__main__':
    main()