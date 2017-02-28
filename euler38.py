#!/usr/bin/env python3


def is_pandigital(n):
   # this is ok even if n is already a string
   nstr = str(n)
   return all([str(i) in nstr for i in range(1,10)])

assert is_pandigital(123456789)
assert is_pandigital("123456789")
assert is_pandigital(987654321)
assert is_pandigital("987654321")
assert not is_pandigital(12345678)

i = 9999
for i in range(9999,5000,-1):
   # print(i)
   istr = str(i)+str(i*2)
   if is_pandigital(istr):
      print(istr)
      exit()
else:
   print('No four digit pandigital concatenated product.')
