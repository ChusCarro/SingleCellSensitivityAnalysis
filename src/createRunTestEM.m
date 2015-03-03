function createRunElv(pathToSave,mainTestEM)

f = fopen([pathToSave '/runtestem'],'w');

fprintf(f,'# $1 input data file with full path\n');
fprintf(f,'# $2 output identifier with full path of output directory\n');
fprintf(f,[mainTestEM ' -i $1 -o $2 </dev/null 2>&1\n']);
fclose(f);
fileattrib([pathToSave '/runtestem'],'+x')

