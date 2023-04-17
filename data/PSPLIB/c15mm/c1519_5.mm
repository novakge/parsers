************************************************************************
file with basedata            : c1519_.bas
initial value random generator: 884107232
************************************************************************
projects                      :  1
jobs (incl. supersource/sink ):  18
horizon                       :  142
RESOURCES
  - renewable                 :  2   R
  - nonrenewable              :  2   N
  - doubly constrained        :  0   D
************************************************************************
PROJECT INFORMATION:
pronr.  #jobs rel.date duedate tardcost  MPM-Time
    1     16      0       29       14       29
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
   1        1          3           2   3   4
   2        3          1           6
   3        3          3           5   7  10
   4        3          2           9  14
   5        3          1          13
   6        3          3           7   8  11
   7        3          2          15  17
   8        3          2           9  15
   9        3          1          13
  10        3          1          11
  11        3          2          12  16
  12        3          1          13
  13        3          1          17
  14        3          1          15
  15        3          1          18
  16        3          1          18
  17        3          1          18
  18        1          0        
************************************************************************
REQUESTS/DURATIONS:
jobnr. mode duration  R 1  R 2  N 1  N 2
------------------------------------------------------------------------
  1      1     0       0    0    0    0
  2      1     1       7    0    8    0
         2     1       0    7    0    3
         3     8       7    0    0    2
  3      1     1       0    9    6    0
         2    10       0    9    0    4
         3    10       1    0    0    5
  4      1     2      10    0    0    4
         2     3       8    0    1    0
         3     8       7    0    0    4
  5      1     3       0    9    0    7
         2     6       5    0    0    7
         3     8       4    0    0    7
  6      1     1       6    0    9    0
         2     4       0    5    8    0
         3    10       3    0    7    0
  7      1     6       5    0    4    0
         2     8       4    0    0    2
         3     9       4    0    4    0
  8      1     2       0    2    0    7
         2     8       8    0    0    5
         3     9       7    0    0    2
  9      1     2       0   10    0   10
         2     2       5    0    0    6
         3    10       0   10    0    2
 10      1     4       8    0    0    3
         2     9       6    0    0    2
         3    10       4    0    3    0
 11      1     8       3    0    0    8
         2     8       0    7    8    0
         3    10       5    0    2    0
 12      1     6       0    8    0    4
         2     9       3    0    0    2
         3     9       0    7    9    0
 13      1     4       3    0    0   10
         2     5       2    0    0    4
         3     7       0    2    6    0
 14      1     1       0    3    0    8
         2     8       0    1    0    7
         3     9       1    0    2    0
 15      1     4       5    0    5    0
         2    10       0    1    1    0
         3    10       0    2    0    3
 16      1     6       0    5    9    0
         2     7       6    0    7    0
         3     7       0    1    0    9
 17      1     6       0    6    5    0
         2     7       8    0    3    0
         3     8       0    5    0    6
 18      1     0       0    0    0    0
************************************************************************
RESOURCEAVAILABILITIES:
  R 1  R 2  N 1  N 2
   20   13   58   70
************************************************************************
