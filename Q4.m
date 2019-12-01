redWine = readtable('winequality-red.csv', 'ReadVariableNames', true);
redData = table2array(redWine);
redDataX = redData(:, 1:11);
redY = redData(:,12);

% Find Optimal leaf size
leaf = [1 5 10 20 50 100];
col = 'rgbcmy';
figure
for i=1:length(leaf)
    b = TreeBagger(50,redDataX,redY,'method','r','oobpred','on','cat',1:11,'minleaf',leaf(i));
    plot(oobError(b),col(i));
    hold on;
end
xlabel('Number of Grown Trees');
ylabel('Mean Squared Error');
legend({'1' '5' '10' '20' '50' '100'},'Location','NorthEast');
hold off;

% find optimal number of trees
b = TreeBagger(50,redDataX,redY,'oobvarimp','on');
figure
plot(oobError(b));
xlabel('Number of Grown Trees');
ylabel('Out-of-Bag Classification Error');

figure
bar(b.OOBPermutedVarDeltaError);
xlabel('Feature Number');
ylabel('Out-Of-Bag Feature Importance');
idxvar = find(b.OOBPermutedVarDeltaError>0.7);
