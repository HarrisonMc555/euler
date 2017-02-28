#!/usr/bin/env python3

import math

# p = 120
# l = []
# for a in range(10,p+1):
#    for b in range(1,a+1):
#       csquared = a**2 + b**2
#       c = math.sqrt(csquared)
#       if c % 1 != 0:
#          continue
#       c = int(c)
#       xs = (b,a,c)
#       s = sum(xs)
#       if s == p:
#          l.append(xs)
# print(sorted(l))

d = {}
p = 1000
for b in range(1,p+1):
   for a in range(1,b+1):
      cf = math.sqrt(a**2 + b**2)
      c = int(cf)
      if c != cf:
         continue
      s = a + b + c
      if s > p:
         continue
      if s in d:
         d[s] += 1
      else:
         d[s] = 1
print(max(d, key=lambda x: d[x]))
