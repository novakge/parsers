% https://www.mathworks.com/help/matlab/matlab-unit-test-framework.html
% example#1: results = run(parse_progen_test)
% example#2: runtests('parse_progen_test')

function tests = parse_progen_test
tests = functiontests(localfunctions);
end

function setupOnce(testCase)
% setup global stuff
end

% setup test cases
function setup(testCase)
testCase.TestData.PROGEN_OWN_001 = 'test_data/MMRCPSP463.sch';
end

function test_PROGEN_OWN_001(testCase)
[i1,i2,i3,i4,i5,i6] = indicators(parse_progen(testCase.TestData.PROGEN_OWN_001,0));
actSolution = [i1,i2,i3,i4,i5,i6];
expSolution = [40, 0.0770, 0.593, 0, 0.056, 0.648]; % see also results of "Datasets with Parameters and BKS (BVersion 3 - 2017.xlsx"
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

function teardown(testCase)
% reset local stuff after test
end

function teardownOnce(testCase)
% reset global stuff after test
end

% TODO: add some basic test cases later