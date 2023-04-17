************************************************************************
file with basedata            : mm18_.bas
initial value random generator: 2008399954
************************************************************************
projects                      :  1
jobs (incl. supersource/sink ):  12
horizon                       :  85
RESOURCES
  - renewable                 :  2   R
  - nonrenewable              :  2   N
  - doubly constrained        :  0   D
************************************************************************
PROJECT INFORMATION:
pronr.  #jobs rel.date duedate tardcost  MPM-Time
    1     10      0       18        3       18
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
   1        1          3           2   3   4
   2        3          2           6   8
   3        3          2           7   9
   4        3          2           5  10
   5        3          2           7   9
   6        3          2           9  10
   7        3          1           8
   8        3          1          11
   9        3          1          12
  10        3          1          12
  11        3          1          12
  12        1          0        
************************************************************************
REQUESTS/DURATIONS:
jobnr. mode duration  R 1  R 2  N 1  N 2
------------------------------------------------------------------------
  1      1     0       0    0    0    0
  2      1     2       9    0    0    9
         2     3       4    0    2    0
         3     3       7    0    1    0
  3      1     2       0    8    5    0
         2     8       0    8    4    0
         3    10       5    0    4    0
  4      1     2       6    0   10    0
         2     9       0    8    2    0
         3    10       0    7    0    9
  5      1     8       0    6    9    0
         2     9       7    0    0    7
         3    10       3    0    0    7
  6      1     3       0    3    0   10
         2     7       0    2    0    9
         3    10       9    0    0    9
  7      1     2       9    0    0    6
         2     7       7    0    8    0
         3     9       6    0    0    5
  8      1     2       6    0    0    6
         2     5       5    0    8    0
         3     9       0    4    2    0
  9      1     2       0   10    0   10
         2     7       1    0    0    8
         3     7       0   10    0    8
 10      1     5       0    9    0    3
         2     5      10    0    6    0
         3     7       0    9    4    0
 11      1     4       0    8    2    0
         2     6       6    0    0    6
         3    10       0    6    0    6
 12      1     0       0    0    0    0
************************************************************************
RESOURCEAVAILABILITIES:
  R 1  R 2  N 1  N 2
   17   11   27   42
************************************************************************
