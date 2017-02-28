#!/usr/bin/env python2


def get_decimals(den, num=1, base=10):
    """Returns the decimal part of the fraction 
    specified (default numerator is 1, denomiator must
    be given.) Returns a two-element tuple. The first 
    element is a list of the non-repeating decimals
    in the fraction given. The second element is a 
    list of the repeating part of the decimal.
    Either may be empty."""
    decimals = []
    remainders = []
    # test_count = 0
    while True:
        if num == 0:
            return (decimals, [])
        remainders.append(num)
        num *= base
        decimals.append(num/den)
        num = num % den
        if num in remainders:
            index = remainders.index(num)
            return (decimals[:index], decimals[index:])
        # test_count += 1
        # if test_count > 100:
            # break
    return "Error! Over 100 decimal places and still going."

def decimal_string(decimal_tuple):
    pre = '0.'
    nonrpt = ''.join([`i` for i in decimal_tuple[0]])
    if decimal_tuple[1]:
        rpt = '('+''.join([`i` for i in decimal_tuple[1]])+')'
    else:
        rpt = ''
    return pre + nonrpt + rpt

def max_repeating(max):
    d = -1
    length = 0
    for i in range(2,max):
        i_length = len(get_decimals(i)[1])
        if i_length > length:
            d = i
            length = i_length
    return (d, length)
    
    
def main():
    # pass
    print max_repeating(1000)
        
if __name__ == '__main__':
    main()