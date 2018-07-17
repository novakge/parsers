% https://www.mathworks.com/help/matlab/matlab-unit-test-framework.html
% example#1: results = run(parse_instance_test)
% example#2: runtests('parse_instance_test')

function tests = parse_instance_test
tests = functiontests(localfunctions);
end

function setupOnce(testCase)
% setup global stuff
end

% setup test cases
function setup(testCase)
testCase.TestData.PAT101 = 'test_data/pat101.rcp';
testCase.TestData.PAT80 = 'test_data/pat80.rcp';
testCase.TestData.PAT_OWN01 = 'test_data/Pat_20res_500_i2-1.0.rcp';
testCase.TestData.PAT_OWN02 = 'test_data/Pat_8res_250act_i2-0.25.rcp';
testCase.TestData.PAT_OWN03 = 'test_data/Pat_12res_250act_i2-0.65.rcp';

testCase.TestData.RG300_120 = 'test_data/RG300_120.rcp';
testCase.TestData.RG300_10 = 'test_data/RG300_10.rcp';
end

function test_pat101(testCase)
[i1,i2,i3,i4,i5,i6] = indicators(parse_instance(testCase.TestData.PAT101,0));
actSolution = [i1,i2,i3,i4,i5,i6];
expSolution = [49,0.292,0.162,0.309,1,0]; % see also results of "Datasets with Parameters and BKS (BVersion 3 - 2017.xlsx"
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

function test_pat80(testCase)
[i1,i2,i3,i4,i5,i6] = indicators(parse_instance(testCase.TestData.PAT80,0));
actSolution = [i1,i2,i3,i4,i5,i6];
expSolution = [25,0.25,0.139,0.226,1,0]; % see also results of "Datasets with Parameters and BKS (BVersion 3 - 2017.xlsx"
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

function test_pat_own01(testCase)
[i1,i2,i3,i4,i5,i6] = indicators(parse_instance(testCase.TestData.PAT_OWN01,0));
actSolution = [i1,i2,i3,i4,i5,i6];
expSolution = [500,1.0,i3,i4,i5,i6]; % see also generation properties of RanGen2 gui
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

function test_pat_own02(testCase)
[i1,i2,i3,i4,i5,i6] = indicators(parse_instance(testCase.TestData.PAT_OWN02,0));
actSolution = [i1,i2,i3,i4,i5,i6];
expSolution = [200,0.25,i3,i4,i5,i6]; % see also generation properties of RanGen2 gui
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

function test_pat_own03(testCase)
[i1,i2,i3,i4,i5,i6] = indicators(parse_instance(testCase.TestData.PAT_OWN03,0));
actSolution = [i1,i2,i3,i4,i5,i6];
expSolution = [250,0.65,i3,i4,i5,i6]; % see also generation properties of RanGen2 gui
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

function test_rg300_120(testCase)
[i1,i2,i3,i4,i5,i6] = indicators(parse_instance(testCase.TestData.RG300_120,0));
actSolution = [i1,i2,i3,i4,i5,i6];
expSolution = [300,0.017,0.216,0.037,0.613,0.336]; % see also excel file with results
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

function test_rg300_10(testCase)
[i1,i2,i3,i4,i5,i6] = indicators(parse_instance(testCase.TestData.RG300_10,0));
actSolution = [i1,i2,i3,i4,i5,i6];
expSolution = [300,0.013,0.225,0.061,0.651,0.243]; % see also excel file with results
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

function teardown(testCase)
% reset local stuff after test
end

function teardownOnce(testCase)
% reset global stuff after test
end