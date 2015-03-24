function [APD,APD_time,maxV_v,minV_v] = calculateAPD(V,dt,perc)

minV=V(1);
maxV=Inf;
maxDiff=0.001;
maxDiff_ind = 0;

APD=[];
APD_time = [];
maxV_v=[];
minV_v=[];
APD_n=0;

for i=2:length(V)
    
    if(V(i)-V(i-1)>maxDiff)
        maxDiff=V(i)-V(i-1);
        maxDiff_ind=i;
        if(isinf(maxV))
            maxV = V(i);
        end
    end
    
    if(V(i)>maxV)
        maxV=V(i);
    end
    
    if(V(i)<minV)
        minV=V(i);
    end
    
    if(maxDiff_ind>0)
        nov = maxV - (maxV-minV)*perc;
        if(V(i)<nov)
            APD_n = APD_n +1;
            APD(APD_n) = (i-maxDiff_ind)*dt;
            APD_time(APD_n) = maxDiff_ind*dt;
            maxV_v(APD_n) = maxV;
            minV_v(APD_n) = minV;
            maxDiff_ind=0;
            maxDiff=0.001;
            maxV=Inf;
        end
    end
end
