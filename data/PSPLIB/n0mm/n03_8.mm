************************************************************************
file with basedata            : me3_.bas
initial value random generator: 702760010
************************************************************************
projects                      :  1
jobs (incl. supersource/sink ):  12
horizon                       :  81
RESOURCES
  - renewable                 :  2   R
  - nonrenewable              :  0   N
  - doubly constrained        :  0   D
************************************************************************
PROJECT INFORMATION:
pronr.  #jobs rel.date duedate tardcost  MPM-Time
    1     10      0       18        7       18
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
   1        1          3           2   3   4
   2        3          2           6  10
   3        3          3           5   6   7
   4        3          3           5   8  10
   5        3          2           9  11
   6        3          1           8
   7        3          3           9  10  11
   8        3          2           9  11
   9        3          1          12
  10        3          1          12
  11        3          1          12
  12        1          0        
************************************************************************
REQUESTS/DURATIONS:
jobnr. mode duration  R 1  R 2
------------------------------------------------------------------------
  1      1     0       0    0
  2      1     3      10    0
         2     9       7    0
         3    10       0    3
  3      1     8       0    6
         2     9       0    3
         3    10       6    0
  4      1     2       7    0
         2     5       0    5
         3     9       0    3
  5      1     3      10    0
         2     6       0    9
         3     6       9    0
  6      1     1       0    7
         2     4       6    0
         3     5       0    6
  7      1     2       3    0
         2     2       0    9
         3     5       0    3
  8      1     2       9    0
         2     5       8    0
         3    10       7    0
  9      1     1       0   10
         2     3       6    0
         3     7       4    0
 10      1     8       6    0
         2     9       0    2
         3    10       3    0
 11      1     2       7    0
         2     2       0    4
         3     9       6    0
 12      1     0       0    0
************************************************************************
RESOURCEAVAILABILITIES:
  R 1  R 2
   19   16
************************************************************************
