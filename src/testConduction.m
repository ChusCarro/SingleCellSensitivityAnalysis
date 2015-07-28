function [conduction, CV, APD90] = testConduction(V,dt,numStim)

conduction = false;

[APD90,APD_time]= calculateAPD(V,dt,0.9);

if(numStim~=length(APD90))
    conduction=false;
    APD90=[];
    return;
end

for i=1:numStim
  if(~isempty(find(APD90(:,i)<150)))
    conduction=false;
    APD90=[];
    return;
  end  
end

conduction = true;
