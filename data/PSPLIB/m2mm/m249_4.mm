************************************************************************
file with basedata            : cm249_.bas
initial value random generator: 1411050121
************************************************************************
projects                      :  1
jobs (incl. supersource/sink ):  18
horizon                       :  112
RESOURCES
  - renewable                 :  2   R
  - nonrenewable              :  2   N
  - doubly constrained        :  0   D
************************************************************************
PROJECT INFORMATION:
pronr.  #jobs rel.date duedate tardcost  MPM-Time
    1     16      0       26        4       26
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
   1        1          3           2   3   4
   2        2          3           5   6  14
   3        2          2          13  15
   4        2          3           9  12  14
   5        2          3           7   8  12
   6        2          3           7  12  13
   7        2          2           9  17
   8        2          3          10  13  17
   9        2          1          10
  10        2          2          11  15
  11        2          1          16
  12        2          2          15  17
  13        2          1          16
  14        2          1          16
  15        2          1          18
  16        2          1          18
  17        2          1          18
  18        1          0        
************************************************************************
REQUESTS/DURATIONS:
jobnr. mode duration  R 1  R 2  N 1  N 2
------------------------------------------------------------------------
  1      1     0       0    0    0    0
  2      1     7       9    0    6    9
         2     9       0    7    6    6
  3      1     7       8    0   10    7
         2     9       0    5    8    7
  4      1     6       6    0    9    4
         2     8       5    0    9    2
  5      1     6       6    0    7   10
         2     7       0    2    7   10
  6      1     4       0    7    2    8
         2     8       0    5    2    5
  7      1     2       4    0    9    3
         2     5       0    9    5    2
  8      1     3       0    8    5    3
         2     4       0    5    5    2
  9      1     2       0    8    5    7
         2     9       8    0    4    3
 10      1     2       0    5    5    9
         2     5       0    5    4    8
 11      1     4       7    0   10    8
         2     5       0    3   10    6
 12      1     8       6    0    5    6
         2     8       0    2    5    7
 13      1     3       2    0    6    8
         2     5       2    0    4    7
 14      1     2       5    0    6    8
         2     8       0    5    4    8
 15      1     5       0   10    5    5
         2     9       0    5    4    3
 16      1     1       0    9    5    5
         2     8       0    6    3    5
 17      1     3       0    6    6    8
         2     5      10    0    6    6
 18      1     0       0    0    0    0
************************************************************************
RESOURCEAVAILABILITIES:
  R 1  R 2  N 1  N 2
   10   11   97  103
************************************************************************
