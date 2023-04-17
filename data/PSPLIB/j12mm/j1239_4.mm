************************************************************************
file with basedata            : md103_.bas
initial value random generator: 648585638
************************************************************************
projects                      :  1
jobs (incl. supersource/sink ):  14
horizon                       :  96
RESOURCES
  - renewable                 :  2   R
  - nonrenewable              :  2   N
  - doubly constrained        :  0   D
************************************************************************
PROJECT INFORMATION:
pronr.  #jobs rel.date duedate tardcost  MPM-Time
    1     12      0       14       11       14
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
   1        1          3           2   3   4
   2        3          3           5   8   9
   3        3          3           5   6   8
   4        3          2           8  10
   5        3          1           7
   6        3          2           7   9
   7        3          2          10  11
   8        3          3          11  12  13
   9        3          2          11  12
  10        3          2          12  13
  11        3          1          14
  12        3          1          14
  13        3          1          14
  14        1          0        
************************************************************************
REQUESTS/DURATIONS:
jobnr. mode duration  R 1  R 2  N 1  N 2
------------------------------------------------------------------------
  1      1     0       0    0    0    0
  2      1     3       2    8    8    5
         2     6       2    8    7    4
         3     8       1    8    7    3
  3      1     1       6    8    9    8
         2     2       5    8    7    7
         3     4       5    8    5    7
  4      1     1       3    9    9    7
         2     5       3    4    6    5
         3     9       1    1    5    3
  5      1     1       8    5    8    6
         2     3       6    4    8    5
         3     9       4    3    7    2
  6      1     4       8    8    3    2
         2     6       4    8    3    1
         3     6       6    8    2    2
  7      1     1       8    8    4    9
         2     3       8    6    4    9
         3     4       7    4    3    9
  8      1     4       5   10    6    1
         2     9       5    7    6    1
         3    10       3    5    5    1
  9      1     2       6    8    9    8
         2     7       5    5    7    7
         3    10       3    4    4    5
 10      1     3       6    7    6    4
         2     3       4    8    6    4
         3     9       2    6    6    2
 11      1     5       8    6    8    7
         2     8       7    6    4    6
         3     9       6    5    1    5
 12      1     5       9    3    1    5
         2     8       8    2    1    4
         3    10       8    1    1    3
 13      1     5       6    5    6    4
         2     6       5    5    4    3
         3     8       4    4    2    2
 14      1     0       0    0    0    0
************************************************************************
RESOURCEAVAILABILITIES:
  R 1  R 2  N 1  N 2
   19   22   55   49
************************************************************************
