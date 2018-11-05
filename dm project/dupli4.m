
numberofusers = 1200; 
numberofmovies=700;
userstars = zeros(1200, 1);

movie_list = cell(1200, 1);
totalfeatures = 18;


for i=1:numberofusers
  userstars(i)=floor(rand(1)*5);
end
mm = fopen('movies.txt');
load('movieratings.mat');


for i = 1:numberofusers
    line=fgets(mm);
    [index, movie_name] = strtok(line, ' ');
    movie_list{i} = strtrim(movie_name);
end




predefineduserratingvalues=Y(1:1200,1:700);
predefineduserratingcheck=R(1:1200,1:700);



predefineduserratingvalues = [userstars predefineduserratingvalues];
predefineduserratingcheck = [(userstars ~= 0) predefineduserratingcheck];


predefineduserratingvaluesmean = zeros(numberofmovies, 1);
predefineduserratingvaluesnorm = zeros(size(predefineduserratingvalues));


moviematrix = randn(numberofmovies, totalfeatures);
usermatrix = randn(numberofusers, totalfeatures);


for i = 1:numberofmovies
    predefineduserratingvaluesmean(i) = mean(predefineduserratingvalues(i, predefineduserratingcheck(i, :)));
    predefineduserratingvaluesnorm(i, predefineduserratingcheck(i, :)) = predefineduserratingvalues(i, predefineduserratingcheck(i, :)) - predefineduserratingvaluesmean(i);
end



options = optimset('GradObj', 'on', 'MaxIter', 200);


roll = [moviematrix(:); usermatrix(:)];



theta = fmincg (@(t)(costfun(t)),roll, options);


moviematrix = reshape(theta(1:numberofmovies*totalfeatures), numberofmovies, totalfeatures);
usermatrix = reshape(theta(numberofmovies*totalfeatures+1:end),numberofusers, totalfeatures);


fprintf('ratings given by user:\n');
for i = 1:length(userstars)
    if userstars(i) > 0 
        fprintf('Movie:  %s \t\t ratings:%d\n', movie_list{i},userstars(i));
    end
end

fprintf('finish recommender system learning \n');
fprintf(' movies that are recommended are \n');



predictionsforuser = (moviematrix * usermatrix')(:,1) + predefineduserratingvaluesmean;

[temp, indexes] = sort(predictionsforuser, 'descend');


fprintf('\n\nTop 25 recommended movies\n\n');
for i=1:25
    fprintf('Movie:  %s \t\t ratings :%d\n',movie_list{indexes(i)}, predictionsforuser(indexes(i)));
end

fprintf('\nTop 26-50 recommended movies\n');
for i=26:50
    fprintf('Movie: %s \t\t ratings: %d\n',movie_list{indexes(i)}, predictionsforuser(indexes(i)));
end


