#!/usr/bin/env python2
import time

def create_seive(max):
    seive = [0]*max
    for i in range(1,max):
        x = 2*i
        while x < max:
            seive[x] += i
            x += i
    return seive


def abundant_numbers(max):
    seive = create_seive(max)
    abundant = []
    for i, x in enumerate(seive):
        if i < x:
            abundant.append(i)
    return abundant

    
def abundant_sum_seive(max):
    abundant = abundant_numbers(max)
    seive = [False]*max
    for i, x in enumerate(abundant):
        for y in abundant[i:]:
            if x+y < max:
                seive[x+y] = True
    return seive

    
def non_abundant_sum(max):
    seive = abundant_sum_seive(max)
    total = 0
    for i, b in enumerate(seive):
        if not b:
            total += i
    return total
    

def main():
    seive = create_seive(25)
    for i, x in enumerate(seive):
        print i, ':', x
    import os
    os.system('pause')
    # print abundant_numbers(25)
    # print abundant_sum_seive(25)
    # print non_abundant_sum(24)
    # start = time.time()
    # print non_abundant_sum(28123)
    # print '{} seconds'.format(time.time() - start)
    
if __name__ == '__main__':
    main()