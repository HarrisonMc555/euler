#!/usr/bin/env python3

import math, operator, functools

def d(n):
   oldc = 1
   c = 10
   l = 1
   while n >= c:
      # print('n,l,c = {},{},{}'.format(n,l,c))
      l += 1
      oldc = c
      c += l*(10**l - 10**(l-1))
   b = l-1
   N = (n-oldc)//l + 10**b
   i = (n-oldc) % l
   sN = str(N)
   # print(n,c,oldc,l,N,i,sN)
   return int(sN[i])

# for i in range(1,14):
#    print('d({}) = {}'.format(i,d(i)))
# print('...')
# for i in range(180,200):
#    print('d({}) = {}'.format(i,d(i)))
# print('...')
# for i in range(2880,2900):
#    print('d({}) = {}'.format(i,d(i)))
# xs = [10**i for i in range(7)]
# l = [d(x) for x in xs]
# print(xs)
# print(l)
l = [d(10**i) for i in range(7)]
# print(l)
print(functools.reduce(operator.mul, l))
