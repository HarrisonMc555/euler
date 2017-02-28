#!/usr/bin/env python2


def is_pandigits(digits):
    if len(digits) != 9:
        return False
    for i in range(1,10):
        if i not in digits:
            return False
    return True


def get_digits(x, base=10):
    digits = []
    while x > 0:
        digits.append(x%base)
        x /= base
    return digits

def is_pandigital_product(a, b):
    digits = get_digits(a)
    digits.extend(get_digits(b))
    digits.extend(get_digits(a*b))
    return is_pandigits(digits)
    
    
def get_pandigit_products():
    my_dict = {}
    products = []
    for a in range(10,100):
        for b in range(100,1000):
            if a*b not in products:
                if is_pandigital_product(a,b):
                    my_dict[(a,b)] = a*b
                    products.append(a*b)
    for a in range(1,10):
        for b in range(1000,10000):
            if a*b not in products:
                if is_pandigital_product(a,b):
                    my_dict[(a,b)] = a*b
                    products.append(a*b)
    return my_dict, products

    
def main():
    factors, products = get_pandigit_products()
    print factors
    print products
    print sum(products)
    
    
if __name__ == '__main__':
    main()