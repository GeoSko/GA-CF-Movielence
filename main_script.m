%Fixed Parameters
nvars = 1682;
lb = ones(1,1682);
ub = 5*ones(1,1682);
EliteCount_Data = 1;
MaxGenerations_Data = 100;
iterations = 10;
FunctionTolerance_Data = 1e-3;
num_tests = 9;

%Initialize scores
scores = zeros(1,iterations);
best_score = zeros(1,num_tests);
mean_gen = zeros(1,num_tests);

%Algorithm changable parameters for testing
cross_poss = [0.6 0.6  0.6 0.9  0.1  0.6 0.6  0.1  0.9 ];
mut_pos =    [0   0.01 0.1 0.01 0.01 0   0.01 0.01 0.01];
pop_size =   [20  20   20  20   20   200 200  200  200 ];


for test=1:num_tests
    %Changing the GA parameters according to the test changable parameters
    CrossoverFraction_Data = cross_poss(test);
    MutationFactor = mut_pos(test);
    PopulationSize_Data = pop_size(test);
    
    %Changing the file name according to the parameters
    file_name = strcat('cross',num2str(CrossoverFraction_Data),'_mut',num2str(MutationFactor),'_pop',num2str(PopulationSize_Data));
    max_score = -1;
    sum_generations = 0;
    for i=1:iterations   %Many iterations of algorithm due to stochastic nature
        [x,fval,exitflag,output,population,score] = genetic_algorithm(nvars,lb,ub,PopulationSize_Data,EliteCount_Data,FunctionTolerance_Data,CrossoverFraction_Data,MaxGenerations_Data,MutationFactor);
        mean_score = mean(score);
        scores(i) = -mean_score;

        if scores(i) > max_score    %Save the best individuals graph and score
            max_score = scores(i);
            saveas(gcf,file_name, 'jpg');
        end
        close
        sum_generations = sum_generations + output.generations;
    end
    
    %Calculating Scores
    best_score(test) = max(scores);
    mean_gen(test) = sum_generations/iterations;

end    
