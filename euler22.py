#!/usr/bin/env python2

import sys
import csv

def letter_score(letter):
    return ord(letter.lower())-ord('a')+1


def raw_name_score(name):
    return sum([letter_score(c) for c in name])
    

def get_sum_scores(names):
    # score = 0
    scores = []
    for index, name in enumerate(names):
        # score += (index+1)*raw_name_score(name)
        scores.append((index+1)*raw_name_score(name))
    # return score
    return sum(scores)


def read_names(filename):
    with open(filename) as file:
        text = file.read()
        names = []
        for line in csv.reader([text], skipinitialspace=True):
            for name in line:
                names.append(name)
        return names
    

def main():

    args = sys.argv[1:]
    if args:
        names = read_names(args[0])
        print get_sum_scores(sorted(names))
    else:
        print 'usage: <name_file>'


if __name__ == '__main__':
    main()