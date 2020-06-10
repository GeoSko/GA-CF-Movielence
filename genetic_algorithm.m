function [x,fval,exitflag,output,population,score] = genetic_algorithm(nvars,lb,ub,PopulationSize_Data,EliteCount_Data,FunctionTolerance_Data,CrossoverFraction_Data,MaxGenerations_Data,MutationFactor)
%% This is an auto generated MATLAB file from Optimization Tool.

%% Start with the default options
options = optimoptions('ga');
%% Modify options setting
options = optimoptions(options,'PopulationSize', PopulationSize_Data);
options = optimoptions(options,'EliteCount', EliteCount_Data);
options = optimoptions(options,'CrossoverFraction', CrossoverFraction_Data);
options = optimoptions(options,'MaxGenerations', MaxGenerations_Data);
options = optimoptions(options,'NonlinearConstraintAlgorithm', 'penalty');
options = optimoptions(options,'CreationFcn', @gacreationuniform);
options = optimoptions(options,'SelectionFcn', @selectionroulette);
options = optimoptions(options,'CrossoverFcn', @crossovertwopoint);
options = optimoptions(options,'MutationFcn', {  @mutationuniform MutationFactor });
options = optimoptions(options,'FunctionTolerance', FunctionTolerance_Data);
options = optimoptions(options,'Display', 'final');
options = optimoptions(options,'PlotFcn', { @gaplotbestf });
[x,fval,exitflag,output,population,score] = ...
ga(@fitness_neighbors,nvars,[],[],[],[],lb,ub,[],[],options);
