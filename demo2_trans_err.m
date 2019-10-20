%clear all
tol = 1e-5;
n = 10;
p = 10;
iter = 1000;
x0 = rand(n,p);
i = ones(n,1)*sum(x0)/n;

alpha = 1.0;
method = 'NIDS';
c = 1.0;
W = generateW(n, 0.5);

%generate cell showing where transmission errors occur
%chance for each node in each iteration
err_chance = 0.05;

nids = NIDS_trans_err;
paras.tol       = tol;
paras.n         = n; 
paras.p         = p;
paras.x_star    = i;
paras.iter      = iter;
paras.x0        = x0;
paras.alpha     = alpha;
paras.method    = method;
paras.c         = c;
paras.W         = W;
paras.err_chance = err_chance;
result = nids.minimize(paras);