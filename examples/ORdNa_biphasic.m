addpath([pwd() '/../src'])

pathToSave = '~/SingleCellSensitivityResults/ORdNa_biphasic';
mainElvira = '~/Software/TestEM/TestEMSingleCellSensitivity_Biphasic20170621/bin/testem_gcc';

param = [1:13];
values =[0.70 0.85 1.15 1.30];
cellType = 221;
cores=1;
dt = 0.002;
step_save=50;
%[s]=rmdir(Model,'s');
Imax = 100;
Istep = 0.1;
Idur = 1;
Cai_ind = 5;

CL = 1000;
nCLs = 100;

SensitivityAnalysis(cores, pathToSave, mainElvira,cellType, param, values, dt,...
             step_save, Imax, Istep, Idur, CL, nCLs, Cai_ind)

plotIThresholdLimits(pathToSave)

exit
