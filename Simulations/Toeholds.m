% Clear workspace
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
 
% List of delta_G values (free energy changes, kcal/mol)
%delta_G = [-13.01, -12.56, -7.68, -9.36, -9.54, -9, -8.69, -5.53, -5.19, -5.96, -2.3, -7.83, -1.11, -4.79, -1.15, 0.76, -2.64];
delta_G_table = readtable("sGi_sX1_sOi_analysis_results.csv", Range = '2K:8441K');
delta_G_col = table2array(delta_G_table);
delta_G = delta_G_col.';

% List of number of mismatches for each delta_G value
no_mism_table = readtable("sGi_sX1_sOi_analysis_results.csv", Range = '2C:8441C');
no_mism_col = table2array(no_mism_table);
no_mism = no_mism_col.';

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
 
%% Figure 1
figure; hold on; box on;
 
% Plot Equation 2 for a incumbent toehold length of 2
p1 = plot(G, k, 'b-', 'LineWidth', 1.5, 'MarkerSize', 6,'DisplayName','Eq.2 for \Delta G(\beta^2) = -2.7 kcal/mol');
 
% Plot estimated rate constant for delta_g after mismatches
%p2 = plot(delta_G, k_mism, 'ko', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName','\Delta G after mismatches');
% Plot selected delta g values against its rate constant
for i = 1:8440
% Colour coding depending on number of mismatches
if no_mism(i) == 1
p2 = plot(delta_G(i), k_mism(i), 'ko', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName','\Delta G after 1 mismatch');
elseif no_mism(i) == 2
p3 = plot(delta_G(i), k_mism(i), 'ro', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName','\Delta G after 2 mismatches');
elseif no_mism(i) == 3
p4 = plot(delta_G(i), k_mism(i), 'go', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName','\Delta G after 3 mismatches');
end
end
% Plot rate constant for delta_g before mismatches
p5 = plot([-13.22], [k_mism(1)], 'co', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName','Original Strand');

% Plot rate constant for delta_g before mismatches
%p6 = plot([-13.22], [k_mism(1)], 'co', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName','Original Strand');

% Format axes
title('Rate Constant vs Free Energy Change');
xlabel('\DeltaG (\gamma^{10}) (kcal/mol)');
ylabel('Bimolecular Rate Constant, k_{2,10}');
legend([p1,p2,p3, p4, p5]);
yscale('log')
set(gca,'xDir','reverse')
xticks(-25:5:0)

%disp(k_mism)