addpath([pwd() '/../src'])

pathToSave = '~/SingleCellSensitivityResults/TP06';
mainElvira = '~/Software/TestEM/TestEM20150303/bin/testem_gcc';

param = [1:13];
values =[0.70 0.85 1.15 1.30];
cellType = 3;
cores=4;
dt = 0.02;
step_save=5;
%[s]=rmdir(Model,'s');
Imax = 100;
Istep = 0.1;
Cai_ind = 1;

CL = 1000;
nCLs = 100;

SensitivityAnalysis(cores, pathToSave, mainElvira,cellType, param, values, dt,...
             step_save, Imax, Istep, CL, nCLs, Cai_ind)

plotIThresholdLimits(pathToSave)

exit
