addpath([pwd() '/../src'])

pathToSave = '~/SingleCellSensitivityResults/CRLPNewStim';
mainElvira = '~/Software/TestEM/TestEMNewStim/bin/testem_gcc';

param = [1:14];
values =[0.70 0.85 1.15 1.30];
cellType = 15;
cores=1;
dt = 0.002;
step_save=1;
%[s]=rmdir(Model,'s');
Imax = 0.1;
Istep = 0.01;
Idur = 1;
Cai_ind = 1;

CL = 1000;
nCLs = 100;

SensitivityAnalysis(cores, pathToSave, mainElvira,cellType, param, values, dt,...
             step_save, Imax, Istep, Idur, CL, nCLs, Cai_ind)

plotIThresholdLimits(pathToSave)

exit
