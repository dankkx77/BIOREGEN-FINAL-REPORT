%% Clear workspace
clc
clear all
close all
format long


%% New Plot 

mismatch1 = readtable("mismatch1_clean.csv");
mismatch2 = readtable("mismatch2_clean.csv");
mismatch3 = readtable("mismatch3.csv");

b = 15;                  % Total branch migration length
m = 2;                   % Incumbent toehold length
k_b = (b/(b-m))^2;        % Branch migration rate constant (s^-1)
R = 1.987e-3;            % Gas constant in kcal/(mol·K)
T = 298.15;               % Temperature in Kelvin
k_f = 3.5e6;              % kf1=kf2=kf (/M/s)
G_beta = -2.7;           % Incumbent toehold binding energy from Table 2 (kcal/mol)
 
% delta_g range
G = -25:0.1:5;
 
% k_rbeta: k_r for incumbent toehold (from equation 1)
k_rbeta = k_f*(2/(b-m))*exp(G_beta/(R*T));

%% Calculating rate constant for delta_g range of -25 kcal/mol to 0 kcal/mol
 
% k_rg: k_r for invader toehold (from equation 1)
k_rgamma = k_f*(2/(b-m))*exp(G./(R*T));
% k: Final rate constant (from equation 2)
k = (k_rbeta*k_f*k_b)./(k_rgamma.*k_rbeta + k_rgamma.*k_b + k_rbeta.*k_b);
 

%% Figure 1

f = figure(); 
hold on; box on;
set(f, 'position', [50 0 1700 1600], 'color', 'w');
subplot(2,2,1)
hold on
grid on
% Plot Equation 2 for a incumbent toehold length of 2
p1 = plot(G, k, 'b-', 'LineWidth', 1.5, 'MarkerSize', 6,'DisplayName','Model for \Delta G(\beta^2) = -2.7 kcal/mol');

for i = 1: 30
    p2 = plot(mismatch1.Var3(i), mismatch1.Var4(i), 'ko', 'LineWidth', 2, 'MarkerSize', 7, 'DisplayName','1 mismatch strand');
end

title('1 mismatch');
xlabel('\DeltaG (\gamma^{10}) (kcal/mol)');
ylabel('Bimolecular Rate Constant, k (M^{-1}s^{-1})');
lgd = legend([p1, p2], 'Location','southeast');
set(gca, 'YScale', 'log')
ylim([1e-1 1e8]); 
set(gca,'xDir','reverse')
xlim([-20 5])
set(gca, 'FontSize', 18, 'FontName', 'Times New Roman')
xticks(-20:5:0)
fontsize(lgd, 18, "points")
text(0, 1.1, 'a)', 'Units', 'normalized', 'FontWeight', 'bold', 'FontSize', 24);



subplot(2,2,2)
hold on
grid on
p5 = plot(G, k, 'b-', 'LineWidth', 1.5, 'MarkerSize', 6,'DisplayName','Model for \Delta G(\beta^2) = -2.7 kcal/mol');
for i = 1:405
    p3 = plot(mismatch2.Var3(i), mismatch2.Var4(i), 'ro', 'LineWidth', 2, 'MarkerSize', 7, 'DisplayName','2 mismatch strand');
end
title('2 mismatches');
xlabel('\DeltaG (\gamma^{10}) (kcal/mol)');
ylabel('Bimolecular Rate Constant, k (M^{-1}s^{-1})');
lgd2 = legend([p3, p5], 'Location', 'southeast');
set(gca, 'YScale', 'log')
ylim([1e-1 1e8]); 
xlim([-20 5])
set(gca,'xDir','reverse')
set(gca, 'FontSize', 18, 'FontName', 'Times New Roman')
xticks(-20:5:0)
fontsize(lgd2, 18, "points")
text(0, 1.1, 'b)', 'Units', 'normalized', 'FontWeight', 'bold', 'FontSize', 24);


subplot(2,2,3)
hold on
grid on
p6 = plot(G, k, 'b-', 'LineWidth', 1.5, 'MarkerSize', 6,'DisplayName','Model for \Delta G(\beta^2) = -2.7 kcal/mol');
for i = 1:3240
    p4 = plot(mismatch3.Var3(i), mismatch3.Var4(i), 'go', 'LineWidth', 2, 'MarkerSize', 7, 'DisplayName','3 mismatch strand');
end
title('3 mismatches');
xlabel('\DeltaG (\gamma^{10}) (kcal/mol)');
ylabel('Bimolecular Rate Constant, k (M^{-1}s^{-1})');
lgd3 = legend([p4, p6], 'Location', 'southeast');
set(gca, 'YScale', 'log')
ylim([1e-1 1e8]); 
xlim([-20 5])
set(gca,'xDir','reverse')
set(gca, 'FontSize', 18, 'FontName', 'Times New Roman')
xticks(-20:5:0)
fontsize(lgd3, 18, "points")
text(0, 1.1, 'c)', 'Units', 'normalized', 'FontWeight', 'bold', 'FontSize', 24);

subplot(2,2,4)
hold on 
grid on
p11 = plot(G, k, 'b-', 'LineWidth', 1.5, 'MarkerSize', 6,'DisplayName','Model for G(\beta^2) = -2.7 kcal/mol');
for i = 1: 30
    p21 = plot(mismatch1.Var3(i), mismatch1.Var4(i), 'ko', 'LineWidth', 2, 'MarkerSize', 7, 'DisplayName','1 mismatch strand');
end
for i = 1:405
    p31 = plot(mismatch2.Var3(i), mismatch2.Var4(i), 'ro', 'LineWidth', 2, 'MarkerSize', 7, 'DisplayName','2 mismatch strand');
end
for i = 1:3240
    p41 = plot(mismatch3.Var3(i), mismatch3.Var4(i), 'go', 'LineWidth', 2, 'MarkerSize', 7, 'DisplayName','3 mismatch strand');
end

% k_rg: k_r for invader toehold (from equation 1)
k_rgamma_mism = k_f*(2/(b-m))*exp(-13.03518123/(R*T));
% k: Final rate constant (from equation 2)
k_mism = (k_rbeta*k_f*k_b)/(k_rgamma_mism*k_rbeta + k_rgamma_mism*k_b + k_rbeta*k_b);

p15 = plot([-13.03518123], [k_mism], 'co', 'LineWidth', 2, 'MarkerSize', 7, 'DisplayName','Original Strand');

title('1, 2, & 3 Mismatches');
xlabel('\DeltaG (\gamma^{10}) (kcal/mol)');
ylabel('Bimolecular Rate Constant, k (M^{-1}s^{-1})');
lgd4 = legend([p11, p21, p31, p41, p15], 'Location', 'southeast');
set(gca, 'YScale', 'log')
ylim([1e-1 1e8]); 
xlim([-20 5])
set(gca,'xDir','reverse')
set(gca, 'FontSize', 18, 'FontName', 'Times New Roman')
xticks(-20:5:0)
fontsize(lgd4, 18, "points")
text(0, 1.1, 'd)', 'Units', 'normalized', 'FontWeight', 'bold', 'FontSize', 24);
exportgraphics(f, 'FigJACS4.pdf', 'resolution', 600)


 