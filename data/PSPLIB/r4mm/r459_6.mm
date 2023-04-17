************************************************************************
file with basedata            : cr459_.bas
initial value random generator: 276455225
************************************************************************
projects                      :  1
jobs (incl. supersource/sink ):  18
horizon                       :  129
RESOURCES
  - renewable                 :  4   R
  - nonrenewable              :  2   N
  - doubly constrained        :  0   D
************************************************************************
PROJECT INFORMATION:
pronr.  #jobs rel.date duedate tardcost  MPM-Time
    1     16      0       20        5       20
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
   1        1          3           2   3   4
   2        3          2          12  13
   3        3          3           5   7  11
   4        3          3           6  11  17
   5        3          3           6   8  10
   6        3          2           9  13
   7        3          3           9  10  12
   8        3          2          13  17
   9        3          2          14  16
  10        3          2          14  16
  11        3          1          16
  12        3          2          15  17
  13        3          1          14
  14        3          1          15
  15        3          1          18
  16        3          1          18
  17        3          1          18
  18        1          0        
************************************************************************
REQUESTS/DURATIONS:
jobnr. mode duration  R 1  R 2  R 3  R 4  N 1  N 2
------------------------------------------------------------------------
  1      1     0       0    0    0    0    0    0
  2      1     1       0    0    3    8    8    8
         2     8       7   10    3    0    7    7
         3     9       0    0    2    8    5    3
  3      1     1       8    0    0    6    4    3
         2     6       4    6    6    5    3    3
         3     8       3    6    0    0    2    2
  4      1     2       6    0    7    0   10    4
         2     9       0    0    7    0   10    4
         3    10       6    3    6    0   10    3
  5      1     1       0    3    0    6    4    6
         2     8       8    0    0    2    2    4
         3     9       0    3    0    0    1    4
  6      1     2       0    4    7    0    7    8
         2     5       6    4    0    5    6    8
         3     8       0    0    5    0    6    7
  7      1     6      10    1    7    0    6    7
         2     8       9    0    0    3    5    7
         3     9       9    1    0    0    5    7
  8      1     5       0    8    0    0    3    1
         2     6       0    0    6    8    2    1
         3     9       0    7    0    0    2    1
  9      1     1       0    0    6    5    6    9
         2     7       6    9    0    0    5    9
         3     9       0    6    0    0    1    9
 10      1     5      10    0    9    0    8    8
         2     5       7    0    0    0    6    9
         3     8       0    0    0    6    6    6
 11      1     2       0    7    0    5    8    9
         2     2       0    0    2    5    9    9
         3     9       9    0    2    0    8    5
 12      1     3       1    7    1    0    6    6
         2     3       1    0    0   10    6    7
         3     4       1    0    1    7    5    6
 13      1     4       3    7    9    7    9    2
         2     6       0    0    0    7    8    2
         3     6       3    0    0    0    9    2
 14      1     6       7    8    0    0    2    6
         2     6       0    0    6    5    3    7
         3     7       7    7    5    4    2    4
 15      1     2       0    0    0    7    7    2
         2     4       0    3    7    0    7    2
         3     8       0    3    3    0    6    2
 16      1     1       7   10    0    0    4    6
         2     6       6    0    4    0    2    4
         3     6       0    9    0    3    2    1
 17      1     2       7    0    0    0    5    7
         2     9       0    5    6    0    4    4
         3    10       4    0    0    9    3    2
 18      1     0       0    0    0    0    0    0
************************************************************************
RESOURCEAVAILABILITIES:
  R 1  R 2  R 3  R 4  N 1  N 2
   28   17   20   21   99   95
************************************************************************
