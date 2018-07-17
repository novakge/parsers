% https://www.mathworks.com/help/matlab/matlab-unit-test-framework.html
% example#1: results = run(parse_xlib_test)
% example#2: runtests('parse_xlib_test')

function tests = parse_xlib_test
tests = functiontests(localfunctions);
end

function setupOnce(testCase)
% setup global stuff
end

% setup test cases
function setup(testCase)
testCase.TestData.MMLIB100_001 = 'test_data/J100100_5.mm';
testCase.TestData.MMLIBPLUS_001 = 'test_data/Jall640_1.mm';
testCase.TestData.MMLIB50_001 = 'test_data/J5050_1.mm';
testCase.TestData.MMLIB_OWN_001 = 'test_data/test001.mm';
testCase.TestData.MMLIB_OWN_002 = 'test_data/J50100_1_mod.mm';
testCase.TestData.PSPLIB_001 = 'test_data/c1510_10.mm';
testCase.TestData.PSPLIB_OWN_001 = 'test_data/c1510_1_mod.mm';
end

function test_MMLIB100_001(testCase)
[i1,i2,i3,i4,i5,i6] = indicators(parse_xlib(testCase.TestData.MMLIB100_001,0));
actSolution = [i1,i2,i3,i4,i5,i6];
expSolution = [100, 0.121, 0.139, 0.154, 0.907, 0.067]; % see also results of "Datasets with Parameters and BKS (BVersion 3 - 2017.xlsx"
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

function test_MMLIBPLUS_001(testCase)
[i1,i2,i3,i4,i5,i6] = indicators(parse_xlib(testCase.TestData.MMLIBPLUS_001,0));
actSolution = [i1,i2,i3,i4,i5,i6];
expSolution = [100, 0.121, 0.156, 0.189, 0.9, 0.082]; % see also results of "Datasets with Parameters and BKS (BVersion 3 - 2017.xlsx"
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

function test_MMLIB50_001(testCase)
[i1,i2,i3,i4,i5,i6] = indicators(parse_xlib(testCase.TestData.MMLIB50_001,0));
actSolution = [i1,i2,i3,i4,i5,i6];
expSolution = [50, 0.122, 0.31, 0.147, 0.813, 0.213]; % see also results of "Datasets with Parameters and BKS (BVersion 3 - 2017.xlsx"
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

function test_MMLIB_OWN_001(testCase)
[i1,i2,i3,i4,i5,i6] = indicators(parse_xlib(testCase.TestData.MMLIB_OWN_001,0));
actSolution = [i1,i2,i3,i4,i5,i6];
expSolution = [4, 1, 0, i4, i5, i6];
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

function test_MMLIB_OWN_002(testCase)
PDM = parse_xlib(testCase.TestData.MMLIB_OWN_002,3);
actSolution = PDM;
       %[ DSM ] [  TD    ]  [CD ] [               RD                ]
data = [1 1 1 1 11  22  33  1 1 1 5  6  7  8  9  10 11 12 13 14 15 16;
        0 1 1 1 44  55  66  1 1 1 17 18 19 20 21 22 23 24 25 26 27 28;
        0 0 1 1 77  88  99  1 1 1 29 30 31 32 33 34 35 36 37 38 39 40;
        0 0 0 1 111 122 133 1 1 1 41 42 43 44 45 46 47 48 49 50 51 52];
expSolution = data;
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end


function test_PSPLIB_001(testCase)
[i1,i2,i3,i4,i5,i6] = indicators(parse_xlib(testCase.TestData.PSPLIB_001,0));
actSolution = [i1,i2,i3,i4,i5,i6];
expSolution = [16, i2, i3, i4, i5, i6]; % see also results of "Datasets with Parameters and BKS (BVersion 3 - 2017.xlsx"
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

function test_PSPLIB_OWN_001(testCase)
PDM = parse_xlib(testCase.TestData.PSPLIB_OWN_001,3);
actSolution = PDM
       %[ DSM ] [  TD    ][CD ] [        RD                  ]
data = [1 1 1 1 1  2   3  1 1 1 1  2  3  4  5  6  7   8   9;
        0 1 1 1 4  5   6  1 1 1 10 11 12 13 14 15 16  17  18;
        0 0 1 1 7  8   9  1 1 1 19 20 21 22 23 24 25  26  27;
        0 0 0 1 10 11  12 1 1 1 28 29 30 31 32 33 341 351 361];
expSolution = data;
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

function teardown(testCase)
% reset local stuff after test
end

function teardownOnce(testCase)
% reset global stuff after test
end