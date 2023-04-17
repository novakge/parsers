************************************************************************
file with basedata            : c2124_.bas
initial value random generator: 1666245566
************************************************************************
projects                      :  1
jobs (incl. supersource/sink ):  18
horizon                       :  129
RESOURCES
  - renewable                 :  2   R
  - nonrenewable              :  2   N
  - doubly constrained        :  0   D
************************************************************************
PROJECT INFORMATION:
pronr.  #jobs rel.date duedate tardcost  MPM-Time
    1     16      0       21       12       21
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
   1        1          3           2   3   4
   2        3          3           6   7  10
   3        3          3           8   9  12
   4        3          3           5   6   8
   5        3          3           9  11  12
   6        3          2          11  13
   7        3          3           9  12  14
   8        3          2          10  11
   9        3          2          15  17
  10        3          3          13  14  16
  11        3          2          14  16
  12        3          2          13  16
  13        3          2          15  17
  14        3          2          15  17
  15        3          1          18
  16        3          1          18
  17        3          1          18
  18        1          0        
************************************************************************
REQUESTS/DURATIONS:
jobnr. mode duration  R 1  R 2  N 1  N 2
------------------------------------------------------------------------
  1      1     0       0    0    0    0
  2      1     3       3    5    3    0
         2     4       3    5    0    5
         3     5       2    4    0    4
  3      1     5       4   10    0    9
         2     9       3   10    4    0
         3     9       3   10    0    8
  4      1     4       5    6    5    0
         2     5       5    4    3    0
         3     7       4    4    0    9
  5      1     9       1    8    0    7
         2     9       3    5    5    0
         3     9       3    6    4    0
  6      1     3       7    2    0    8
         2     5       7    2    2    0
         3     8       7    2    1    0
  7      1     5       4    4    0    8
         2     9       2    4    0    8
         3    10       2    3    4    0
  8      1     1       7    4    3    0
         2     6       7    2    3    0
         3    10       6    2    3    0
  9      1     3       9    5    0    8
         2     7       8    4    4    0
         3     9       6    3    0    6
 10      1     2       9    8    8    0
         2     8       9    7    5    0
         3     8       8    6    0    1
 11      1     2       3    9    0    4
         2     4       3    7    6    0
         3     7       2    6    3    0
 12      1     2       4    6    0    4
         2     7       3    3    8    0
         3    10       3    3    7    0
 13      1     2       6    3   10    0
         2     8       4    2    0    8
         3     9       2    2    0    4
 14      1     3       7    3    7    0
         2     3       7    3    0    7
         3     4       6    1    0    5
 15      1     3       5    2    0    6
         2     4       4    1    0    4
         3     9       4    1    7    0
 16      1     1       6    5    9    0
         2     4       5    3    8    0
         3     7       2    3    3    0
 17      1     2       7    4    0    4
         2     6       6    2    0    4
         3     8       2    1    6    0
 18      1     0       0    0    0    0
************************************************************************
RESOURCEAVAILABILITIES:
  R 1  R 2  N 1  N 2
   28   24   70   66
************************************************************************
