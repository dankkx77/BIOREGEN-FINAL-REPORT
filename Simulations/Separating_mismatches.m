%This file takes the output of a NUPACK code file used to generate
%arbitrary toehold sequences with different numbers of mismatches. The
%sequences and their associated information are then moved into separate
%files based on the number of mismatches (functional for up to 3
%mismatches)

%% Clear workspace
clc
clear all
close all
format long
 

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
 
%% Create files
mismatch1 = [];
mismatch2 = [];
mismatch3 = [];

%Sort into appropriate file by number of mismatches
for i = 1:8440
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


