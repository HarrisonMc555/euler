#!/usr/bin/env python2


def solve1(amax, bmax):
    s = set()
    for a in xrange(2, amax):
        for b in xrange(2, bmax):
            s.add(a**b)
    return len(s)


def solve2(amax, bmax):
    d = {}
    for a in xrange(2, amax):
        for b in xrange(2, bmax):
            d[a**b] = True
    return len(d)

    
def solve3(amax, bmax):
    l = []
    for a in xrange(2, amax):
        for b in xrange(2, bmax):
            p = a**b
            if p not in l:
                l.append(p)
    return len(l)
    
    
def main():
    import time
    max = 301
    t0 = time.time()
    a2 = solve2(max,max)
    t1 = time.time()
    a1 = solve1(max,max)
    t2 = time.time()
    # a3 = solve3(max,max)
    a3 = None
    t3 = time.time()
    for a, t in [(a1,t2-t1),(a2,t1-t0),(a3,t3-t2)]:
        print '{}, took {} seconds'.format(a,t)
    
    
if __name__ == '__main__':
    main()