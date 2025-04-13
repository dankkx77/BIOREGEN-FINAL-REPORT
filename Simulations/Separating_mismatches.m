%% Clear workspace
clc
clear all
close all
format long
 
%% Constants
b = 15;                  % Total branch migration length
m = 2;                   % Incumbent toehold length
k_b = (b/(b-m))^2;        % Branch migration rate constant (s^-1)
R = 1.987e-3;            % Gas constant in kcal/(mol·K)
T = 298.15;               % Temperature in Kelvin
k_f = 3.5e6;              % kf1=kf2=kf (/M/s)
G_beta = -2.7;           % Incumbent toehold binding energy from Table 2 (kcal/mol)
 
% delta_g range
G = -25:0.1:0;
 
% k_rbeta: k_r for incumbent toehold (from equation 1)
k_rbeta = k_f*(2/(b-m))*exp(G_beta/(R*T));

%% Read in data and separate mismatches 

%Read in delta_G values
delta_G_table = readtable("sGi_sX1_sOi_analysis_results.csv", Range = '2K:8441K');
delta_G_col = table2array(delta_G_table);
delta_G = delta_G_col.';

% List of number of mismatches for each delta_G value
no_mism_table = readtable("sGi_sX1_sOi_analysis_results.csv", Range = '2C:8441C');
no_mism_col = table2array(no_mism_table);
no_mism = no_mism_col.';

%Store toehold sequence for each delta_G
toe_seq_table = readtable("sGi_sX1_sOi_analysis_results.csv", Range = '2A:8441A');
toe_seq_col = table2array(toe_seq_table);
toe_seq = toe_seq_col.';


%% Calculating rate constant for delta_g range of -25 kcal/mol to 0 kcal/mol
 
% k_rg: k_r for invader toehold (from equation 1)
k_rgamma = k_f*(2/(b-m))*exp(G./(R*T));
% k: Final rate constant (from equation 2)
k = (k_rbeta*k_f*k_b)./(k_rgamma.*k_rbeta + k_rgamma.*k_b + k_rbeta.*k_b);
 
%% Calculating rate constant for delta_g of mismatches
 
% k_rg: k_r for invader toehold (from equation 1)
k_rgamma_mism = k_f*(2/(b-m))*exp(delta_G./(R*T));
% k: Final rate constant (from equation 2)
k_mism = (k_rbeta*k_f*k_b)./(k_rgamma_mism.*k_rbeta + k_rgamma_mism.*k_b + k_rbeta.*k_b);
 
%% Create files
mismatch1 = [];
mismatch2 = [];
mismatch3 = [];

for i = 1:8440
% Colour coding depending on number of mismatches
if no_mism(i) == 1
    mismatch1 = [mismatch1; toe_seq(i) no_mism(i) delta_G(i) k_mism(i)];
elseif no_mism(i) == 2
    mismatch2 = [mismatch2; toe_seq(i) no_mism(i) delta_G(i) k_mism(i)];
elseif no_mism(i) == 3
mismatch3 = [mismatch3; toe_seq(i) no_mism(i) delta_G(i) k_mism(i)];
end
end


writecell(mismatch1, 'mismatch1.csv');
writecell(mismatch2, 'mismatch2.csv');
writecell(mismatch3, 'mismatch3.csv');


