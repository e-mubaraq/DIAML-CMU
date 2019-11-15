whiteWine = readtable('winequality-white.csv');
redWine = readtable('winequality-red.csv');

fAcidW = whiteWine.fixedAcidity;
vAcidW = whiteWine.volatileAcidity;
cAcidW = whiteWine.citricAcid;
rSugarW = whiteWine.residualSugar;
chlorW = whiteWine.chlorides;
fSulfW = whiteWine.freeSulfurDioxide;
tSulfW = whiteWine.totalSulfurDioxide;
densW = whiteWine.density;
pHW = whiteWine.pH;
sulphW = whiteWine.sulphates;
alcW = whiteWine.alcohol;
qualityW = whiteWine.quality;


fAcidR = redWine.fixedAcidity;
vAcidR = redWine.volatileAcidity;
cAcidR = redWine.citricAcid;
rSugarR = redWine.residualSugar;
chlorR = redWine.chlorides;
fSulfR = redWine.freeSulfurDioxide;
tSulfR = redWine.totalSulfurDioxide;
densR = redWine.density;
pHR = redWine.pH;
sulphR = redWine.sulphates;
alcR = redWine.alcohol;
qualityR = redWine.quality;

AvgfAcidW = mean(fAcidW);
AvgvAcidW = mean(vAcidW);
AvgcAcidW = mean(cAcidW);
AvgSugarW = mean(rSugarW);
AvgchlorW = mean(chlorW);
AvgfSulfW = mean(fSulfW);
AvgtSulfW = mean(tSulfW);
AvgdensW = mean(densW);
AvgpHW = mean(pHW);
AvgsulphW = mean(sulphW);
AvgalcW = mean(alcW);
AvgqualityW = mean(qualityW);


AvgfAcidR = mean(fAcidR);
AvgvAcidR = mean(vAcidR);
AvgcAcidR = mean(cAcidR);
AvgSugarR = mean(rSugarR);
AvgchlorR = mean(chlorR);
AvgfSulfR = mean(fSulfR);
AvgtSulfR = mean(tSulfR);
AvgdensR = mean(densR);
AvgpHR = mean(pHR);
AvgsulphR = mean(sulphR);
AvgalcR = mean(alcR);
AvgqualityR = mean(qualityR);


x = categorical({'fixed Acidity'; 'Volatile Acidity'; 'Citric Acid'; 'Residual Sugar'; 'Chlorides';
    'Free Sulfur Dioxides'; 'Total Sulfur Dioxide'; 'Density'; 'pH'; 'Sulphates'; 'Alcohol'; 'Quality' });
Y_wine = [AvgfAcidW AvgfAcidR; AvgvAcidW AvgvAcidR; AvgcAcidW AvgcAcidR; AvgSugarW AvgSugarR; AvgchlorW AvgchlorR; AvgfSulfW AvgfSulfR; 
    AvgtSulfW AvgtSulfR; AvgdensW AvgdensR; AvgpHW AvgpHR; AvgsulphW AvgsulphR; AvgalcW AvgalcR; AvgqualityW AvgqualityR];
bar(x, Y_wine);
legend('White wine','Red wine');

%X_white = table(fAcidW, vAcidW, cAcidW, rSugarW, chlorW, fSulfW,tSulfW, densW, pHW, sulphW, alcW, qualityW);
%X_red = [fAcidR, vAcidR, cAcidR, rSugarR, chlorR, fSulfR, tSulfR, densR, pHR, sulphR, alcR];
%X_red = [fAcidR vAcidR cAcidR rSugarR chlorR fSulfR tSulfR densR pHR sulphR alcR qualityR];
%r_white = corrcoef(X_white);
%r_red = corrcoef(X);

corrcoef(fAcidR , qualityR)










