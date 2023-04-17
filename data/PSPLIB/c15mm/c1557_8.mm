************************************************************************
file with basedata            : c1557_.bas
initial value random generator: 154337213
************************************************************************
projects                      :  1
jobs (incl. supersource/sink ):  18
horizon                       :  124
RESOURCES
  - renewable                 :  2   R
  - nonrenewable              :  2   N
  - doubly constrained        :  0   D
************************************************************************
PROJECT INFORMATION:
pronr.  #jobs rel.date duedate tardcost  MPM-Time
    1     16      0       24        8       24
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
   1        1          3           2   3   4
   2        3          1           6
   3        3          3           7   8  12
   4        3          1           5
   5        3          3           7   9  10
   6        3          1          13
   7        3          1          15
   8        3          1          16
   9        3          2          11  17
  10        3          2          14  16
  11        3          2          12  14
  12        3          2          13  15
  13        3          1          16
  14        3          1          15
  15        3          1          18
  16        3          1          18
  17        3          1          18
  18        1          0        
************************************************************************
REQUESTS/DURATIONS:
jobnr. mode duration  R 1  R 2  N 1  N 2
------------------------------------------------------------------------
  1      1     0       0    0    0    0
  2      1     1       6    0    9   10
         2     5       4    0    9    8
         3     6       0    4    8    5
  3      1     2       0    5    5    8
         2     3       0    5    4    5
         3     7       0    5    2    4
  4      1     5       9    0   10    4
         2     6       0    3    8    4
         3     7       8    0    5    3
  5      1     4       0    4    6    8
         2     7       8    0    4    7
         3     8       5    0    4    7
  6      1     5       5    0    9    3
         2     7       0    4    5    2
         3    10       4    0    5    2
  7      1     2       0    2    4    7
         2     2       0    1    3    8
         3     4       1    0    2    3
  8      1     2       0    6    1   10
         2     6       0    6    1    9
         3     8       8    0    1    9
  9      1     3       0    4    6    2
         2     5       8    0    3    2
         3     7       6    0    3    1
 10      1     2       0    5    8    6
         2     3       0    3    5    4
         3     9       0    2    4    3
 11      1     1       6    0    8    3
         2     6       0    6    8    2
         3    10       1    0    8    2
 12      1     1       9    0    6    6
         2     3       0    4    6    5
         3     6       6    0    5    3
 13      1     2       7    0    5    5
         2     5       0    8    5    4
         3     6       6    0    4    2
 14      1     3       0    7   10    6
         2     5       6    0    8    6
         3    10       0    5    4    4
 15      1     1       0    6    7    7
         2     5       0    3    7    7
         3     6       7    0    6    4
 16      1     8       0    4    8    9
         2     9       7    0    7    8
         3    10       5    0    2    7
 17      1     2       8    0    9    8
         2     8       5    0    7    5
         3    10       5    0    5    4
 18      1     0       0    0    0    0
************************************************************************
RESOURCEAVAILABILITIES:
  R 1  R 2  N 1  N 2
   10    8  111  103
************************************************************************
