% The following code file extracts data from pre-defined databases of strand
% designs and their associated Gibbs Free Energies. Statistical functions
% are applied and a plot is generated of the probability density function
% of each subset of strands with appropriate means and standard deviations.


%Read in file from databases
mm1 = readtable("mismatch1_clean.csv");
mm2 = readtable("mismatch2_clean.csv");
mm3 = readtable("mismatch3.csv");

%extract relevant Gibbs Free Energies
gibbs1 = mm1.Var3; %List of Gibbs Free Energies of strands with 1 mismatch
gibbs2 = mm2.Var3; %List of Gibbs Free Energies of strands with 2 mismatches
gibbs3 = mm3.Var3; %List of Gibbs Free Energies of strands with 2 mismatches


%Calculate Mean
mean_1 = mean(gibbs1);  %Mean Free Energy (1 mismatch)
mean_2 = mean(gibbs2);  %Mean Free Energy (2 mismatches)
mean_3 = mean(gibbs3);  %Mean Free Energy (3 mismatches)

disp(mean_1);

%Calculate Variance
var_1 = var(gibbs1); %Free Energy Variance (1 mismatch)
var_2 = var(gibbs2); %Free Energy Variance (2 mismatches)
var_3 = var(gibbs3); %Free Energy Variance (3 mismatches)

%SD of each 
SD_1 = std(gibbs1); %Free Energy Standard Deviation (1 mismatch)
SD_2 = std(gibbs2); %Free Energy Standard Deviation (2 mismatches)
SD_3 = std(gibbs3); %Free Energy Standard Deviation (3 mismatches)


%% Create Plot 

f = figure();
set(f, 'position', [50 0 1700 1600], 'color', 'w');
tiledlayout(2,2)

% generate for each number of mismatches

% histogram - 1 mismatch
nexttile
histogram(gibbs1, 25, 'Normalization', 'probability', 'FaceColor', 'r');
grid on
title('1 Mismatch (30 strands)')
xlabel('\Delta G');
xlim([-15 5]);
ylim([0 0.175]);
set(gca,'xDir','reverse');
ylabel('Probability Density');
set(gca, 'FontSize', 18)
set(gca, 'FontName', 'Times New Roman')
text(0, 1.1, 'a)', 'Units', 'normalized', 'FontWeight', 'bold', 'FontSize', 24);

%Plot mean for 1 mismatch
xline(mean_1, 'k', 'LineWidth', 3); 

% Plot standard deviation lines (mean ± SD) for 1 mismatch
xline(mean_1 + SD_1,'Color', [0.4, 0.4, 0.4], 'LineWidth', 3);
xline(mean_1 - SD_1, 'Color', [0.4, 0.4, 0.4], 'LineWidth', 3);

%histogram - 2 mismatches
nexttile
histogram(gibbs2, 25, 'Normalization', 'probability', 'FaceColor', 'b');
grid on
title('2 Mismatches (405 strands)')
xlabel('\Delta G');
xlim([-15 5]);
ylim([0 0.175]);
set(gca,'xDir','reverse');
ylabel('Probability density');
set(gca, 'FontSize', 18)
set(gca, 'FontName', 'Times New Roman')
text(0, 1.1, 'b)', 'Units', 'normalized', 'FontWeight', 'bold', 'FontSize', 24);

% Plot mean for 2 mismatches 
h1 = xline(mean_2, 'k', 'LineWidth', 3); 

% Plot standard deviation lines (mean ± SD) for 2 mismatches
h2 = xline(mean_2 + SD_2, 'Color', [0.4, 0.4, 0.4], 'LineWidth', 3);
xline(mean_2 - SD_2, 'Color', [0.4, 0.4, 0.4], 'LineWidth', 3);

% histogram - 3 mismatches 
nexttile
histogram(gibbs3, 25, 'Normalization', 'probability', 'FaceColor', 'g');
grid on
title('3 Mismatches (3240 strands)')
xlabel('\Delta G');
xlim([-15 5]);
ylim([0 0.175]);
set(gca,'xDir','reverse');
ylabel('Probability density');
set(gca, 'FontSize', 18)
set(gca, 'FontName', 'Times New Roman')
text(0, 1.1, 'c)', 'Units', 'normalized', 'FontWeight', 'bold', 'FontSize', 24);

% Plot meam for 3 mismatches
xline(mean_3, 'k','LineWidth', 3); 

% Plot standard deviation lines (mean ± SD) for 3 mismatches
xline(mean_3 + SD_3, 'Color', [0.4, 0.4, 0.4], 'LineWidth', 3);
xline(mean_3 - SD_3, 'Color', [0.4, 0.4, 0.4], 'LineWidth', 3);

% Plot overlay of all 3 histograms 
nexttile
histogram(gibbs1, 25, 'Normalization', 'probability', 'FaceColor', 'r', 'FaceAlpha', 0.5);
hold on
histogram(gibbs2, 25, 'Normalization', 'probability', 'FaceColor', 'b', 'FaceAlpha', 0.5);
histogram(gibbs3, 25, 'Normalization', 'probability', 'FaceColor', 'g', 'FaceAlpha', 0.5);
grid on
title('1, 2, and 3 Mismatches')
xlabel('\Delta G');
xlim([-15 5]);
ylim([0 0.175]);
set(gca,'xDir','reverse');
ylabel('Probability density');
text(0, 1.1, 'd)', 'Units', 'normalized', 'FontWeight', 'bold', 'FontSize', 24);


% Add the legend for all three categories (mean, SD, and variance)
lgd = legend([h1, h2], {'Mean', 'SD'}, 'Location', 'northeastoutside');
set(gca, 'FontSize', 18)
set(gca, 'FontName', 'Times New Roman')
fontsize(lgd, 18, "points")
exportgraphics(f, 'Stats.pdf', 'resolution', 600)
