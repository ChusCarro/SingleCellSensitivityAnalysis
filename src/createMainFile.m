function createMainFile(pathToSave,fileName,cellType,param,values,duration,dt,step_save,stimulus,last)

f=fopen([pathToSave '/data/' fileName '.dat'],'w');

fprintf(f,'#MODEL\n');
fprintf(f,[num2str(cellType) '\n']);
fprintf(f,'#CAPACITANCE\n');
fprintf(f,'1.0\n');
if(length(param)>0)
  fprintf(f,'#PARAMETERS\n');
  fprintf(f,[num2str(length(param)) ' ']);
  for i=1:length(param)
    fprintf(f,[num2str(param(i)) ' ']);
  end
  for i=1:length(values)
    fprintf(f,[num2str(values(i)) ' ']);
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
if(last)
fprintf(f,[num2str((duration-stimulus{length(stimulus)}.CL)/dt) ' ' num2str(step_save) '\n']);
else
fprintf(f,['0 ' num2str(step_save) '\n']);
end
fprintf(f,'#END\n');
fclose(f);
