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
DSM = parse_rcmp(testCase.TestData.RCMP_BY_001,0);
[i1,i2,i3,i4,i5,i6] = indicators(DSM); % global DSM
actSolution = [i1,i2,i3,i4,i5,i6];
expSolution = [60,0.05,0.547,0.0053,0.722,0.7262];
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

function test_RCMP_BY_002(testCase)
[DSM,~,~,~,~,num_activities,~,~] = parse_rcmp(testCase.TestData.RCMP_BY_002,0);
DSM = DSM(1:num_activities(1),1:num_activities(1)); % select first project's DSM
[i1,i2,i3,i4,i5,i6] = indicators(DSM);
actSolution = [i1,i2,i3,i4,i5,i6];
expSolution = [20,0.1,0.29,0.01,0.2,0.47];
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

function test_RCMP_BY_OWN_001(testCase)
[DSM,~,~,~,~,num_activities,~,~] = parse_rcmp(testCase.TestData.RCMP_BY_OWN_001,0); % DSM
DSM = DSM(sum(num_activities(1:end-1))+1:sum(num_activities(1:end)),sum(num_activities(1:end-1))+1:sum(num_activities(1:end)));
[i1,i2,i3,i4,i5,i6] = indicators(DSM); % last project's PDM
actSolution = [i1,i2,i3,i4,i5,i6];
expSolution = [11,0.2,0.5,0.0833,0.333,0.313];
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

function test_RCMP_BY_OWN_002(testCase)
[PDM,~,num_r_resources,~,~,num_activities,~,~] = parse_rcmp(testCase.TestData.RCMP_BY_OWN_002,3); % DTP
n = size(PDM,1);
TD_act = PDM(:,n+1);
CD_act = PDM(:,n+2);
RD_act = PDM(:,n+3:n+3+num_r_resources-1);
actSolution = [TD_act,CD_act,RD_act];
expSolution = [[2;3;4;5;6;7;8;9;10;11;12;2;3;4;5;6;7;8;9;10;11;12;2;3;4;5;6;7;8;9;10;11;12;2;3;4;5;6;7;8;9;10;11;12],[0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0],[11,22,33;55,66,77;99,100,101;103,104,105;107,108,109;0,0,0;1,1,1;2,2,2;3,3,3;4,4,4;5,5,5;11,22,33;55,66,77;99,100,101;103,104,105;107,108,109;0,0,0;1,1,1;2,2,2;3,3,3;4,4,4;5,5,5;11,22,33;55,66,77;99,100,101;103,104,105;107,108,109;0,0,0;1,1,1;2,2,2;3,3,3;4,4,4;5,5,5;11,22,33;55,66,77;99,100,101;103,104,105;107,108,109;0,0,0;1,1,1;2,2,2;3,3,3;4,4,4;5,5,5]];
verifyEqual(testCase,actSolution,expSolution,'AbsTol',0.01)
end

function teardown(testCase)
% reset local stuff after test
end

function teardownOnce(testCase)
% reset global stuff after test
end

% TODO: add some basic test cases later
