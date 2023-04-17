************************************************************************
file with basedata            : cm414_.bas
initial value random generator: 1465848705
************************************************************************
projects                      :  1
jobs (incl. supersource/sink ):  18
horizon                       :  127
RESOURCES
  - renewable                 :  2   R
  - nonrenewable              :  2   N
  - doubly constrained        :  0   D
************************************************************************
PROJECT INFORMATION:
pronr.  #jobs rel.date duedate tardcost  MPM-Time
    1     16      0       16        0       16
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
   1        1          3           2   3   4
   2        4          2          10  14
   3        4          2           5  12
   4        4          3           6   7   8
   5        4          2          13  14
   6        4          3          11  12  16
   7        4          1           9
   8        4          3          10  11  14
   9        4          3          10  12  16
  10        4          1          17
  11        4          1          13
  12        4          2          15  17
  13        4          1          15
  14        4          3          15  16  17
  15        4          1          18
  16        4          1          18
  17        4          1          18
  18        1          0        
************************************************************************
REQUESTS/DURATIONS:
jobnr. mode duration  R 1  R 2  N 1  N 2
------------------------------------------------------------------------
  1      1     0       0    0    0    0
  2      1     1       7    3    8    0
         2     1       6    2    0    8
         3     7       4    2    0    8
         4     9       4    1    8    0
  3      1     5       8    1    0    6
         2     5       8    5    4    0
         3     5       8    3    6    0
         4     5       8    7    3    0
  4      1     1       7    4    0    3
         2     2       7    3    4    0
         3     3       6    2    0    3
         4     4       5    2    2    0
  5      1     3       3    7    9    0
         2     3       3    9    7    0
         3     7       3    6    6    0
         4     9       3    4    5    0
  6      1     1       9   10    0    4
         2     6       9    9   10    0
         3     6       8    9    0    4
         4     9       8    9    0    3
  7      1     3       9    3    0    9
         2     4       7    3    0    7
         3     9       6    2    0    5
         4    10       2    1    3    0
  8      1     2      10    8    0    5
         2     3       7    6    0    5
         3     4       4    5    0    4
         4     6       2    4    0    4
  9      1     1       7    6    0    8
         2     2       7    5    0    6
         3     4       5    4    8    0
         4     7       5    3    5    0
 10      1     6      10   10    0   10
         2     7       9    9    0   10
         3     8       7    8    0    9
         4     9       6    8    0    9
 11      1     2       7    5    7    0
         2     7       7    4    0   10
         3     7       6    5    7    0
         4     9       5    4    0   10
 12      1     2       8    5    0   10
         2     2       8    5    2    0
         3     4       7    5    0    9
         4     9       6    4    0    8
 13      1     2       2    5    4    0
         2     4       2    5    0    3
         3     7       1    5    3    0
         4    10       1    5    0    3
 14      1     4       8    9    0    8
         2     5       7    7    6    0
         3     5       8    8    4    0
         4     5       7    7    0    3
 15      1     1       2    5    8    0
         2     1       2    4   10    0
         3     2       1    4    7    0
         4    10       1    3    0    6
 16      1     1       6    8    9    0
         2     5       5    7    0    6
         3     6       4    6    7    0
         4     7       4    5    2    0
 17      1     4       7    9    7    0
         2     8       7    7    6    0
         3     8       7    5    0   10
         4     9       6    3    5    0
 18      1     0       0    0    0    0
************************************************************************
RESOURCEAVAILABILITIES:
  R 1  R 2  N 1  N 2
   22   19   49   60
************************************************************************
