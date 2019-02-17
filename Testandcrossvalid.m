%initialization
clear ; close all; clc

%Load data

load ('problem1.mat')

%plotting original data 
plot(x,y,'rx');

hold on;
% Labels
xlabel('x')
ylabel('y')


% Initialize fitting parameters to plot data for different degree d
err = [];
model=[]; 
trainerror = [];
testerror = [];
%model = [];

% partition of data in 2 halves 

I = crossvalind('Kfold',500,2);
xtr = x(I==1);
ytr = y(I==1);
xte = x(I == 2);
yte = y(I ==2);

for d = 1:50
    [trainerror(d),model,testerror(d)] = polyreg(xtr,ytr,d,xte,yte);
    %title(sprintf('d_=_%d',d));
end

clf;
hold on;

plot(testerror,'b');
plot(trainerror,'r');
[n,mini] = min(testerror);
plot(mini,testerror(mini),'bx');
xlabel('degreeOfPolynomial');
ylabel('error');
legend('test','train');
title('testerror and trainerror');
%print('plot.png','-dpng');