clear all
global n p M y_ori

%import housing data
%copied from mathworks website
filename = 'housing.txt';
urlwrite('http://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.data',filename);
inputNames = {'CRIM','ZN','INDUS','CHAS','NOX','RM','AGE','DIS','RAD','TAX','PTRATIO','B','LSTAT'};
outputNames = {'MEDV'};
housingAttributes = [inputNames,outputNames];

formatSpec = '%8f%7f%8f%3f%8f%8f%7f%8f%4f%7f%7f%7f%7f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '',  'ReturnOnError', false);
fclose(fileID);
housing = table(dataArray{1:end-1}, 'VariableNames', {'CRIM','ZN','INDUS','CHAS','NOX','RM','AGE','DIS','RAD','TAX','PTRATIO','B','LSTAT','MEDV'});
housing = table2array(housing);

clearvars filename formatSpec fileID dataArray ans;
delete housing.txt


%generate M and y_ori from housing data
perm = randperm(506, 500);

M = zeros(40, 14, 10);
M(:,1,:) = ones(40, 1, 10);
y_ori = zeros(40, 10);

for i = 1:10
    for ii = 1:40
        M(ii, 2:14, i) = housing(perm(ii + 40*(i-1)), 1:13);
        y_ori(ii, i) = housing(perm(ii + 40*(i-1)), 14);
    end
end

%[M, x_ori, y_ori] = generateS(m, p, n, 'withoutNonsmoothR',min_mu,max_Lips);


%nids = NIDSmini(tol, n, p, i, iter, x0, alpha, method, W);

n = 10;
p = 14;
tol = 1e-5;
iter = 1000;
x0 = zeros(n, p);
alpha = 1.0;
method = "NIDS";

m = 40;
min_mu = 0.5;
max_Lips = 1;
x_star  = x0;     % we do not know true soln, pass in zeros


%diverges even with fully connected W
your_cell = cell(1, 1);
your_cell{1} = ones(n,n);
times = (0);

%{
your_cell = cell(2*n+3,1);

v = zeros(1, n);
v(1) = 1/3;
v(2) = 1/3;
v(n) = 1/3;

%Generating matrices with for loop
your_cell{1} = toeplitz(v);
for i = 1:n
    your_cell_new = your_cell{1};
    j = 1 + mod(i, n);
    your_cell_new(i, i) = 2/3;
    your_cell_new(j, j) = 2/3;
    your_cell_new(i, j) = 0;
    your_cell_new(j, i) = 0;
    your_cell{i+1} = your_cell_new;
    your_cell{n+i+1} = your_cell_new;
end
your_cell{2*n+2} = ones(n,n) / n;
your_cell{2*n+3} = your_cell{1};

%Generating times
times = zeros(1, 2*n+3);
for i = 1:2*n
    times(1+i) = 9+i;
end
times(2*n+2) = 10+2*n;
times(2*n+3) = 20+2*n;
%}



% Set the parameter for the solver
paras.min_mu    = min_mu;
paras.max_Lips  = max_Lips;
paras.tol       = tol;
paras.n         = n; 
paras.p         = p;
paras.x_star    = x_star;
paras.iter      = iter;
paras.x0        = x0;
paras.alpha     = alpha;
paras.method    = method;
paras.c         = 1.0;
paras.Wl        = your_cell;
paras.times     = times;

obj = NIDS_initTest;
obj.getS       = @(x) feval(@funS, x);
obj.getGradS   = @(x) feval(@funGradS, x);

funGradS(zeros(n,p))
result = obj.minimize(paras);

function a = funGradS(x)
global n p M y_ori
a = zeros(n, p);
for j = 1:n
    a(j,:) = (M(:,:,j)' * (M(:,:,j) * (x(j,:))' - y_ori(:,j)))';
end
end

function a = funS(x)
global n M y_ori
a = 0;
for j = 1:n
    a   = a + 0.5 * sum((M(:,:,j) * (x(j,:))' - y_ori(:,j)).^2);
end
end
