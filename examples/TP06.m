addpath([pwd() '/../src'])

pathToSave = '~/SingleCellSensitivityResults/TP06';
mainElvira = '~/Software/TestEM/TestEMSingleCellSensitivity20170303/bin/testem_gcc';

param = [];%[1:13];
values =[0.70 0.85 1.15 1.30];
cellType = 3;
cores=1;
dt = 0.02;
step_save=5;
%[s]=rmdir(Model,'s');
Imax = 100;
Istep = 0.1;
Idur = 1;
Cai_ind = 1;

CL = 1000;
nCLs = 100;

SensitivityAnalysis(cores, pathToSave, mainElvira,cellType, param, values, dt,...
             step_save, Imax, Istep, Idur, CL, nCLs, Cai_ind)

CL = 500;
nCLs = 200;

SensitivityAnalysis(cores, pathToSave, mainElvira,cellType, param, values, dt,...
             step_save, Imax, Istep, Idur, CL, nCLs, Cai_ind)

CL = 333;
nCLs = 300;

SensitivityAnalysis(cores, pathToSave, mainElvira,cellType, param, values, dt,...
             step_save, Imax, Istep, Idur, CL, nCLs, Cai_ind)

CL = 250;
nCLs = 400;

SensitivityAnalysis(cores, pathToSave, mainElvira,cellType, param, values, dt,...
             step_save, Imax, Istep, Idur, CL, nCLs, Cai_ind)

CL = 125;
nCLs = 800;

SensitivityAnalysis(cores, pathToSave, mainElvira,cellType, param, values, dt,...
             step_save, Imax, Istep, Idur, CL, nCLs, Cai_ind)


exit
