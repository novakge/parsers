************************************************************************
file with basedata            : cr131_.bas
initial value random generator: 5328
************************************************************************
projects                      :  1
jobs (incl. supersource/sink ):  18
horizon                       :  134
RESOURCES
  - renewable                 :  1   R
  - nonrenewable              :  2   N
  - doubly constrained        :  0   D
************************************************************************
PROJECT INFORMATION:
pronr.  #jobs rel.date duedate tardcost  MPM-Time
    1     16      0       22       13       22
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
   1        1          3           2   3   4
   2        3          3           5  11  17
   3        3          3          15  16  17
   4        3          3           7  10  11
   5        3          3           6   8   9
   6        3          2          10  13
   7        3          2          14  17
   8        3          2          10  12
   9        3          3          12  13  15
  10        3          1          16
  11        3          2          12  15
  12        3          1          14
  13        3          1          14
  14        3          1          16
  15        3          1          18
  16        3          1          18
  17        3          1          18
  18        1          0        
************************************************************************
REQUESTS/DURATIONS:
jobnr. mode duration  R 1  N 1  N 2
------------------------------------------------------------------------
  1      1     0       0    0    0
  2      1     1       7    7    0
         2     3       7    4    0
         3    10       6    0    8
  3      1     3       7    0    4
         2     4       7    0    3
         3     5       6    0    3
  4      1     1      10    0    9
         2     3      10    3    0
         3     9       9    0    4
  5      1     2       7    0    5
         2     2       7    5    0
         3     4       7    3    0
  6      1     4      10    2    0
         2     4       6    4    0
         3     5       5    0    2
  7      1     1      10    0    2
         2     5      10    9    0
         3    10       9    4    0
  8      1     4       6    0    8
         2     9       6    4    0
         3    10       5    2    0
  9      1     2       9    6    0
         2     7       9    0    6
         3     9       8    2    0
 10      1     1       8    7    0
         2     3       7    5    0
         3     6       7    4    0
 11      1     3       5    0    2
         2     3       7    0    1
         3     9       5    2    0
 12      1     2       8    0    9
         2     8       5    0    6
         3    10       3    0    5
 13      1     4       7    9    0
         2     8       6    8    0
         3     9       6    0    3
 14      1     2       5    0    4
         2     2       5    9    0
         3     8       4    0    4
 15      1     1       7    0    9
         2     7       4    4    0
         3    10       4    0    8
 16      1     9       8    5    0
         2     9       9    0    4
         3    10       6    0    4
 17      1     5       9    0    9
         2     7       6    6    0
         3    10       2    0    8
 18      1     0       0    0    0
************************************************************************
RESOURCEAVAILABILITIES:
  R 1  N 1  N 2
   33   80   84
************************************************************************
