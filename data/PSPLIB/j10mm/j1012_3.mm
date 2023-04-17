************************************************************************
file with basedata            : mm12_.bas
initial value random generator: 1642648665
************************************************************************
projects                      :  1
jobs (incl. supersource/sink ):  12
horizon                       :  81
RESOURCES
  - renewable                 :  2   R
  - nonrenewable              :  2   N
  - doubly constrained        :  0   D
************************************************************************
PROJECT INFORMATION:
pronr.  #jobs rel.date duedate tardcost  MPM-Time
    1     10      0       15        7       15
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
   1        1          3           2   3   4
   2        3          3           6   8   9
   3        3          1          10
   4        3          1           5
   5        3          2           6   7
   6        3          1          11
   7        3          3           8   9  10
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
  2      1     2       0    6    2    0
         2     8       0    5    0    6
         3     9       0    2    2    0
  3      1     2       0    1    0    4
         2     3       8    0    6    0
         3     5       3    0    0    4
  4      1     4       9    0    8    0
         2     5       8    0    8    0
         3     8       0    7    6    0
  5      1     2       0    8    8    0
         2     3       3    0    0   10
         3     6       0    7    8    0
  6      1     1       5    0    0    4
         2     1       0    1    0    3
         3    10       8    0    9    0
  7      1     2       7    0    0    5
         2     5       0   10    6    0
         3     9       0    9    3    0
  8      1     1       0    6    6    0
         2     4       0    5    6    0
         3     7       0    2    0    8
  9      1     4       0    5    0    7
         2    10       0    3    0    5
         3    10       0    4    3    0
 10      1     7       0    7    5    0
         2     8       0    3    3    0
         3    10       8    0    2    0
 11      1     1       3    0    0    7
         2     6       0    4    0    7
         3     7       3    0    0    6
 12      1     0       0    0    0    0
************************************************************************
RESOURCEAVAILABILITIES:
  R 1  R 2  N 1  N 2
    9   11   53   51
************************************************************************
