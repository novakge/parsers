************************************************************************
file with basedata            : cr156_.bas
initial value random generator: 31247
************************************************************************
projects                      :  1
jobs (incl. supersource/sink ):  18
horizon                       :  119
RESOURCES
  - renewable                 :  1   R
  - nonrenewable              :  2   N
  - doubly constrained        :  0   D
************************************************************************
PROJECT INFORMATION:
pronr.  #jobs rel.date duedate tardcost  MPM-Time
    1     16      0       18        6       18
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
   1        1          3           2   3   4
   2        3          3           6   7  11
   3        3          3           5   9  11
   4        3          3           5  16  17
   5        3          2           8  14
   6        3          2          13  14
   7        3          2           9  12
   8        3          1          12
   9        3          2          10  14
  10        3          3          13  15  16
  11        3          3          12  13  16
  12        3          1          15
  13        3          1          17
  14        3          1          15
  15        3          1          18
  16        3          1          18
  17        3          1          18
  18        1          0        
************************************************************************
REQUESTS/DURATIONS:
jobnr. mode duration  R 1  N 1  N 2
------------------------------------------------------------------------
  1      1     0       0    0    0
  2      1     4       7    7    9
         2     5       7    5    9
         3    10       4    3    8
  3      1     2       8   10    7
         2     3       7   10    6
         3     3       7    9    7
  4      1     5       9    4    8
         2     6       9    3    7
         3     6       9    2    8
  5      1     2       7    5    8
         2     6       4    4    8
         3     7       3    2    7
  6      1     2       5    9    4
         2     4       4    9    4
         3    10       3    8    2
  7      1     1       8    5    7
         2     2       5    4    7
         3     8       3    1    7
  8      1     2      10    2    4
         2     5       5    2    3
         3     9       1    2    2
  9      1     1       5    8    7
         2     4       4    4    6
         3     6       3    1    6
 10      1     3       8   10    3
         2     8       8    6    3
         3     8       7    8    3
 11      1     1       4    2    4
         2     2       3    1    3
         3     3       2    1    3
 12      1     4       4    7    8
         2     5       4    4    6
         3     6       4    3    4
 13      1     1       6    8    5
         2     7       5    8    5
         3     8       5    7    4
 14      1     1       9    7    6
         2     3       8    5    6
         3     9       8    2    5
 15      1     5       7    7    5
         2     7       7    4    5
         3     9       7    4    4
 16      1     3       3    9    8
         2     7       3    8    8
         3     9       3    6    7
 17      1     2      10    9    8
         2     5       5    6    4
         3     8       2    2    1
 18      1     0       0    0    0
************************************************************************
RESOURCEAVAILABILITIES:
  R 1  N 1  N 2
   27   97   95
************************************************************************
