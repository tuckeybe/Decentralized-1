clear all
tol = 1e-5;
n = 5;
p = 5;
iter = 1000;
x0 = rand(n,p);
i = ones(n,1)*sum(x0)/n;


alpha = 1.0;
method = 'NIDS';

%nids = NIDSmini(tol, n, p, i, iter, x0, alpha, method, W);


%%% Grabbed code from website
%{
your_cell = cell(8,1);
%Generating data and storing it in a cell array
your_cell{1} = [1/3 1/3 0 0 1/3; 1/3 1/3 1/3 0 0; 0 1/3 1/3 1/3 0; 0 0 1/3 1/3 1/3; 1/3 0 0 1/3 1/3];
your_cell{2} = [2/3 0 0 0 1/3; 0 1/3 1/3 0 0; 0 1/3 1/3 1/3 0; 0 0 1/3 1/3 1/3; 1/3 0 0 1/3 1/3];
your_cell{3} = [1/3 1/3 0 0 1/3; 1/3 2/3 0 0 0; 0 0 1/3 1/3 0; 0 0 1/3 1/3 1/3; 1/3 0 0 1/3 1/3];
your_cell{4} = [1/3 1/3 0 0 1/3; 1/3 1/3 1/3 0 0; 0 1/3 2/3 0 0; 0 0 0 1/3 1/3; 1/3 0 0 1/3 1/3];
your_cell{5} = [1/3 1/3 0 0 1/3; 1/3 1/3 1/3 0 0; 0 1/3 1/3 1/3 0; 0 0 1/3 2/3 0; 1/3 0 0 0 1/3];
your_cell{6} = [1/3 1/3 0 0 0; 1/3 1/3 1/3 0 0; 0 1/3 1/3 1/3 0; 0 0 1/3 1/3 1/3; 0 0 0 1/3 2/3];
your_cell{7} = [0.2 0.2 0.2 0.2 0.2; 0.2 0.2 0.2 0.2 0.2; 0.2 0.2 0.2 0.2 0.2; 0.2 0.2 0.2 0.2 0.2; 0.2 0.2 0.2 0.2 0.2];
your_cell{8} = [1/3 1/3 0 0 1/3; 1/3 1/3 1/3 0 0; 0 1/3 1/3 1/3 0; 0 0 1/3 1/3 1/3; 1/3 0 0 1/3 1/3];
%}
your_cell = new_matrix(n);
times = [0, 10, 11, 12, 13, 14, 15, 25];
%%%


wshift = NIDS_initTest;
paras.tol       = tol;
paras.n         = n; 
paras.p         = p;
paras.x_star    = i;
paras.iter      = iter;
paras.x0        = x0;
paras.alpha     = alpha;
paras.method    = method;
paras.c         = 1.0;
paras.Wl        = your_cell;
paras.times     = times;

result = wshift.minimize(paras);