% Clear workspace
clc
clear all
close all

% Injection cycle
inj = 30;
% Nuking cycle
nuke = 53;

% Excel Data
data_table = readtable("Full System (k = 1e6).xlsx", Sheet= 'Analysis_Take3', Range = 'J2:BQ120');
data = table2array(data_table).';

% Separate into samples
sampleX1 = data(4,:);
sampleX2 = data(16,:);
sampleX3 = data(28,:);
sampleX4 = data(40,:);
sampleX5 = data(52,:);

% Record time count from Excel data
t_table = readtable("Full System (k = 1e6).xlsx", Sheet = 'Analysis_Take3', Range = 'B2:B120');
t = table2array(t_table).';


totaldata = [sampleX1; sampleX2; sampleX3; sampleX4; sampleX5];

% If any values in the dataset are below 0, set them to 0
for i = 1:length(totaldata(:,1))
    for k = 1:length(totaldata(1,:))
        if totaldata(i,k) < 0
            totaldata(i,k) = 0;
        end
    end
end

% Loop through samples
for i = 1:length(totaldata(:,1)) 
    % Define time points and data in between injection and nuking
    time = t(inj:nuke);
    
    % Define concentration values from injection to nuking
    conc = totaldata(i,inj:nuke);
    
    % Define final concentration value (after nuking) to represent intial
    % concentration of FQ
    conc_end = totaldata(i,end);

    % Initial parameter guesses and set upper/lower limits
    params_zero = [1e-3, conc(end)];
    lb = [0, 0];
    ub = [1e-1, 11];

    % Set optimization options for lsqcurvefit
    options = optimoptions('lsqcurvefit','Display','iter','Algorithm','trust-region-reflective');
    
    % Create function handle that depends only on params and time with solve_ode
    ode_fit_function = @(params, time) solve_ode(params, conc_end,time, conc(1));
    
    % Run parameter fitting - minimises the sum of squared differences
    % between y_model (from solve_ode) and measured concentrations (conc)
    params_opt(i,:) = lsqcurvefit(ode_fit_function, params_zero, time, conc, lb, ub, options);
    
    % Convert rate constant from nM^(-1)s^(-1) to M^(-1)s^(-1)
    params_opt(i,1) = params_opt(i,1)*10^9;
end

% Record average rate constant 
k_avg = mean(params_opt(:,1));


function y_model = solve_ode(params, y_end, x_data, y_zero)
% Function to pass parameters into ode45 and return a model    
    
    % Define Rate Constant (k) as first element of params vector
    k = params(1);
    % Define final GX concentration (b) as second element of params vector
    b = params(2);

    % Pass ODE through ode45
    [x_sol, y_sol] = ode45(@(x,y) k*(b-y)*(y_end - y),x_data,y_zero);
    % Interpolate between values to create a model
    y_model = interp1(x_sol, y_sol,x_data,'linear');
end