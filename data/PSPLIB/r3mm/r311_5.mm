************************************************************************
file with basedata            : cr311_.bas
initial value random generator: 263336963
************************************************************************
projects                      :  1
jobs (incl. supersource/sink ):  18
horizon                       :  128
RESOURCES
  - renewable                 :  3   R
  - nonrenewable              :  2   N
  - doubly constrained        :  0   D
************************************************************************
PROJECT INFORMATION:
pronr.  #jobs rel.date duedate tardcost  MPM-Time
    1     16      0       18       12       18
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
   1        1          3           2   3   4
   2        3          3           8   9  11
   3        3          3           9  10  11
   4        3          3           5  12  16
   5        3          3           6  14  15
   6        3          1           7
   7        3          1          13
   8        3          2          14  15
   9        3          3          12  15  16
  10        3          3          12  13  16
  11        3          2          13  14
  12        3          1          17
  13        3          1          17
  14        3          1          17
  15        3          1          18
  16        3          1          18
  17        3          1          18
  18        1          0        
************************************************************************
REQUESTS/DURATIONS:
jobnr. mode duration  R 1  R 2  R 3  N 1  N 2
------------------------------------------------------------------------
  1      1     0       0    0    0    0    0
  2      1     5       4    0    0    0    7
         2     6       3    8    0    0    7
         3     9       3    5    7    2    0
  3      1     6       5    7    0    7    0
         2     7       0    5    0    6    0
         3    10       0    2    0    0    3
  4      1     3       3    0    9    0    6
         2     6       0    8    3    4    0
         3    10       3    0    0    0    5
  5      1     4       0    0    4    4    0
         2     7       0    8    0    0    9
         3     9       9    0    0    0    8
  6      1     1       8    2    0    8    0
         2     2       0    1    8    8    0
         3     8       6    1    6    0    6
  7      1     3       0    5    0    0    7
         2     6       0    0    8    9    0
         3     7      10    5    0    6    0
  8      1     3       0    4    0    0    8
         2     9       0    4    0    9    0
         3    10       0    0    5    7    0
  9      1     2       0    9    8    0    6
         2     2       8    0    0    4    0
         3     3       8    9    0    0    6
 10      1     1       7    0   10    4    0
         2     4       0    0   10    0    9
         3     9       6    0    9    0    6
 11      1     7       4    0    2    0    6
         2     7       0    0    4    6    0
         3     9       4    0    0    0    8
 12      1     2       3    0    0    0    3
         2     4       2    2    8    0    2
         3     5       2    0    8    7    0
 13      1     2       0    0    4    6    0
         2     3       0    8    4    0    9
         3     5       0    7    0    0    7
 14      1     1       0    0    9    8    0
         2     4       0    5    3    0   10
         3     5       7    0    0    0    3
 15      1     1       6    6    0    8    0
         2     9       3    0    0    0    6
         3    10       0    2    0    3    0
 16      1     1       0    4    0    3    0
         2     4       3    0    5    2    0
         3     9       2    2    0    2    0
 17      1     3       8    0    0    5    0
         2     5       7    0    4    0    7
         3    10       0    0    4    0    7
 18      1     0       0    0    0    0    0
************************************************************************
RESOURCEAVAILABILITIES:
  R 1  R 2  R 3  N 1  N 2
   22   18   25   48   52
************************************************************************
