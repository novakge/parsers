% https://www.mathworks.com/help/matlab/matlab-unit-test-framework.html
% example#1: results = run(parse_boctor_test)
% example#2: runtests('parse_boctor_test')

function tests = parse_boctor_test
tests = functiontests(localfunctions);
end

function setupOnce(testCase)
% setup global stuff
end

% setup test cases
function setup(testCase)
testCase.TestData.BOCTOR_92_001 = 'test_data/boct92.prb';
testCase.TestData.BOCTOR_92MOD_001 = 'test_data/boct92_mod.prb';
end

function test_BOCTOR_92_001(testCase)
[i1,i2,i3,i4,i5,i6] = indicators(parse_boctor(testCase.TestData.BOCTOR_92_001,0));
actSolution = [i1,i2,i3,i4,i5,i6];
expSolution = [50, 0.571, 0.571, 0.256, 0.944, 0.053]; % see also results of "Datasets with Parameters and BKS (BVersion 3 - 2017.xlsx"
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end



function test_BOCTOR_92MOD_001(testCase)
actSolution = parse_boctor(testCase.TestData.BOCTOR_92MOD_001,0);
expSolution = [1,1,1,1,1;
               0,1,1,1,1;
               0,0,1,1,1;
               0,0,0,1,1;
               0,0,0,0,1]; % DSM
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

function test_BOCTOR_92MOD_002(testCase)
[i1,i2,i3,i4,i5,i6] = indicators(parse_boctor(testCase.TestData.BOCTOR_92MOD_001,0));
actSolution = [i1,i2,i3,i4,i5,i6];
expSolution = [5, 1, 0, 1, 0.444, 0];
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

function test_BOCTOR_92MOD_003(testCase)
actSolution = parse_boctor(testCase.TestData.BOCTOR_92MOD_001,1);
expSolution = [1,1,1,1,1,100,0,11,12,13;
               0,1,1,1,1,110,0,11,12,13;
               0,0,1,1,1,111,0,11,12,13;
               0,0,0,1,1,121,0,11,12,13;
               0,0,0,0,1,131,0,11,12,13]; % NTP
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

function test_BOCTOR_92MOD_004(testCase)
actSolution = parse_boctor(testCase.TestData.BOCTOR_92MOD_001,2);
expSolution = [1,1,1,1,1,100,100,0,0,0,0,0,0,11,11,12,12,13,13;
               0,1,1,1,1,110,110,0,0,0,0,0,0,11,11,12,12,13,13;
               0,0,1,1,1,111,112,0,0,0,0,0,0,11,21,12,22,13,23;
               0,0,0,1,1,121,123,0,0,0,0,0,0,11,31,12,32,13,33;
               0,0,0,0,1,131,134,0,0,0,0,0,0,11,41,12,42,13,43]; % CTP
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

function test_BOCTOR_92MOD_005(testCase)
actSolution = parse_boctor(testCase.TestData.BOCTOR_92MOD_001,3);
expSolution = [1,1,1,1,1,   100,0,0,0,          0,0,0,0,    11,0,0,0,       12,0,0,0,       13,0,0,0;
               0,1,1,1,1,   110,0,0,0,          0,0,0,0,    11,0,0,0,       12,0,0,0,       13,0,0,0;
               0,0,1,1,1,   111,112,0,0,        0,0,0,0,    11,21,0,0,      12,22,0,0,      13,23,0,0;
               0,0,0,1,1,   121,122,123,0,      0,0,0,0,    11,21,31,0,     12,22,32,0,     13,23,33,0;
               0,0,0,0,1,   131,132,133,134,    0,0,0,0,    11,21,31,41,    12,22,32,42,    13,23,33,43]; % DTP
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

function teardown(testCase)
% reset local stuff after test
end

function teardownOnce(testCase)
% reset global stuff after test
end

% TODO: add some basic test cases later