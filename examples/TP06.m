addpath([pwd() '/../src'])

pathToSave = '~/SingleCellSensitivityResults/TP06';
mainElvira = '~/Software/TestEM/TestEM20150303/bin/testem_gcc';
project = 'Conductance Sensitivity - TP06 Model';

param = [1:13];
values =[0.70 0.85 1.15 1.30];
cellType = 3;
cores=4;
dt = 0.02;
step_save=5;
%[s]=rmdir(Model,'s');
Imax = 500;
Istep = 1;

CL = 1000;
nCLs = 300;

SensitivityAnalysis(cores, pathToSave, mainElvira, project, cellType, param, values, dt,...
             step_save, Imax, Istep, CL, nCLs)

%plotIThresholdLimits(pathToSave)

%exit
