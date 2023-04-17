************************************************************************
file with basedata            : md245_.bas
initial value random generator: 293207972
************************************************************************
projects                      :  1
jobs (incl. supersource/sink ):  18
horizon                       :  138
RESOURCES
  - renewable                 :  2   R
  - nonrenewable              :  2   N
  - doubly constrained        :  0   D
************************************************************************
PROJECT INFORMATION:
pronr.  #jobs rel.date duedate tardcost  MPM-Time
    1     16      0       19        2       19
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
   1        1          3           2   3   4
   2        3          3          10  11  15
   3        3          1          12
   4        3          3           5   8  10
   5        3          2           6   9
   6        3          2           7  11
   7        3          3          13  15  16
   8        3          3           9  13  14
   9        3          2          11  15
  10        3          2          13  14
  11        3          2          16  17
  12        3          2          14  17
  13        3          1          17
  14        3          1          16
  15        3          1          18
  16        3          1          18
  17        3          1          18
  18        1          0        
************************************************************************
REQUESTS/DURATIONS:
jobnr. mode duration  R 1  R 2  N 1  N 2
------------------------------------------------------------------------
  1      1     0       0    0    0    0
  2      1     5       2    5    6    8
         2     6       2    3    4    8
         3     9       1    2    4    7
  3      1     1       7    7    7    6
         2     5       6    6    6    5
         3    10       3    6    4    3
  4      1     5       5    9    8    8
         2     6       5    7    8    7
         3     9       4    5    7    6
  5      1     3       7    8    5    3
         2    10       6    8    4    1
         3    10       5    8    3    2
  6      1     3       4    8    8    7
         2     7       4    8    6    6
         3    10       4    7    4    4
  7      1     2       8   10    8    2
         2     8       3    8    6    2
         3     8       6    7    8    2
  8      1     1       7    9    9    9
         2     5       7    8    6    8
         3     9       6    5    5    8
  9      1     5       7    9    9    4
         2     6       6    5    7    3
         3     8       3    3    3    3
 10      1     7       6    4    9    7
         2     8       4    3    8    4
         3     9       1    2    5    3
 11      1     1       4   10    3    7
         2     4       4    9    3    6
         3     6       3    7    2    6
 12      1     3       9    6    5    3
         2     3       8    7    4    3
         3    10       3    5    3    3
 13      1     2       8    7    3   10
         2     5       7    7    3    7
         3    10       5    5    3    7
 14      1     3       7    5    6   10
         2     4       7    5    5    6
         3     6       7    4    3    4
 15      1     6       8    9    9    6
         2     7       8    6    8    4
         3     8       8    2    8    3
 16      1     1       5    4    5    6
         2     7       5    3    5    6
         3     8       4    2    4    6
 17      1     2       2    4   10    7
         2     7       2    3    8    4
         3     8       2    2    5    3
 18      1     0       0    0    0    0
************************************************************************
RESOURCEAVAILABILITIES:
  R 1  R 2  N 1  N 2
   13   14  100   95
************************************************************************
