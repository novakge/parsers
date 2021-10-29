% https://www.mathworks.com/help/matlab/matlab-unit-test-framework.html
% example#1: results = run(parse_rcmp_test)
% example#2: runtests('parse_rcmp_test')

function tests = parse_rcmp_test
tests = functiontests(localfunctions);
end

function setupOnce(testCase)
% setup global stuff
end

% setup test cases
function setup(testCase)
testCase.TestData.RCMP_BY_001 = 'test_data/BY_10_3_32.rcmp';
testCase.TestData.RCMP_BY_002 = 'test_data/BY_10_3_32.rcmp';
testCase.TestData.RCMP_BY_003 = 'test_data/BY_10_3_32.rcmp';
testCase.TestData.RCMP_BY_004 = 'test_data/mp_j120_a20_nr2.rcmp'; % 1st project is j12029_4.sm
testCase.TestData.RCMP_BY_005 = 'test_data/mp_j120_a20_nr2.rcmp'; % last project is j12060_8.sm
testCase.TestData.RCMP_BY_OWN_001 = 'test_data/test_001.rcmp';
testCase.TestData.RCMP_BY_OWN_002 = 'test_data/test_001.rcmp';
end

function test_RCMP_BY_001(testCase)
DSM_cell = parse_rcmp(testCase.TestData.RCMP_BY_001,0);
DSM_mat = cell2mat(DSM_cell(1));
[i1,i2,i3,i4,i5,i6] = indicators(DSM_mat); % 1st project's DSM
actSolution = [i1,i2];
expSolution = [20,0.11];
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

function test_RCMP_BY_002(testCase)
DSM_cell = parse_rcmp(testCase.TestData.RCMP_BY_002,0);
DSM_mat = cell2mat(DSM_cell(2));
[i1,i2,i3,i4,i5,i6] = indicators(DSM_mat); % 2nd project's DSM
actSolution = [i1,i2];
expSolution = [20,0.16];
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

function test_RCMP_BY_003(testCase)
DSM_cell = parse_rcmp(testCase.TestData.RCMP_BY_003,0);
DSM_mat = cell2mat(DSM_cell(3));
[i1,i2,i3,i4,i5,i6] = indicators(DSM_mat); % 3rd project's DSM
actSolution = [i1,i2];
expSolution = [20,0.05];
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

function test_RCMP_BY_004(testCase)
DSM_cell = parse_rcmp(testCase.TestData.RCMP_BY_004,0);
DSM_mat = cell2mat(DSM_cell(1));
[i1,i2,i3,i4,i5,i6] = indicators(DSM_mat); % 1st project's DSM
actSolution = [i1,i2,i3,i4,i5,i6];
expSolution = [120,0.109,0.335,0.008,0.825,0.202];
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

function test_RCMP_BY_005(testCase)
DSM_cell = parse_rcmp(testCase.TestData.RCMP_BY_005,0);
DSM_mat = cell2mat(DSM_cell(20));
[i1,i2,i3,i4,i5,i6] = indicators(DSM_mat); % 20th project's DSM
actSolution = [i1,i2,i3,i4,i5,i6];
expSolution = [120,0.126,0.251,0.012,0.805,0.167];
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

function test_RCMP_BY_OWN_001(testCase)
PDM = parse_rcmp(testCase.TestData.RCMP_BY_OWN_001,0); % DSM
DSM_selected = cell2mat(PDM(4));
[i1,i2,i3,i4,i5,i6] = indicators(DSM_selected); % 4th project's PDM
actSolution = [i1,i2,i3,i4,i5,i6];
expSolution = [11,0.2,0.5,0.0833,0.333,0.313];
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

function test_RCMP_BY_OWN_002(testCase)
[PDM,~,num_r_resources,~,~,num_activities,~] = parse_rcmp(testCase.TestData.RCMP_BY_OWN_002,3); % DTP
PDM_sel = cell2mat(PDM(2)); % select the 2nd project's PDM
n = size(PDM_sel,1);
TD_act = PDM_sel(:,n+1);
CD_act = PDM_sel(:,n+2);
RD_act = PDM_sel(:,n+3:n+3+num_r_resources-1);
actSolution = [TD_act,CD_act,RD_act];
expSolution = [[2;3;4;5;6;7;8;9;10;11;12],[0;0;0;0;0;0;0;0;0;0;0],[11,22,33;55,66,77;99,100,101;103,104,105;107,108,109;0,0,0;1,1,1;2,2,2;3,3,3;4,4,4;5,5,5]];
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

function teardown(testCase)
% reset local stuff after test
end

function teardownOnce(testCase)
% reset global stuff after test
end

% TODO: add some basic test cases later