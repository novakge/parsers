************************************************************************
file with basedata            : cr524_.bas
initial value random generator: 1265322687
************************************************************************
projects                      :  1
jobs (incl. supersource/sink ):  18
horizon                       :  122
RESOURCES
  - renewable                 :  5   R
  - nonrenewable              :  2   N
  - doubly constrained        :  0   D
************************************************************************
PROJECT INFORMATION:
pronr.  #jobs rel.date duedate tardcost  MPM-Time
    1     16      0       31        9       31
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
   1        1          3           2   3   4
   2        3          3           5   6  12
   3        3          3           5   8   9
   4        3          1           6
   5        3          3           7  11  14
   6        3          1           9
   7        3          3          10  15  17
   8        3          3          10  11  12
   9        3          2          13  16
  10        3          1          16
  11        3          2          15  17
  12        3          2          14  16
  13        3          1          14
  14        3          2          15  17
  15        3          1          18
  16        3          1          18
  17        3          1          18
  18        1          0        
************************************************************************
REQUESTS/DURATIONS:
jobnr. mode duration  R 1  R 2  R 3  R 4  R 5  N 1  N 2
------------------------------------------------------------------------
  1      1     0       0    0    0    0    0    0    0
  2      1     6       6    4    6    8    7    0    7
         2     7       6    4    5    6    5    7    0
         3     7       6    1    6    3    6    0    5
  3      1     6       6    4    4    1    7    5    0
         2     6       8    4    4    1    6    5    0
         3     8       3    4    1    1    3    5    0
  4      1     1       6    4    6    8    8    0   10
         2     7       6    3    5    7    8    4    0
         3    10       6    2    5    7    8    0    9
  5      1     6       7    6    6    9    8    0    8
         2     8       7    6    4    9    8    0    7
         3    10       4    6    2    8    6    0    5
  6      1     6      10    7    8    8    6    5    0
         2     6      10    8    8    8    6    0   10
         3     8      10    7    7    7    5    7    0
  7      1     1       9    3    6    5    8    0    7
         2     1       8    3    8    4    8    0    8
         3     5       3    2    3    3    6    0    7
  8      1     1       7    6    3    8    5    0    4
         2     2       6    6    2    7    4    0    4
         3     7       6    6    1    5    4    0    3
  9      1     6       2    8    8    7    8    7    0
         2     7       2    7    7    3    8    7    0
         3    10       2    6    6    1    7    6    0
 10      1     3       6    4   10    4    6    0    6
         2     6       5    2    9    2    5    8    0
         3     6       5    1   10    3    6    6    0
 11      1     4       3    9    5   10    8    0    7
         2     7       3    6    5   10    7    0    6
         3     8       2    4    5   10    7    9    0
 12      1     2       8    8    9    7    2   10    0
         2     5       6    5    8    7    1    0    7
         3    10       5    5    7    7    1    0    6
 13      1     4       3    6    4   10    8    0    7
         2     6       2    6    3   10    4    0    6
         3     9       1    6    3    9    3    8    0
 14      1     3       9    7    7    9    5    0    1
         2     4       8    4    6    9    3    6    0
         3     6       7    1    3    9    2    6    0
 15      1     6       9    9    7    3   10    0    6
         2     7       4    5    5    2    7    0    2
         3     9       4    4    4    1    1    5    0
 16      1     3       9    6    6    5    9    7    0
         2     4       6    4    5    2    9    5    0
         3     4       8    5    5    2    8    6    0
 17      1     1       8    5    8   10    6    0    2
         2     4       5    4    8    5    6    8    0
         3     5       4    2    8    3    3    6    0
 18      1     0       0    0    0    0    0    0    0
************************************************************************
RESOURCEAVAILABILITIES:
  R 1  R 2  R 3  R 4  R 5  N 1  N 2
   25   22   23   25   24   72   66
************************************************************************
