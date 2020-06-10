user = csvread('my_user.csv');
valid = user(1:10);

%Fixed Parameters
nvars = 1682;
lb = ones(1,1682);
ub = 5*ones(1,1682);
EliteCount_Data = 1;
MaxGenerations_Data = 100;
iterations = 10;
FunctionTolerance_Data = 1e-3;

%Initialization of scores
scores = zeros(1,iterations);
mae = zeros(1,iterations);
rmse = zeros(1,iterations);

%Setting best ga parameters 
CrossoverFraction_Data = 0.6;
MutationFactor = 0.01;
PopulationSize_Data = 200;

max_score = -1;
sum_generations = 0;
for i=1:iterations
    display(i);
    [x,fval,exitflag,output,population,score] = genetic_algorithm(nvars,lb,ub,PopulationSize_Data,EliteCount_Data,FunctionTolerance_Data,CrossoverFraction_Data,MaxGenerations_Data,MutationFactor);
    mean_score = mean(score);
    scores(i) = -mean_score;
    
    if scores(i) > max_score    %Save the best individuals graph and score
        max_score = scores(i);
        saveas(gcf,num2str(i), 'jpg');      
    end
  
    close
    sum_generations = sum_generations + output.generations;
    
    prediction = x(1:10);
    mae(i)= mean(abs(prediction-valid));
    rmse(i)= sqrt(mean((prediction - valid).^2));
end

%Calculating Scores
best_score = max(scores);
mean_gen = sum_generations/iterations;