#!/usr/bin/env python3

# This relies heavily on divisibility rules. Details can be found at:
# https://en.wikipedia.org/wiki/Divisibility_rule

# The numbers x, y, and z are obtained later in the program by performing a mod
# operation. These tables index into the possible digit values that could be
# obtaiend when dividing by the given number (2, 4, and 5 respectively) and then
# performing the mod operation. Thus, these tables will tell you which possible
# values for that digit you need to check. Only the x values have collisions,
# which is why it is a list of sets, while everything else is just a list of
# numbers.

# For example, the "x" value is obtained by doing the sum of d5d6, or
# 10*d5+d6. We do this because the dvisibility rule for 7 is to subtract twice
# the last digit from the rest and see if it's a multiple of 7. Thus, we first
# compute the "rest", i.e. 10*d5+d6. This value minus 2*d7 should be equal to 0
# mod 7. For a given value of x=10*d5+d6, what values of d7 will make this true?
# If x = 0, then obviously 0 works--but so would 7 (x == 0 mod 7 == -14 mod
# 7). What if x = 1? Then d7 = 8 works, because 1 - 8*2 == 1 - 16 = -15 mod 7 ==
# 1 mod 7. For an arbitrary divisor d and number n to mod by, we can find these
# numbers by finding the multiples of the divisor from 0 to 9*divisor and
# placing each result in a bin mod n. We then make a map (or, in this case, an
# array) from each possible mod result (here known as x, y, or z) to its
# corresponding digit value [0-9]. This may have collisions (such as in the case
# of x) or may have empty spots (such as in the cases of y and z). If there are
# collisions, this means there is more than one digit that will satisfy the
# requirement, and if there are empty spots it means there are no digits that
# satisfy the requirement.

# d5d6d7 is divisible by 7, therefore d5d6 - 2*d7 == 0 mod 7
xvals = [{0,7},{4},{1,8},{5},{2,9},{6},{3}]
assert len(xvals) == 7

# d7d8d9 is divisible by 13, therefore d7d8 + 4*d9 == 0 mod 13
yvals = [0,None,7,4,1,None,8,5,2,None,9,6,2]
assert len(yvals) == 13

# d8d9d10 is divisible by 17, therefore d8d9 - 4*d10 == 0 mod 17
zvals = [0,7,None,4,None,1,8,None,5,None,2,9,None,6,None,3,None]
assert len(zvals) == 17

# store the answers here to sum at the end
answers = []

# d2d3d4 is divisible by 2, i.e. d4 is a multiple of 2
for d4 in [0,2,4,6,8]:
   nums = {d4}
   # print('d4 =', d4)
   # print('xxx{}xxxxxx'.format(d4))

   # d4d5d6 is divisible by 5, i.e. d6 is 0 or 5
   for d6 in {0,5} - nums:
      nums.add(d6)
      # print('\td6 =', d6)
      # print('\txxx{}x{}xxxx'.format(d4,d6))

      # nail down what d5 is in order to know what d7 can be
      for d5 in set(range(10)) - nums:
         nums.add(d5)
         # print('\t\td5 =', d5)
         # print('\t\txxx{}{}{}xxxx'.format(d4,d5,d6))
         # print('\t\t{}'.format(nums))
         assert(len(nums) == 3)

         # d5d6d7 is divisible by 7, therefore d5d6 - 2*d7 == 0 mod 7
         x = (10*d5 + d6) % 7
         d7s = xvals[x] - nums
         for d7 in d7s:
            # if d7 in nums:
            #    nums -= {d5}
            #    continue
            # print('\t\t\td7 =', d7)
            # print('\t\t\txxx{}{}{}{}xxx'.format(d4,d5,d6,d7))
            nums.add(d7)

            # d6d7d8 is divisible by 11, therefore d6 + d7 - d8 == 0 mod 11
            d8 = (d7 - d6) % 11
            if d8 > 9 or d8 in nums:
               nums -= {d7}
               continue
            # print('\t\t\td8 =', d8)
            # print('\t\t\txxx{}{}{}{}{}xx'.format(d4,d5,d6,d7,d8))
            nums.add(d8)

            # d7d8d9 is divisible by 13, therefore d7d8 + 4*d9 == 0 mod 13
            y = (-10*d7 + -d8) % 13
            # for d9 in {y, y+
            # d9 = y//4
            d9 = yvals[y]
            if d9 is None or d9 in nums:
               nums -= {d7, d8}
               continue
            # print('\t\t\td9 =', d9)
            # print('\t\t\txxx{}{}{}{}{}{}x'.format(d4,d5,d6,d7,d8,d9))
            nums.add(d9)

            # d8d9d10 is divisible by 17, therefore d8d9 - 4*d10 == 0 mod 17
            z = (10*d8 + d9) % 17
            # d10 = z//5
            d10 = zvals[z]
            if d10 is None or d10 in nums:
               nums -= {d7, d8, d9}
               continue
            # print('\t\t\td10 =', d10)
            # print('\t\t\txxx{}{}{}{}{}{}{}'.format(d4,d5,d6,d7,d8,d9,d10))
            nums.add(d10)

            # print()
            # print('\t\t\there')
            # print('\t\t\t{}'.format(nums))

            # d3d4d5 is divisible by 3, therefore d3 + d4 + d5 == 0 mod 3
            for d3 in filter(lambda x: (x+d4+d5) % 3 == 0,
                             set(range(10)) - nums):
               nums.add(d3)
               # print('\t\t\t\txx{}{}{}{}{}{}{}{}'.format(
               #    d3,d4,d5,d6,d7,d8,d9,d10))
               # print('\t\t\t\t{}'.format(nums))
               assert(len(nums) == 8)
               # the last two digits have no requirements, but need to be the
               # last two digits we haven't used yet
               d1,d2 = set(range(10)) - nums
               a1 = int('{}{}{}{}{}{}{}{}{}{}'.format(
                  d1,d2,d3,d4,d5,d6,d7,d8,d9,d10))
               # use the other ordering
               d1,d2 = d2,d1
               a2 = int('{}{}{}{}{}{}{}{}{}{}'.format(
                  d1,d2,d3,d4,d5,d6,d7,d8,d9,d10))
               answers.extend([a1,a2])
               nums.remove(d3)

            nums -= {d7,d8,d9,d10}

         nums.remove(d5)

      nums.remove(d6)

   nums.remove(d4)

print(sum(answers))
