function simulateAPDRateAdaptation(pathToSave, cellType, param, values, CL, nCLs, Idur, dt, step_save)


initialPath=pwd();
sim_stat = load([pathToSave '/status.mat']);
stimulus{1}.ini = 0;
stimulus{1}.CL = CL(1);
stimulus{1}.dur = Idur;
stimulus{1}.Istim = sim_stat.IStim;
stimulus{2}.ini = nCLs(1)*CL(1);
stimulus{2}.CL = CL(2);
stimulus{2}.dur = Idur;
stimulus{2}.Istim = sim_stat.IStim;

if(isempty(dir([pathToSave '/APDRate'])))
  mkdir([pathToSave '/APDRate'])
  copyfile([pathToSave '/base'],[pathToSave '/APDRate/base'])
end

pathAPDRate  = [pathToSave '/APDRate'];


if(isempty(dir([pathAPDRate '/control'])))

    copyfile([pathAPDRate '/base'],[pathAPDRate '/control'])
    createMainFile([pathAPDRate '/control'],'main_file_APDRate',cellType,[],[],sum(CL.*nCLs),dt,step_save,stimulus,false);

    cd([pathAPDRate '/control']);
    ! ./runtestem data/main_file_APDRate.dat post/APDRate
end

a=load([pathAPDRate '/control/post/APDRate_stat.dat']);
dt_results = a(2,end)-a(1,end);
V=a(:,end-1);
[APD90, APD_time] = calculateAPD(V,dt_results,0.90);

sim_stat.('APDRate').control.APD90 = APD90;
save([pathToSave '/status.mat'],'-struct','sim_stat');
    

    
for i=1:length(param)

  pathParam = [pathAPDRate '/P_' num2str(param(i))];

  if(isempty(dir(pathParam)))
    mkdir(pathParam)
    copyfile([pathAPDRate '/base'],[pathParam '/base'])
  end

  parfor j=1:length(values)
    pathValue = [pathParam '/V_' num2str(values(j))];

    if(isempty(dir(pathValue)))
      copyfile([pathParam '/base'],pathValue)
      createMainFile(pathValue,'main_file_APDRate',cellType,param(i),values(j),sum(CL.*nCLs),dt,step_save,stimulus,false);

      cd(pathValue);
      ! ./runtestem data/main_file_APDRate.dat post/APDRate
    end 
  end
end

for i=1:length(param)

  pathParam = [pathAPDRate '/P_' num2str(param(i))]

  for j=1:length(values)
    pathValue = [pathParam '/V_' num2str(values(j))] 
    a=load([pathValue '/post/APDRate_stat.dat']);
    dt_results = a(2,end)-a(1,end);
    V=a(:,end-1);
    [APD90,APD_time]= calculateAPD(V,dt_results,0.90);
    
    sim_stat.('APDRate').variations.APD90{i,j} = APD90;

  end
end


save([pathToSave '/status.mat'],'-struct','sim_stat');

cd(initialPath)
