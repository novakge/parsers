************************************************************************
file with basedata            : md286_.bas
initial value random generator: 1918195704
************************************************************************
projects                      :  1
jobs (incl. supersource/sink ):  20
horizon                       :  139
RESOURCES
  - renewable                 :  2   R
  - nonrenewable              :  2   N
  - doubly constrained        :  0   D
************************************************************************
PROJECT INFORMATION:
pronr.  #jobs rel.date duedate tardcost  MPM-Time
    1     18      0       17       17       17
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
   1        1          3           2   3   4
   2        3          3           5   8  12
   3        3          2           9  15
   4        3          2           7  14
   5        3          2           6   7
   6        3          3          10  11  16
   7        3          2          10  19
   8        3          3          15  16  19
   9        3          2          11  12
  10        3          2          17  18
  11        3          3          13  18  19
  12        3          2          13  16
  13        3          1          14
  14        3          1          17
  15        3          1          18
  16        3          1          17
  17        3          1          20
  18        3          1          20
  19        3          1          20
  20        1          0        
************************************************************************
REQUESTS/DURATIONS:
jobnr. mode duration  R 1  R 2  N 1  N 2
------------------------------------------------------------------------
  1      1     0       0    0    0    0
  2      1     5       8    6    0   10
         2     5       9    5    8    0
         3     6       6    4    4    0
  3      1     1       9    8    0    7
         2     5       7    5    4    0
         3     9       7    2    0    2
  4      1     3       7    4    3    0
         2     3       6    4    0    6
         3     8       5    4    3    0
  5      1     5       5    8    7    0
         2     7       4    6    0    7
         3     9       2    4    7    0
  6      1     1       7    8    0    8
         2     3       5    8    0    2
         3     5       2    7    1    0
  7      1     2       9    4    0    7
         2     3       5    4    0    2
         3    10       5    3   10    0
  8      1     3       9    6    7    0
         2     4       7    5    6    0
         3    10       6    4    2    0
  9      1     2       6    9    4    0
         2     5       6    7    0    5
         3     7       5    5    4    0
 10      1     1       8    8    0    7
         2     7       7    8    0    6
         3    10       7    8    1    0
 11      1     2       6    6    7    0
         2     3       6    6    4    0
         3     5       4    2    0    3
 12      1     4       9    4    0    7
         2     5       7    4    0    6
         3     7       7    4    2    0
 13      1     1       7    7    8    0
         2     3       4    7    0   10
         3     3       6    6    0    8
 14      1     1       2    9    9    0
         2     6       2    5    7    0
         3     6       2    6    0    7
 15      1     3       9    7    0    6
         2     4       6    6    5    0
         3    10       2    6    3    0
 16      1     1       4    5    7    0
         2     2       2    4    0    4
         3     7       2    3    6    0
 17      1     2       9    5    8    0
         2     3       9    4    0    4
         3     7       8    4    0    3
 18      1     1       5    8    0    7
         2     5       4    8    0    4
         3    10       3    7    0    4
 19      1     2       9    3    0    8
         2     4       4    3    0    6
         3    10       4    3    0    5
 20      1     0       0    0    0    0
************************************************************************
RESOURCEAVAILABILITIES:
  R 1  R 2  N 1  N 2
   17   14   91  113
************************************************************************
