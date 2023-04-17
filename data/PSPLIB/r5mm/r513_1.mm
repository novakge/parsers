************************************************************************
file with basedata            : cr513_.bas
initial value random generator: 10649
************************************************************************
projects                      :  1
jobs (incl. supersource/sink ):  18
horizon                       :  134
RESOURCES
  - renewable                 :  5   R
  - nonrenewable              :  2   N
  - doubly constrained        :  0   D
************************************************************************
PROJECT INFORMATION:
pronr.  #jobs rel.date duedate tardcost  MPM-Time
    1     16      0       20        7       20
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
   1        1          3           2   3   4
   2        3          3           6  10  14
   3        3          2           5   7
   4        3          2          10  14
   5        3          3           6   9  11
   6        3          2          13  16
   7        3          2           8  12
   8        3          2           9  15
   9        3          2          10  16
  10        3          1          17
  11        3          2          12  13
  12        3          1          14
  13        3          2          15  17
  14        3          3          15  16  17
  15        3          1          18
  16        3          1          18
  17        3          1          18
  18        1          0        
************************************************************************
REQUESTS/DURATIONS:
jobnr. mode duration  R 1  R 2  R 3  R 4  R 5  N 1  N 2
------------------------------------------------------------------------
  1      1     0       0    0    0    0    0    0    0
  2      1     3       2    4    3    8    9    3    0
         2     6       2    3    2    5    9    0    7
         3     9       2    3    2    3    6    1    0
  3      1     2       5   10    7    8   10    0    6
         2     3       5    9    7    8    9    5    0
         3    10       2    9    7    8    8    2    0
  4      1     1       6    9    8   10    8    0   10
         2     8       5    9    7    9    5    0    9
         3    10       5    6    5    9    4    3    0
  5      1     5       7    7    6    8    7    0    6
         2     9       7    7    4    8    6    9    0
         3     9       6    7    5    8    6    9    0
  6      1     3       3    7    8   10    6    0    6
         2     3       2    8    8   10    6    9    0
         3     9       1    3    5   10    6    8    0
  7      1     6       5   10   10    5    8    4    0
         2    10       1    8    3    5    5    0    9
         3    10       1    9    6    2    5    0    8
  8      1     5       6    6    9    6    7    0    8
         2     7       6    3    7    4    6    0    8
         3     9       3    3    6    3    6    0    7
  9      1     1       9    9    7    8    3    0    2
         2     4       7    9    5    8    2    9    0
         3    10       3    8    1    5    2    3    0
 10      1     2       5    9    8    4    5    0   10
         2     5       4    6    8    2    3    0    9
         3     8       4    5    7    1    3    0    6
 11      1     1       6    8   10    6    5    1    0
         2     1       5    8   10    7    4    0    3
         3     5       5    8    9    6    2    0    3
 12      1     1       4    3    8    5    8    6    0
         2     3       4    2    7    4    7    4    0
         3     4       4    1    4    1    7    0    5
 13      1     1       7    9    8    9    1    0    6
         2     4       6    8    6    7    1    8    0
         3     5       6    6    5    6    1    0    3
 14      1     2       8    9    7    4    6    0    7
         2     2       8    7    8    6    6    9    0
         3    10       6    4    7    2    3    5    0
 15      1     7       7    6    6    8    4    0    2
         2     7       6    9    6    9    4    4    0
         3    10       5    2    2    8    3    4    0
 16      1     4       6    4   10    5    5   10    0
         2     4       4    4    7    5    7   10    0
         3     8       4    3    7    4    3   10    0
 17      1     3       3    3    6    5    8    6    0
         2     4       3    3    5    5    5    0    4
         3     8       2    2    2    4    1    0    4
 18      1     0       0    0    0    0    0    0    0
************************************************************************
RESOURCEAVAILABILITIES:
  R 1  R 2  R 3  R 4  R 5  N 1  N 2
   10   13   14   14   13   48   52
************************************************************************
