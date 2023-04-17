************************************************************************
file with basedata            : mm59_.bas
initial value random generator: 1074687611
************************************************************************
projects                      :  1
jobs (incl. supersource/sink ):  12
horizon                       :  75
RESOURCES
  - renewable                 :  2   R
  - nonrenewable              :  2   N
  - doubly constrained        :  0   D
************************************************************************
PROJECT INFORMATION:
pronr.  #jobs rel.date duedate tardcost  MPM-Time
    1     10      0       17        5       17
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
   1        1          3           2   3   4
   2        3          1           9
   3        3          3           8  10  11
   4        3          1           5
   5        3          3           6   7  10
   6        3          2           9  11
   7        3          1           8
   8        3          1           9
   9        3          1          12
  10        3          1          12
  11        3          1          12
  12        1          0        
************************************************************************
REQUESTS/DURATIONS:
jobnr. mode duration  R 1  R 2  N 1  N 2
------------------------------------------------------------------------
  1      1     0       0    0    0    0
  2      1     4       9    6    6    0
         2     6       5    5    0    8
         3     8       1    5    0    7
  3      1     1       4    6    0    8
         2     7       3    5    9    0
         3     9       3    5    8    0
  4      1     2       8    4    0    9
         2     4       8    4    0    3
         3     4       8    4    8    0
  5      1     6       9    7    4    0
         2     6       8    5    0    1
         3     6       7    6    7    0
  6      1     1       8    3    9    0
         2     2       5    2    9    0
         3     8       2    1    8    0
  7      1     4       8    6    0    4
         2     8       7    5    9    0
         3    10       7    2    6    0
  8      1     4       4   10    3    0
         2     8       4    9    0    8
         3     9       2    9    0    4
  9      1     1       7    6    4    0
         2     2       6    4    0    9
         3     4       6    3    0    7
 10      1     3       5    6    8    0
         2     8       4    5    0    3
         3     8       3    6    8    0
 11      1     6       8    6    0    4
         2     7       6    6    0    3
         3     9       3    5    4    0
 12      1     0       0    0    0    0
************************************************************************
RESOURCEAVAILABILITIES:
  R 1  R 2  N 1  N 2
   21   18   49   38
************************************************************************
