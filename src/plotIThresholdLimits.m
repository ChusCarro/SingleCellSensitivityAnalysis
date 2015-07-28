function plotIThresholdLimits(pathToSave)

close all;


if(~isempty(dir([pathToSave '/status.mat'])))
    sim_stat = load([pathToSave '/status.mat']);

    if(isfield(sim_stat,'minIStim') && isfield(sim_stat,'maxIStim'))
        minIStim=sim_stat.minIStim;
        maxIStim=sim_stat.maxIStim;
        IStep = sim_stat.IStep;
        Istim_str = ['Istim/Istim_' num2str(minIStim)];
        a=load([pathToSave '/' Istim_str '/post/IThreshold_stat.dat']);

        f=figure;
        subplot(2,1,1)
        plot(a(:,end),a(:,end-1))
        title(num2str(minIStim))

        Istim_str = ['Istim/Istim_' num2str(maxIStim)];
        a=load([pathToSave '/' Istim_str '/post/IThreshold_stat.dat']);

        subplot(2,1,2)
        plot(a(:,end),a(:,end-1))
        title(num2str(maxIStim))

        saveas(f,[pathToSave '/Istim.pdf'])
    end
end
