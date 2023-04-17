************************************************************************
file with basedata            : md112_.bas
initial value random generator: 29819
************************************************************************
projects                      :  1
jobs (incl. supersource/sink ):  14
horizon                       :  99
RESOURCES
  - renewable                 :  2   R
  - nonrenewable              :  2   N
  - doubly constrained        :  0   D
************************************************************************
PROJECT INFORMATION:
pronr.  #jobs rel.date duedate tardcost  MPM-Time
    1     12      0       14        4       14
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
   1        1          3           2   3   4
   2        3          3           5   7   9
   3        3          3           6   8   9
   4        3          3           5   7   9
   5        3          3           6  11  13
   6        3          1          10
   7        3          2           8  10
   8        3          2          12  13
   9        3          2          10  11
  10        3          1          12
  11        3          1          14
  12        3          1          14
  13        3          1          14
  14        1          0        
************************************************************************
REQUESTS/DURATIONS:
jobnr. mode duration  R 1  R 2  N 1  N 2
------------------------------------------------------------------------
  1      1     0       0    0    0    0
  2      1     1       9    7   10    6
         2     7       7    5    9    5
         3    10       7    2    9    4
  3      1     5       7    4    5    5
         2     6       6    3    3    4
         3    10       5    3    3    4
  4      1     1      10    9    8    9
         2     2       9    8    4    7
         3     6       9    7    2    7
  5      1     1      10    8    9   10
         2     2      10    8    7    7
         3     9      10    7    4    3
  6      1     5       7    8    2    8
         2     7       5    8    1    7
         3     9       5    7    1    7
  7      1     3      10    7    6    8
         2     7       5    6    5    6
         3     9       2    2    5    6
  8      1     1       9    2    7    7
         2     4       8    2    7    6
         3    10       8    2    6    6
  9      1     5       8    7    6    8
         2     7       7    7    3    5
         3     7       6    5    4    5
 10      1     1       9    4    9    8
         2     5       4    3    7    7
         3     7       2    3    4    7
 11      1     4       9    9    6    7
         2     5       6    6    6    6
         3     7       6    2    6    5
 12      1     1       6    5    7    2
         2     4       6    4    6    2
         3    10       3    3    6    1
 13      1     2       6    5    9    8
         2     5       5    3    9    5
         3     5       4    4    8    4
 14      1     0       0    0    0    0
************************************************************************
RESOURCEAVAILABILITIES:
  R 1  R 2  N 1  N 2
   27   20   71   73
************************************************************************
