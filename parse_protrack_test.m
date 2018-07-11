% https://www.mathworks.com/help/matlab/matlab-unit-test-framework.html
% example#1: results = run(parse_protrack_test)
% example#2: runtests('parse_protrack_test')

function tests = parse_protrack_test
tests = functiontests(localfunctions);
end

function setupOnce(testCase)
% setup global stuff
end

% setup test cases
function setup(testCase)
testCase.TestData.PT001 = 'test_data/C2011-09 Commercial IT Project.p2x';
testCase.TestData.PT002_001 = 'test_data/test_project_data_001_converted_02_090850.p2x';
testCase.TestData.PT002_002 = 'test_data/test_project_data_002_converted_02_101848.p2x';
testCase.TestData.PT002_003 = 'test_data/test_project_data_003_converted_02_102407.p2x';
end

% first test case with artificial test data
function test_protrack_suite_002_case_001(testCase)
actSolution = parse_protrack(testCase.TestData.PT002_001,1);

%             [      DSM         ]  [TD]  [ CD ] [       RD       ]
expSolution = [1 1 0 0 0 0 0 0 0 0   8    1111   1 0 0 0 0 0 0   0;
               0 1 1 0 0 0 0 0 0 0   16   300    1 0 0 0 0 0 0   0;
               0 0 1 1 0 0 0 0 0 0   24   700    0 0 0 0 0 0 0   1;
               0 0 0 1 1 0 0 0 0 0   32   5000   0 0 0 0 0 0 0.5 0;
               0 0 0 0 1 1 1 1 1 1   5    60000  1 0 0 0 1 0 0   0;
               0 0 0 0 0 1 1 0 0 0   6    250    0 0 0 0 0 1 0   0;
               0 0 0 0 0 0 1 1 0 0   56   4300   1 1 0 1 1 0 0   0;
               0 0 0 0 0 0 0 1 0 0   64   2000.8 0 0 0 0 0 1 0   0;
               0 0 0 0 0 0 0 0 1 1   72   1368   0 0 1 0 0 0 0   0;
               0 0 0 0 0 0 0 0 0 1   80   1000   0 0 0 0 0 0 0   0.75];
           
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

% same test with completely reversed order, same output expected
function test_protrack_suite_002_case_002(testCase)
actSolution = parse_protrack(testCase.TestData.PT002_002,1);

%             [      DSM         ]  [TD]  [ CD ] [       RD       ]
expSolution = [1 1 0 0 0 0 0 0 0 0   8    1111   1 0 0 0 0 0 0   0;
               0 1 1 0 0 0 0 0 0 0   16   300    1 0 0 0 0 0 0   0;
               0 0 1 1 0 0 0 0 0 0   24   700    0 0 0 0 0 0 0   1;
               0 0 0 1 1 0 0 0 0 0   32   5000   0 0 0 0 0 0 0.5 0;
               0 0 0 0 1 1 1 1 1 1   5    60000  1 0 0 0 1 0 0   0;
               0 0 0 0 0 1 1 0 0 0   6    250    0 0 0 0 0 1 0   0;
               0 0 0 0 0 0 1 1 0 0   56   4300   1 1 0 1 1 0 0   0;
               0 0 0 0 0 0 0 1 0 0   64   2000.8 0 0 0 0 0 1 0   0;
               0 0 0 0 0 0 0 0 1 1   72   1368   0 0 1 0 0 0 0   0;
               0 0 0 0 0 0 0 0 0 1   80   1000   0 0 0 0 0 0 0   0.75];
           
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

% test for gaps in task IDs, 3,8,9 removed intentionally
% task #1 will become the first as task #3 is empty, and tasks are topologically sorted + based on ID
function test_protrack_suite_002_case_003(testCase)
actSolution = parse_protrack(testCase.TestData.PT002_003,1);

%             [      DSM         ]  [TD] [ CD ][       RD        ]     Note
expSolution = [1 1 0 0 0 0 0        8    1111  1 0 0 0 0 0 0    0;     % task #1
               0 1 0 0 0 0 0        16   300   1 0 0 0 0 0 0    0;     % task #2 ... missing 3
               0 0 1 1 0 0 0        32   5000  0 0 0 0 0 0 0.50 0;     % task #4
               0 0 0 1 1 1 1        5    60000 1 0 0 0 1 0 0    0;     % task #5
               0 0 0 0 1 1 0        6    250   0 0 0 0 0 1 0    0;     % task #6
               0 0 0 0 0 1 0        56   4300  1 1 0 1 1 0 0    0;     % task #7 ... missing 8 and 9
               0 0 0 0 0 0 1        80   1000  0 0 0 0 0 0 0    0.75]; % task #10

verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01);
end

% TODO: test for apmgen,hpmgen,tpmgen if input format is accepted/OK.


function teardown(testCase)
% reset local stuff after test
end

function teardownOnce(testCase)
% reset global stuff after test
end