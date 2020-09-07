#!/usr/bin/env python3
import os, csv, pytest

expected = ['a command', 'a multi\nline command', 'should be -']

def test():
    rows = []
    with open("./histfile.csv") as f:
        for row in csv.reader(f):
            rows.append(row)
    d = os.path.abspath('.')
    for r in rows:
        assert isinstance(int(r[0]), int)
        msg = r[2]  # check if logged dir is '-', else check against cwd
        if msg == 'should be -':
            assert r[1] == '-'
        else:
            assert r[1] == d

