%The following file is used to apply the model introduced by Zhang. et. al
%in their work "Control of DNA Strand DisplacementKinetics Using Toehold Exchange" to the BIOREGEN 
% reaction system for 10 arbitrary strand designs. A shifted Free Energy is then imposed to visualize the effect of this shift on calculated strand paramters (namely the rate constant)
% The file takes an input file and extracts data about the
% Gibbs Free Energies of different strands. A plot is then generated of the
% Gibbs Free Energies vs. a theoretical predicted rate constant that is calculated within the file.

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
G_beta = -2.7;           % Incumbent toehold binding energy (kcal/mol)
offset = -10;
offset2 = -5;
 
% delta_g range
G = -35:0.1:5;
 
% k_rbeta: k_r for incumbent toehold 
k_rbeta = k_f*(2/(b-m))*exp(G_beta/(R*T));
 
% List of arbitrary delta_G values (free energy changes, kcal/mol)
delta_G = [-13.01, -12.56, -7.68, -9.36, -9.54, -9, -8.69, -5.53, -5.19, -5.96, -2.3, -7.83, -1.11, -4.79, -1.15, 0.76, -2.64];


%% Calculating rate constant for delta_g range of -25 kcal/mol to 0 kcal/mol
 
% k_rg: k_r for invader toehold 
k_rgamma = k_f*(2/(b-m))*exp(G./(R*T));
% k: Final rate constant (from equation 2)
k = (k_rbeta*k_f*k_b)./(k_rgamma.*k_rbeta + k_rgamma.*k_b + k_rbeta.*k_b);
 
%% Calculating rate constant for delta_g of mismatches
 
% k_rg: k_r for invader toehold 
k_rgamma_mism = k_f*(2/(b-m))*exp(delta_G./(R*T));
k_rgamma_mism2 = k_f*(2/(b-m))*exp((delta_G + offset)./(R*T));
k_rgamma_mism3 = k_f*(2/(b-m))*exp((delta_G + offset2)./(R*T));
% k: Final rate constant 
k_mism = (k_rbeta*k_f*k_b)./(k_rgamma_mism.*k_rbeta + k_rgamma_mism.*k_b + k_rbeta.*k_b);
k_mism2 = (k_rbeta*k_f*k_b)./(k_rgamma_mism2.*k_rbeta + k_rgamma_mism2.*k_b + k_rbeta.*k_b);
k_mism3 = (k_rbeta*k_f*k_b)./(k_rgamma_mism3.*k_rbeta + k_rgamma_mism3.*k_b + k_rbeta.*k_b);
 
%% Figure Generation
f = figure();
set(f, 'position', [50 0 2300 2500], 'color', 'w');
hold on; box on;

%Plot of model with input of original Free Energy values
subplot(1, 2, 1)
hold on
% Plot Equation 2 for a incumbent toehold length of 2
p1 = plot(G, k, 'b-', 'LineWidth', 3, 'MarkerSize', 6 ,'DisplayName','Model for \Delta G(\beta^2) = -2.7 kcal/mol');
% Plot rate constant for delta_g before shifted free energies
p2 = scatter(delta_G, k_mism, 100,'k','filled','MarkerFaceAlpha', 0.6, 'DisplayName','Sample Strands with Original NUPACK \Delta G');
% Plot parameters for perfectly complementary strand
p5 = scatter([-13.22], [k_mism(1)],120,'c','filled','MarkerFaceAlpha', 0.6, 'DisplayName','Original Strand');

title('Rate Constant vs Free Energy Change');
xlabel('\DeltaG (\gamma^{10}) (kcal/mol)');
ylabel('Bimolecular Rate Constant, k (M^{-1}s^{-1})');
lgd = legend([p1,p2,p5], 'Location', 'southeast');
set(gca, 'YScale', 'log')
set(gca,'xDir','reverse')
xticks(-35:5:0)
set(gca, 'FontSize', 18)
set(gca, 'FontName', 'Times New Roman')
grid on
fontsize(lgd, 18, "points")

%Plot of model with input of shifted Free Energy values
subplot(1, 2, 2)
hold on
% Plot Equation 2 for a incumbent toehold length of 2
p1b = plot(G, k, 'b-', 'LineWidth', 3, 'MarkerSize', 6,'DisplayName','Model for \Delta G(\beta^2) = -2.7 kcal/mol');
% Plot rate constant for delta_g after shifted free energies
p2b = scatter(delta_G + offset, k_mism2, 120,'r','filled','MarkerFaceAlpha', 0.6, 'DisplayName','Sample Strands with -10 Offset \Delta G');
% Plot parameters for perfectly complementary strand
p5b = scatter([-23.22], [k_mism2(1)], 120,'c', 'filled', 'MarkerFaceAlpha', 0.6, 'DisplayName','Original Strand');

title('Rate Constant vs Free Energy Change with a \Delta G Offset');
xlabel('\DeltaG (\gamma^{10}) (kcal/mol)');
ylabel('Bimolecular Rate Constant, k (M^{-1}s^{-1})');
lgd2 = legend([p1b,p2b,p5b], 'Location', 'southeast');
set(gca, 'YScale', 'log')
set(gca,'xDir','reverse')
xticks(-35:5:0)
set(gca, 'FontSize', 18)
set(gca, 'FontName', 'Times New Roman')
grid on
fontsize(lgd2, 18, "points")
exportgraphics(f, 'ShiftedG.pdf', 'resolution', 600)
