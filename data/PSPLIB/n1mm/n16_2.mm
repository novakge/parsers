************************************************************************
file with basedata            : cn16_.bas
initial value random generator: 732305383
************************************************************************
projects                      :  1
jobs (incl. supersource/sink ):  18
horizon                       :  125
RESOURCES
  - renewable                 :  2   R
  - nonrenewable              :  1   N
  - doubly constrained        :  0   D
************************************************************************
PROJECT INFORMATION:
pronr.  #jobs rel.date duedate tardcost  MPM-Time
    1     16      0       17       13       17
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
   1        1          3           2   3   4
   2        3          3           5   6   7
   3        3          3          11  12  17
   4        3          2           5   7
   5        3          3           9  11  12
   6        3          3           8  14  17
   7        3          3          10  11  14
   8        3          1          10
   9        3          3          13  16  17
  10        3          1          12
  11        3          1          16
  12        3          2          15  16
  13        3          1          14
  14        3          1          15
  15        3          1          18
  16        3          1          18
  17        3          1          18
  18        1          0        
************************************************************************
REQUESTS/DURATIONS:
jobnr. mode duration  R 1  R 2  N 1
------------------------------------------------------------------------
  1      1     0       0    0    0
  2      1     2       8    4    0
         2     5       8    3    0
         3     7       8    2    0
  3      1     1       8    6    0
         2     3       7    6    0
         3     7       7    4    4
  4      1     3       6   10    0
         2     8       4    9    2
         3    10       1    9    0
  5      1     2       8    9    3
         2     4       6    8    3
         3     5       5    8    0
  6      1     3       8   10    0
         2     7       8    9    5
         3     9       8    8    4
  7      1     2       8    6    0
         2     4       7    5    6
         3     9       7    5    5
  8      1     1       8    3    6
         2     4       6    3    0
         3     9       1    1    0
  9      1     7       5    6    9
         2     7       5    4   10
         3     8       5    4    4
 10      1     2       3    7    9
         2     7       3    7    8
         3     8       1    1    6
 11      1     3       9    9    0
         2     4       6    6    6
         3     5       5    4    0
 12      1     6       9   10    7
         2     7       9    7    6
         3     7       8    5    7
 13      1     2       4    7    7
         2     8       3    6    0
         3    10       2    4    0
 14      1     2       7    7    0
         2     6       5    6    9
         3     8       3    5    6
 15      1     1       9    6    5
         2     3       7    6    0
         3     7       7    5    0
 16      1     2       9    9    0
         2     5       7    6    0
         3     8       2    2    0
 17      1     1       5   10    6
         2     4       5    6    0
         3     8       3    4    0
 18      1     0       0    0    0
************************************************************************
RESOURCEAVAILABILITIES:
  R 1  R 2  N 1
   16   18   33
************************************************************************
