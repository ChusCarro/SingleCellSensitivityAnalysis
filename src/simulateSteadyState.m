function simulateSteadyState(pathToSave, cellType, param, values, CL, nCLs, Cai_ind, dt, step_save)

Cai_ind

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
    createMainFile([pathSS '/control'],'main_file_SS',cellType,[],[],CL*nCLs,dt,step_save,stimulus,true);

    cd([pathSS '/control']);
    ! ./runtestem data/main_file_SS.dat post/SS
end

a=load([pathSS '/control/post/SS_stat.dat']);
dt_results = a(2,end)-a(1,end);
V=a(:,end-1);
Cai=a(:,Cai_ind);
[APD90, APD_time] = calculateAPD(V,dt_results,0.90);
APD75 = calculateAPD(V,dt_results,0.75);
APD50 = calculateAPD(V,dt_results,0.50);
APD25 = calculateAPD(V,dt_results,0.25);
APD10 = calculateAPD(V,dt_results,0.10);
Trian = APD90-APD50;
Diastolic = calculateDiastolic(Cai,dt_results);
Systolic = calculateSystolic(Cai,dt_results);
maxV = max(V);
minV = min(V);
maxdVdt = max(diff(V)/dt_results);
mindVdt = min(diff(V)/dt_results);

sim_stat.(['SS' num2str(CL)]).control.APD90 = APD90;
sim_stat.(['SS' num2str(CL)]).control.APD75 = APD75;
sim_stat.(['SS' num2str(CL)]).control.APD50 = APD50;
sim_stat.(['SS' num2str(CL)]).control.APD25 = APD25;
sim_stat.(['SS' num2str(CL)]).control.APD10 = APD10;
sim_stat.(['SS' num2str(CL)]).control.APD_time = APD_time;
sim_stat.(['SS' num2str(CL)]).control.Trian = Trian;
sim_stat.(['SS' num2str(CL)]).control.Diastolic = Diastolic;
sim_stat.(['SS' num2str(CL)]).control.Systolic = Systolic;
sim_stat.(['SS' num2str(CL)]).control.maxV = maxV;
sim_stat.(['SS' num2str(CL)]).control.minV = minV;
sim_stat.(['SS' num2str(CL)]).control.maxdVdt = maxdVdt;
sim_stat.(['SS' num2str(CL)]).control.mindVdt = mindVdt;
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
      createMainFile(pathValue,'main_file_SS',cellType,param(i),values(j),CL*nCLs,dt,step_save,stimulus,true);

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
    Cai=a(:,Cai_ind);
    [APD90,APD_time]= calculateAPD(V,dt_results,0.90);
    APD75 = calculateAPD(V,dt_results,0.75);
    APD50 = calculateAPD(V,dt_results,0.50);
    APD25 = calculateAPD(V,dt_results,0.25);
    APD10 = calculateAPD(V,dt_results,0.10);
    Trian = APD90 - APD50;
    Diastolic = calculateDiastolic(Cai,dt_results);
    Systolic = calculateSystolic(Cai,dt_results);
    maxV = max(V);
    minV = min(V);
    maxdVdt = max(diff(V)/dt_results);
    mindVdt = min(diff(V)/dt_results);
 
    sim_stat.(['SS' num2str(CL)]).variations.APD90{i,j} = APD90;
    sim_stat.(['SS' num2str(CL)]).variations.APD75{i,j} = APD75;
    sim_stat.(['SS' num2str(CL)]).variations.APD50{i,j} = APD50;
    sim_stat.(['SS' num2str(CL)]).variations.APD25{i,j} = APD25;
    sim_stat.(['SS' num2str(CL)]).variations.APD10{i,j} = APD10;
    sim_stat.(['SS' num2str(CL)]).variations.APD_time{i,j} = APD_time;
    sim_stat.(['SS' num2str(CL)]).variations.Trian{i,j} = Trian;
    sim_stat.(['SS' num2str(CL)]).variations.Diastolic{i,j} = Diastolic;
    sim_stat.(['SS' num2str(CL)]).variations.Systolic{i,j} = Systolic;
    sim_stat.(['SS' num2str(CL)]).variations.maxV{i,j} = maxV;
    sim_stat.(['SS' num2str(CL)]).variations.minV{i,j} = minV;
    sim_stat.(['SS' num2str(CL)]).variations.maxdVdt{i,j} = maxdVdt;
    sim_stat.(['SS' num2str(CL)]).variations.mindVdt{i,j} = mindVdt;

  end
end


save([pathToSave '/status.mat'],'-struct','sim_stat');

cd(initialPath)
