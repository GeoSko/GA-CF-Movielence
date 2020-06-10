function Y = fitness_neighbors(X)

%Y = fitness value
%X = variable vector (1xn)
neighbors = csvread('10neighbors.csv');
%Solve the following optimisation ploblem.
%corr(user,X)
len = size(neighbors,1);
corr_sum = 0;

for i = 1:len
    pearson = corrcoef(X,neighbors(i,:));
    corr_sum = corr_sum + pearson(2);
end

%We take the negative correlation to minimize it, so we maximize the
%positive correlation
Y = -mean(-corr_sum)/len;

%-Y

end
