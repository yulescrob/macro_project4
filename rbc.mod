// Endogenous variables
var y, c, k, i, l, y_l, w, r;

// Exogenous variables
varexo z;

//perameters
parameters alpha, beta, delta, psi, rho, epsilon;
alpha = 0.33;
beta = 0.99;
delta = 0.025;
psi = 1.75;
rho = 0.95;
epsilon = 10;

//Model equations
model;
//Euler eq
(1/c) = beta*(1/c(+1))*(1+r(+1)-delta);

//abor-Leisure Condition:
psi*c/(1-l) = w;

//resource constraint
c+i = y;

//production function
y = (k(-1)^alpha)*(exp(z)*l)^(1-alpha);

//real wage
w = y*((epsilon-1)/epsilon)*(1-alpha)/l;

//real int rate
r = y*((epsilon-1)/epsilon)*alpha/k(-1);

//Capital accumulation
i = k-(1-delta)*k(-1);

//output per labor
y_l = y/l;
end;

initval;
k = 9;
c = 0.7;
l = 0.3;
w = 2.0;
r = 0;
z = 0;
end;
steady;//shock  model starting from a steady state value
check; //displays eigenvalues

//temporary shock
shocks;
var z;
periods 1:5;
values 0.1;
end;

//simulation over 100 periods
simul(periods=100);

// Perform the simulation
perfect_foresight_solver;

// Display the path of consumption and capital
rplot c;
rplot y;
rplot k;
rplot l;