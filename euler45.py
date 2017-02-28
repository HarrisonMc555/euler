#!/usr/bin/env python3

def triangle(n):
   return int(n*(n+1)/2)

def pentagon(n):
   return int(n*(3*n-1)/2)

def hexagon(n):
   return int(n*(2*n-1))

for n in range(1,100):
   # print('n: {}'.format(n))
   assert(triangle(n) == sum([i+1 for i in range(n)]))
   assert(triangle(n) == sum([i for i in range(1,n+1)]))

for n in range(1,100):
   # print('n: {} => {}'.format(n,sum([3*i for i in range(n+1)])))
   # print('n: {} => {}'.format(n,sum([3*i+1 for i in range(n)])))
   # print('n: {} => {}'.format(n,sum([3*i-2 for i in range(1,n+1)])))
   assert(pentagon(n) == sum([3*i+1 for i in range(n)]))
   assert(pentagon(n) == sum([3*i-2 for i in range(1,n+1)]))

for n in range(1,100):
   # print('n: {} => {}'.format(n,sum([4*i-3 for i in range(1,n+1)])))
   assert(hexagon(n) == sum([4*i+1 for i in range(n)]))
   assert(hexagon(n) == sum([4*i-3 for i in range(1,n+1)]))
   nt = 2*n-1
   assert(hexagon(n) == triangle(nt))
   # print('hn: {0}, tn: {1}, hex({0}): {2}, tri({1}): {3}'.
   #       format(n,nt,hexagon(n), triangle(nt)))
   # assert((nt+2)*(nt-1) == (3*n+2)*(n-1))
                                                                 

# exit()

def next_triangle(tn, ti):
   return tn + ti + 1, ti+1

def next_pentagon(pn, pi):
   return pn + 3*pi + 1, pi+1

def next_hexagon(hn, hi):
   return hn + 4*hi + 1, hi+1

# tn,ti,pn,pi,hn,hi = [1]*6
# for ti in range(1,10):
#    print('T_{} = {}'.format(ti,tn))
#    tn, ti = next_triangle(tn, ti)
# print()

# for pi in range(1,10):
#    print('P_{} = {}'.format(pi,pn))
#    pn, pi = next_pentagon(pn, pi)
# print()

# for hi in range(1,10):
#    print('H_{} = {}'.format(hi,hn))
#    hn, hi = next_hexagon(hn, hi)
# print()

# tn,ti,pn,pi,hn,hi = [1]*6
ti,pi,hi = 285,165,143
tn,pn,hn = [40755]*3

pn, pi = next_pentagon(pn, pi)
while True:
   # print('T_{}={}, P_{}={}, H_{}={}'.format(ti,tn,pi,pn,hi,hn))
   if pn < hn:
      pn, pi = next_pentagon(pn, pi)
      continue
   if hn < pn:
      hn, hi = next_hexagon(hn, hi)
      continue
   ti = 2*hi - 1
   tn = triangle(ti)
   # print('T_{}={}, P_{}={}, H_{}={}'.format(ti,tn,pi,pn,hi,hn))
   assert(tn == pn == hn)
   print(tn)
   exit()
   
