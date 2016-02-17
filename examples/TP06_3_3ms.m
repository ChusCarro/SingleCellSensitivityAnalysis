addpath([pwd() '/../src'])

pathToSave = '~/SingleCellSensitivityResults/TP06_3_3ms';
mainElvira = '~/Software/TestEM/TestEMSingleCellSensitivity20150728/bin/testem_gcc';

param = [1:13];
values =[0.70 0.85 1.15 1.30];
cellType = 3;
cores=4;
dt = 0.02;
step_save=5;
%[s]=rmdir(Model,'s');
Imax = 100;
Istep = 0.1;
Idur = 3.3;
Cai_ind = 1;

CL = 1000;
nCLs = 100;

SensitivityAnalysis(cores, pathToSave, mainElvira,cellType, param, values, dt,...
             step_save, Imax, Istep, Idur, CL, nCLs, Cai_ind)

plotIThresholdLimits(pathToSave)

exit
