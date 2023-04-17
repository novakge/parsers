************************************************************************
file with basedata            : cm435_.bas
initial value random generator: 1282068787
************************************************************************
projects                      :  1
jobs (incl. supersource/sink ):  18
horizon                       :  134
RESOURCES
  - renewable                 :  2   R
  - nonrenewable              :  2   N
  - doubly constrained        :  0   D
************************************************************************
PROJECT INFORMATION:
pronr.  #jobs rel.date duedate tardcost  MPM-Time
    1     16      0       23       14       23
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
   1        1          3           2   3   4
   2        4          3           6   9  11
   3        4          3           5   8   9
   4        4          2           8  17
   5        4          3           6  10  11
   6        4          2           7  14
   7        4          1          12
   8        4          2          10  11
   9        4          3          13  14  15
  10        4          2          15  16
  11        4          1          14
  12        4          2          13  15
  13        4          2          16  17
  14        4          1          16
  15        4          1          18
  16        4          1          18
  17        4          1          18
  18        1          0        
************************************************************************
REQUESTS/DURATIONS:
jobnr. mode duration  R 1  R 2  N 1  N 2
------------------------------------------------------------------------
  1      1     0       0    0    0    0
  2      1     1       8    0    7    5
         2     1       0    4    6    6
         3     3      10    0    5    5
         4     4       7    0    4    2
  3      1     4       7    0    6    8
         2     4       0    6    6    7
         3     6       7    0    5    5
         4     9       7    0    5    4
  4      1     3       6    0    9   10
         2     3       0    7    8    8
         3     4       0    6    6    7
         4     9       6    0    5    4
  5      1     1       0    6   10    8
         2     2       0    6    9    6
         3     8       0    5    7    5
         4    10       0    4    5    4
  6      1     8       0    8    9    8
         2     9       8    0    7    7
         3     9       0    8    7    7
         4    10       9    0    5    6
  7      1     2       7    0    8    6
         2     3       6    0    6    6
         3     6       3    0    6    6
         4    10       1    0    4    6
  8      1     2       8    0    6    7
         2     5       5    0    3    6
         3     5       0    5    4    7
         4     8       4    0    3    6
  9      1     5       0    7    9    7
         2     6       7    0    8    7
         3     8       0    6    8    6
         4     9       0    6    6    6
 10      1     2       8    0   10    6
         2     2       0    9   10    5
         3     3       0    3   10    4
         4     5       8    0   10    3
 11      1     3       0    8    6    4
         2     3       9    0    6    4
         3     5       0    7    3    4
         4     8       5    0    2    3
 12      1     1       6    0   10    9
         2     5       0    7    9    7
         3     8       2    0    9    7
         4    10       0    5    9    5
 13      1     4       0    6    6    7
         2     6       3    0    6    7
         3     8       0    2    5    7
         4     9       3    0    5    6
 14      1     4       7    0    5    7
         2     4       0    7    5    7
         3     5       6    0    5    5
         4     7       0    7    5    2
 15      1     4       3    0    2    7
         2     5       1    0    2    5
         3     5       2    0    1    6
         4     6       0    6    1    4
 16      1     3       4    0    9    9
         2     5       4    0    6    6
         3    10       3    0    5    5
         4    10       0    7    5    5
 17      1     1      10    0    5   10
         2     2       0    6    4   10
         3     6      10    0    4    9
         4    10       0    1    4    9
 18      1     0       0    0    0    0
************************************************************************
RESOURCEAVAILABILITIES:
  R 1  R 2  N 1  N 2
   25   20   88   86
************************************************************************
