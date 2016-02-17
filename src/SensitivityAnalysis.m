function SensitivityAnalysis(cores, pathToSave, mainTestEM, cellType, param, values, dt, step_save,...
                       Imax, Istep, Idur, CL, nCLs, Cai_ind)

matlabpool(cores)

[SUCCESS,MESSAGE] = mkdir(pathToSave);

if(SUCCESS==0)
    error([pathToSave ' directory can''t be created: ' MESSAGE])
end

if(isempty(dir([pathToSave '/base'])))
    mkdir([pathToSave '/base'])
    mkdir([pathToSave '/base/data'])
    mkdir([pathToSave '/base/post'])
    createRunTestEM([pathToSave '/base'],mainTestEM)
end

Param_str = cell(length(param));

[conduction, IThreshold, Istim] = calculateIThreshold(pathToSave, cellType, Imax, Istep, Idur, dt, step_save)

simulateSteadyState(pathToSave,cellType,param,values,CL,nCLs,Cai_ind,Idur,dt,step_save);
simulateAPDRateAdaptation(pathToSave, cellType, param, values, [1000 600], [100 100], Idur, dt, step_save)

matlabpool close;
