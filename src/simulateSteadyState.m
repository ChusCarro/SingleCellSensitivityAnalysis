function simulateSteadyState(pathToSave, cellType, param, values, CL, nCLs, dt, step_save)

initialPath=pwd();
sim_stat = load([pathToSave '/status.mat']);
stimulus{1}.ini = 0;
stimulus{1}.CL = CL;
stimulus{1}.dur = 1;
stimulus{1}.Istim = sim_stat.IStim;

if(isempty(dir([pathToSave '/SS' num2str(CL)])))
  mkdir([pathToSave '/SS' num2str(CL)])
  copyfile([pathToSave '/base'],[pathToSave '/SS' num2str(CL) '/base'])
end

pathSS  = [pathToSave '/SS' num2str(CL)];


if(isempty(dir([pathSS '/control'])))

    copyfile([pathSS '/base'],[pathSS '/control'])
    createMainFile([pathSS '/control'],'main_file_SS',cellType,[],[],CL*nCLs,dt,step_save,stimulus);

    cd([pathSS '/control']);
    ! ./runtestem data/main_file_SS.dat post/SS
end

a=load([pathSS '/control/post/SS_stat.dat']);
dt_results = a(2,end)-a(1,end);
V=a(:,end-1);
[APD90,APD_time]= calculateAPD(V,dt_results,0.9);
Trian = APD90-calculateAPD(V,dt_results,0.5);

sim_stat.(['SS' num2str(CL)]).control.APD90 = APD90;
sim_stat.(['SS' num2str(CL)]).control.APD_time = APD_time;
sim_stat.(['SS' num2str(CL)]).control.Trian = Trian;
save([pathToSave '/status.mat'],'-struct','sim_stat');
    

    
for i=1:length(param)

  pathParam = [pathSS '/P_' num2str(param(i))];

  if(isempty(dir(pathParam)))
    mkdir(pathParam)
    copyfile([pathSS '/base'],[pathParam '/base'])
  end

  parfor j=1:length(values)
    pathValue = [pathParam '/V_' num2str(values(j))];

    if(isempty(dir(pathValue)))
      copyfile([pathParam '/base'],pathValue)
      createMainFile(pathValue,'main_file_SS',cellType,param(i),values(j),CL*nCLs,dt,step_save,stimulus);

      cd(pathValue);
      ! ./runtestem data/main_file_SS.dat post/SS
    end 
  end
end

for i=1:length(param)

  pathParam = [pathSS '/P_' num2str(param(i))]

  for j=1:length(values)
    pathValue = [pathParam '/V_' num2str(values(j))] 
    a=load([pathValue '/post/SS_stat.dat']);
    dt_results = a(2,end)-a(1,end);
    V=a(:,end-1);
    [APD90,APD_time]= calculateAPD(V,dt_results,0.9);
    Trian = APD90 - calculateAPD(V,dt_results,0.5);

    sim_stat.(['SS' num2str(CL)]).variations.APD90{i,j} = APD90;
    sim_stat.(['SS' num2str(CL)]).variations.APD_time{i,j} = APD_time;
    sim_stat.(['SS' num2str(CL)]).variations.Trian{i,j} = Trian;

  end
end


save([pathToSave '/status.mat'],'-struct','sim_stat');

cd(initialPath)
