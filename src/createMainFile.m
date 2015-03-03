function createMainFile(pathToSave,fileName,cellType,param,values,duration,dt,dt_post,stimulus)

f=fopen([pathToSave '/data/' fileName '.dat'],'w');

fprintf(f,'#MODEL\n');
fprintf(f,[num2str(cellType) '\n']);
fprintf(f,'#CAPACITANCE\n');
fprintf(f,'1.0\n');
if(length(param)>0)
  fprintf(f,'#PARAMETERS\n');
  fprintf(f,[num2str(param) ' ']);
  for i=1:length(param)
    fprintf(f,[num2str(param(i)) ' ']);
  end
  for i=1:length(value)
    fprintf(f,[num2str(value(i)) ' ']);
  end
  fprintf(f,'\n');
end
fprintf(f,'#STEP\n');
fprintf(f,['0.0 ' num2str(dt) ' ' num2str(duration) '\n']);
fprintf(f,'#STIMULUS\n');
fprintf(f,[num2str(length(stimulus)) '\n']);
for i=1:length(stimulus)
  fprintf(f,[num2str(stimulus{i}.ini) ' ' num2str(stimulus{i}.CL) ' ' num2str(stimulus{i}.dur) ' ' num2str(stimulus{i}.Istim) '\n']);
end
fprintf(f,'#POST\n');
fprintf(f,['0 ' num2str(round(dt_post/dt)) '\n']);
fprintf(f,'#END\n');
fclose(f);
