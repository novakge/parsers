************************************************************************
file with basedata            : cr429_.bas
initial value random generator: 917918995
************************************************************************
projects                      :  1
jobs (incl. supersource/sink ):  18
horizon                       :  129
RESOURCES
  - renewable                 :  4   R
  - nonrenewable              :  2   N
  - doubly constrained        :  0   D
************************************************************************
PROJECT INFORMATION:
pronr.  #jobs rel.date duedate tardcost  MPM-Time
    1     16      0       15       15       15
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
   1        1          3           2   3   4
   2        3          3           8  10  11
   3        3          3           5   7  16
   4        3          2           9  11
   5        3          3           6   9  13
   6        3          2          10  12
   7        3          3           8  12  15
   8        3          1          13
   9        3          3          10  14  15
  10        3          1          17
  11        3          3          15  16  17
  12        3          1          14
  13        3          1          14
  14        3          1          17
  15        3          1          18
  16        3          1          18
  17        3          1          18
  18        1          0        
************************************************************************
REQUESTS/DURATIONS:
jobnr. mode duration  R 1  R 2  R 3  R 4  N 1  N 2
------------------------------------------------------------------------
  1      1     0       0    0    0    0    0    0
  2      1     2       6    8    3   10    0    3
         2     7       4    4    1    5    1    0
         3     7       5    6    1    3    1    0
  3      1     3       7    5    9    9    8    0
         2     4       7    4    8    8    5    0
         3    10       5    3    8    7    0    6
  4      1     2       9   10    3    4    0    5
         2     2       8   10    2    5    0    5
         3     4       5   10    1    3    0    5
  5      1     2       7    8    2    7    0    5
         2     5       6    6    1    6    9    0
         3    10       6    5    1    5    9    0
  6      1     2       7    6    7    8    0    5
         2     8       4    4    6    6    0    4
         3    10       3    1    4    4    7    0
  7      1     6       8    4    2    8    0    9
         2     7       7    4    1    8    0    9
         3     8       6    3    1    7    0    9
  8      1     2       9    9    8    9    0   10
         2     6       5    9    8    9    0    9
         3     8       2    9    8    8    0    8
  9      1     1       8    7    6    8    0   10
         2     5       6    5    5    6    0    8
         3    10       4    5    3    4    5    0
 10      1     3       8    4   10    7    9    0
         2     5       8    4    9    5    4    0
         3     6       4    1    6    3    0    6
 11      1     4       6    8    6    6    0    8
         2     7       4    6    6    5    8    0
         3    10       3    3    5    5    7    0
 12      1     4       7    7    5    5    0    7
         2     7       6    7    5    5    6    0
         3     9       4    7    4    4    2    0
 13      1     2      10    4    5    7    7    0
         2     6       9    4    5    6    5    0
         3     7       9    4    4    3    0    9
 14      1     1       9    8    6    4    0    7
         2     3       8    7    5    4    3    0
         3     5       7    7    4    4    2    0
 15      1     4       7    6    6    8    0    4
         2     5       7    5    5    5    0    3
         3     7       6    5    3    4    0    3
 16      1     3      10    8   10    5    0    2
         2     8       9    6    9    5   10    0
         3     9       9    3    8    4    8    0
 17      1     1       7    6    8    3    5    0
         2     7       6    5    8    3    5    0
         3     9       4    5    8    2    0    4
 18      1     0       0    0    0    0    0    0
************************************************************************
RESOURCEAVAILABILITIES:
  R 1  R 2  R 3  R 4  N 1  N 2
   15   14   13   14   78  100
************************************************************************
