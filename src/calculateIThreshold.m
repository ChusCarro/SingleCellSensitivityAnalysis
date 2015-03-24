function [conduction,IThreshold,IStim] = calculateIThreshold(pathToSave, cellType, Imax, IStep, dt, step_save)

initialPath=pwd();
conduction =false;
IThreshold = [];
IStim = [];

stimulus{1}.ini = 0;
stimulus{1}.CL = 1000;
stimulus{1}.dur = 1;

file = dir([pathToSave '/status.mat']);

if(isempty(dir([pathToSave '/Istim'])))
  mkdir([pathToSave '/Istim'])
end

if(~isempty(file))
    sim_stat = load([pathToSave '/status.mat']);
else
    sim_stat = struct();
end

if(~isfield(sim_stat,'conduction'))
    sim_stat.conduction = false;
else
    conduction=sim_stat.conduction;
end

if(~isfield(sim_stat,'IStep'))
    sim_stat.IStep = IStep;
else if(sim_stat.IStep ~= IStep)
        warning(0,'Different IStep from previous simulations. It''s necessary to implement the modification of the names')
     end
end


if(~isfield(sim_stat,'minIStim'))
    sim_stat.minIStim = 0;
end

if(~isfield(sim_stat,'maxIStim'))
    if(sim_stat.minIStim>=Imax)
        save([pathToSave '/status.mat'],'-struct','sim_stat');
        return;
    end

    Istim_str = ['Istim/Istim_' num2str(Imax)];
    if(~isempty(dir([pathToSave '/' Istim_str])))
        rmdir([pathToSave '/' Istim_str],'s')
    end
    copyfile([pathToSave '/base'],[pathToSave '/' Istim_str])
    stimulus{1}.Istim = Imax;

    createMainFile([pathToSave '/' Istim_str],'main_file_IThreshold',cellType,[],[],5000,dt,step_save,stimulus);

    cd([pathToSave '/' Istim_str]);
    ! ./runtestem data/main_file_IThreshold.dat post/IThreshold
    a=load('post/IThreshold_stat.dat');
    dt_results = a(2,end)-a(1,end);
    V=a(:,end-1);
    cond = testConduction(V,dt_results,5);
    
    if(cond)
       sim_stat.maxIStim=Imax;
       sim_stat.conduction=true;
       conduction = true;
    else
       sim_stat.conduction=false;
       sim_stat.minIStim=Imax;
    end
else
    sim_stat.conduction=true;
    conduction = true;
end

save([pathToSave '/status.mat'],'-struct','sim_stat');

if(~sim_stat.conduction)
    return;
end

while(sim_stat.maxIStim-sim_stat.minIStim-sim_stat.IStep>1e-3)
    Istim = round((sim_stat.maxIStim+sim_stat.minIStim)/2/sim_stat.IStep)*sim_stat.IStep;
    Istim_str = ['Istim/Istim_' num2str(Istim)];
    if(~isempty(dir([pathToSave '/' Istim_str])))
        rmdir([pathToSave '/' Istim_str],'s')
    end
    copyfile([pathToSave '/base'],[pathToSave '/' Istim_str])
    
    stimulus{1}.Istim = Istim;
    createMainFile([pathToSave '/' Istim_str],'main_file_IThreshold',cellType,[],[],5000,dt,step_save,stimulus);

    cd([pathToSave '/' Istim_str])
     ! ./runtestem data/main_file_IThreshold.dat post/IThreshold
    a=load('post/IThreshold_stat.dat');
    dt_results = a(2,end)-a(1,end);
    V=a(:,end-1);
    cond = testConduction(V,dt_results,5);


    if(cond)
       sim_stat.maxIStim=Istim;
    else
       sim_stat.minIStim=Istim;
    end

    save([pathToSave '/status.mat'],'-struct','sim_stat');

end

cd(initialPath)
sim_stat.IThreshold = sim_stat.maxIStim;
IThreshold = sim_stat.maxIStim;
sim_stat.IStim = sim_stat.IThreshold * 2;
IStim = sim_stat.IThreshold * 2;

save([pathToSave '/status.mat'],'-struct','sim_stat');
