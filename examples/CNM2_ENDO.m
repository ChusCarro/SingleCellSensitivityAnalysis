addpath([pwd() '/../src'])

pathToSave = '~/SingleCellSensitivityResults/CNM2';
mainElvira = '~/Software/TestEM/TestEMSingleCellSensitivity20170303/bin/testem_gcc';

param = [1:19];
values =[0.70 0.85 1.15 1.30];
cellType = 214;
cores=4;
dt = 0.002;
step_save=50;
%[s]=rmdir(Model,'s');
Imax = 100;
Istep = 0.1;
Idur = 1;
Cai_ind = 1;

CL = 1000;
nCLs = 100;

SensitivityAnalysis(cores, pathToSave, mainElvira,cellType, param, values, dt,...
             step_save, Imax, Istep, Idur, CL, nCLs, Cai_ind)

plotIThresholdLimits(pathToSave)

exit
