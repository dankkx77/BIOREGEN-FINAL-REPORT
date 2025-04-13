%% Clear workspace
clc
clear all
close all
format long

%%

mismatch1 = readtable("mismatch1.csv");
mismatch2 = readtable("mismatch2.csv");
mismatch3 = readtable("mismatch3.csv");


%% Remove duplicates FOR MISMATCH1


duplicates1 = [];
for i = 2:height(mismatch1)
    j = i-1;
    for k = 1:j
        if (mismatch1{i, 1}{1} == mismatch1{k, 1}{1})
            duplicates1 = [duplicates1, i];
            break;
        end
    end
end 

mismatch1(duplicates1, :) = [];
writetable(mismatch1, 'mismatch1_clean.csv');



%% Remove duplicates FOR MISMATCH2

duplicates2 = [];
for i = 2:height(mismatch2)
    j = i-1;
    for k = 1:j
        if (mismatch2{i, 1}{1} == mismatch2{k, 1}{1})
            duplicates2 = [duplicates2, i];
            break;
        end
    end
end 

mismatch2(duplicates2, :) = [];
writetable(mismatch2, 'mismatch2_clean.csv');


%% Remove duplicates FOR MISMATCH3

duplicates3 = [];
for i = 2:height(mismatch3)
    j = i-1;
    for k = 1:j
        if (mismatch3{i, 1}{1} == mismatch3{k, 1}{1})
            duplicates3 = [duplicates3, i];
            break;
        end
    end
end 

mismatch3(duplicates3, :) = [];
writetable(mismatch3, 'mismatch3_clean.csv');








