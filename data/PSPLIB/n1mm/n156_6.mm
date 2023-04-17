************************************************************************
file with basedata            : cn156_.bas
initial value random generator: 959088806
************************************************************************
projects                      :  1
jobs (incl. supersource/sink ):  18
horizon                       :  140
RESOURCES
  - renewable                 :  2   R
  - nonrenewable              :  1   N
  - doubly constrained        :  0   D
************************************************************************
PROJECT INFORMATION:
pronr.  #jobs rel.date duedate tardcost  MPM-Time
    1     16      0       23        4       23
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
   1        1          3           2   3   4
   2        3          2           5  13
   3        3          3           6   7  10
   4        3          2           9  12
   5        3          3           7  10  17
   6        3          3           8  11  12
   7        3          2          11  14
   8        3          2           9  13
   9        3          1          14
  10        3          2          11  16
  11        3          1          15
  12        3          2          15  16
  13        3          2          14  17
  14        3          2          15  16
  15        3          1          18
  16        3          1          18
  17        3          1          18
  18        1          0        
************************************************************************
REQUESTS/DURATIONS:
jobnr. mode duration  R 1  R 2  N 1
------------------------------------------------------------------------
  1      1     0       0    0    0
  2      1     6       7    4    5
         2     8       5    4    5
         3     8       6    3    5
  3      1     2       8   10    3
         2     3       6    9    3
         3     7       6    8    2
  4      1     3       7    4    5
         2     5       4    4    4
         3    10       4    3    2
  5      1     7       5    4    9
         2     8       5    4    8
         3     8       3    4    9
  6      1     2      10    8    2
         2     7      10    6    2
         3     8       9    3    2
  7      1     1       6    9    6
         2     5       5    8    6
         3     8       5    6    6
  8      1     4       5    5    5
         2     8       3    3    5
         3     9       2    1    4
  9      1     1       3    4    5
         2     8       3    3    4
         3     9       2    3    3
 10      1     5       5    6    9
         2     9       1    5    8
         3     9       4    4    7
 11      1     3       9    9    8
         2     7       5    6    8
         3    10       4    4    8
 12      1     5       7    9    7
         2     7       7    6    6
         3    10       7    5    4
 13      1     1       6    6   10
         2     3       5    5    9
         3     7       4    5    9
 14      1     1       9    7    9
         2     1      10    6   10
         3    10       8    2    5
 15      1     2       7    7    9
         2     6       5    6    9
         3     8       2    6    8
 16      1     2       7    5    9
         2     7       6    5    6
         3    10       5    4    4
 17      1     5       6    6   10
         2     9       5    3    9
         3     9       5    4    8
 18      1     0       0    0    0
************************************************************************
RESOURCEAVAILABILITIES:
  R 1  R 2  N 1
   24   23  105
************************************************************************
