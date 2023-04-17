************************************************************************
file with basedata            : md333_.bas
initial value random generator: 195467954
************************************************************************
projects                      :  1
jobs (incl. supersource/sink ):  22
horizon                       :  172
RESOURCES
  - renewable                 :  2   R
  - nonrenewable              :  2   N
  - doubly constrained        :  0   D
************************************************************************
PROJECT INFORMATION:
pronr.  #jobs rel.date duedate tardcost  MPM-Time
    1     20      0       20        7       20
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
   1        1          3           2   3   4
   2        3          3          10  13  16
   3        3          1           9
   4        3          3           5   6   9
   5        3          3           7   8  10
   6        3          2          15  17
   7        3          3          11  12  14
   8        3          3          11  17  19
   9        3          3          12  19  21
  10        3          2          15  20
  11        3          2          15  16
  12        3          1          18
  13        3          3          14  18  19
  14        3          1          17
  15        3          1          21
  16        3          1          21
  17        3          1          20
  18        3          1          20
  19        3          1          22
  20        3          1          22
  21        3          1          22
  22        1          0        
************************************************************************
REQUESTS/DURATIONS:
jobnr. mode duration  R 1  R 2  N 1  N 2
------------------------------------------------------------------------
  1      1     0       0    0    0    0
  2      1     3       7    4    9    0
         2     7       6    4    0    3
         3    10       4    1    6    0
  3      1     1       8    6    6    0
         2     6       7    6    0    9
         3     8       7    4    0    8
  4      1     1       7    7    6    0
         2     8       3    7    0    3
         3    10       2    6    5    0
  5      1     3      10   10    1    0
         2     5       5    5    1    0
         3    10       3    5    0    7
  6      1     1       1    6    3    0
         2     9       1    5    0    7
         3    10       1    4    0    6
  7      1     2       5    6    0    8
         2     7       5    6    5    0
         3     9       5    5    0    5
  8      1     4       6    5    9    0
         2     4       9    7    8    0
         3     7       6    4    0    2
  9      1     1       9    8    0    6
         2     5       8    6   10    0
         3     7       8    4   10    0
 10      1     2       4    6    4    0
         2     5       3    5    0    9
         3     6       2    2    2    0
 11      1     7       8    7    9    0
         2     9       8    5    8    0
         3     9       8    6    0    4
 12      1     3       7    9    8    0
         2     4       6    8    7    0
         3     6       5    7    5    0
 13      1     1       6    7    0    5
         2     7       5    7    0    4
         3     7       5    4    5    0
 14      1     5       6    8    4    0
         2     8       6    5    0    9
         3     8       6    8    1    0
 15      1     1       2    5    0    7
         2     2       2    4    5    0
         3    10       1    3    0    6
 16      1     3       4    6    8    0
         2    10       1    4    0    4
         3    10       2    4    4    0
 17      1     4       9    6    6    0
         2     9       9    2    5    0
         3     9       9    4    0    3
 18      1     6       7    7    0    9
         2     8       7    3    6    0
         3     8       5    4    0    9
 19      1     2      10    6    0    5
         2     4       8    6    0    5
         3     9       8    6    8    0
 20      1     5       9    2    7    0
         2    10       9    1    6    0
         3    10       9    1    0    6
 21      1     2       7    9    0    7
         2     5       4    5    4    0
         3     9       4    2    0    6
 22      1     0       0    0    0    0
************************************************************************
RESOURCEAVAILABILITIES:
  R 1  R 2  N 1  N 2
   15   13   64   57
************************************************************************
