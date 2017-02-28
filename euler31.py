#!/usr/bin/env python2
seq = []
level = 0

def rec_combo(values, target, debug=False):
    if debug:
        global seq
        global level
        print '\nlevel:', level
        level += 1
        print values, 'target =', target
        print 'seq =', seq
    if target == 0:
        if debug: level -= 1
        if debug: print '\tReturning 1'
        return 1
    elif not values:
        if debug: level -= 1
        if debug: print '\tReturning 0 (Empty list)'
        return 0
    combos = 0
    # for index, value in enumerate(values):
        # if debug: print 'index:', index, ' value:', value
        # n = 0
        # while n*value <= target:
            # if debug: print 'Adding', [value]*n
            # seq += [value]*n
            # combos += rec_combo(values[index+1:], target-n*value, debug)
            # if debug:
                # for _ in xrange(n):
                    # seq.pop()
            # n += 1
    n = 0
    value = values[0]
    while n*value <= target:
        if debug:
            print 'Adding', [value]*n
            seq += [value]*n
        combos += rec_combo(values[1:], target-n*value, debug)
        if debug:
            for _ in xrange(n):
                seq.pop()
        n += 1
    if debug: level -= 1
    return combos


def combos(values, target):
    values.sort(reverse=True)
    return rec_combo(values, target, False)
    
    


def main():
    values = [5,1]
    num_combos = combos(values, 10)
    print 'Values:', values
    print 'Combos:', num_combos
    values = [1,2,5,10]
    num_combos = combos(values, 20)
    print 'Values:', values
    print 'Combos:', num_combos
    
    import time
    values = [1,2,5,10,20,50,100,200]
    start_time = time.time()
    num_combos = combos(values, 200)
    end_time = time.time()
    print 'Values:', values
    print 'Combos:', num_combos
    print 'Time for last one:', end_time-start_time
    
if __name__ == '__main__':
    main()