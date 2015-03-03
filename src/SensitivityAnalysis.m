function SensitivityAnalysis(cores, pathToSave, mainTestEM, project, cellType, param, values, dt, step_save,...
                       Imax, Istep, CL, nCLs)

%matlabpool(cores)

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

%[conduction, IThreshold, Istim] = calculateIThreshold(pathToSave, Imax, Istep, dt,project)

%simulateSteadyState(pathToSave,param,values,length(nodes),CL,nCLs,dt,project);

%matlabpool close;
