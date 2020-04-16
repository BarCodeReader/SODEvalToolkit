%% ABOUT THIS CODE
% Author: Lart Pang
% Github: https://github.com/lartpang
% Thanks: https://github.com/ArcherFMY/sal_eval_toolbox

clc;
clear;
close all;

%% about using it：
% result_path  设置为存放evaluate.m生成的mat文件的文件夹，要注意，是包含所有数据集
%              的文件夹，默认是Results文件夹
% dataset_list 设置为result_path下想要读取数据的文件夹名字，最好使用数据集名字作
%              为这些文件夹的名字
% path_list    设置为对应于dataset_list所有文件夹中的mat文件名字的并集，注意，不用加
%              后缀名
% disp_list    设置为对应于path_list的所有文件要显示在绘图结果中的名字，由于matlab默
%              认会将名字字符串显示为latex格式，所以这里特意单独列出来转义后的列表，
%              注意要和path_list一一对应
result_path = './Results/';
use_random_color = true;
use_red_num = 1;
dataset_list = ["DUT-OMRON"; "DUTS"; "ECSSD"; "HKU-IS"; "PASCAL-S"];
path_list = ["MINet"; "EGNet-V";
             "AFNet";
             "MLMSNet"; "PAGE-Net";
             "HRS-D"; "CPD-V";
             "C2S"; "RAS";
             "PAGRN18"; "PiCANet";
             "DSS17"; "UCF17";
             "MSRNet"; "NLDF17";
             "AMU17"];
disp_list = ["Ours"; "EGNet";
             "AFNet";
             "MLMSNet"; "PAGE";
             "HRS"; "CPD";
             "C2SNet"; "RAS";
             "PAGR"; "PiCANet";
             "DSS"; "UCF";
             "MSRNet"; "NLDF";
             "Amulet"];

%% main program
linestyle_list = {'-', '--'};
marker_list = {'+', 'o', '*', '.', 'x', 's', 'd', '^', 'v', '>', '<'};
color_list = {'k', 'y', 'b', 'm', 'c', 'g'};

% PRcurve
pr_axis_list = [
    [0, 1, 0.15, 0.9];
    [0, 1, 0.15, 1];
    [0, 1, 0.2, 1];
    [0, 1, 0.2, 1];
    [0, 1, 0.2, 1];
    ];
for h = 1:length(dataset_list)
    dataset_name = [result_path, char(dataset_list(h))];
    fprintf('\nDrawing PR curves for proj: %s\n', dataset_name);
    if ~exist(dataset_name, 'dir')
        fprintf("the dir doesn't exist...\n");
        continue;
    end

    disp_real = [];
    for i = 1:length(path_list)

        file_name = [result_path, char(dataset_list(h)), '/', char(path_list(i)), '.mat'];
        fprintf('\nproj: %s\n', file_name);
        if ~exist(file_name, 'file')
            fprintf("the file doesn't exist...\n");
            continue;
        end

        disp_real = [disp_real, disp_list(i)];
        data = load(file_name);

        p = data.Pre;
        r = data.Recall;
        subplot(2, length(dataset_list), h)
        if i < use_red_num + 1
            % 指定自己的方法为红色
            plot(r, p, ...
                'LineStyle', '-', ...
                'Color', 'r', ...
                'LineWidth', 1.5)  % (X, Y)
        else  % 绘制其他算法
            if use_random_color
                % R, G, B
                curr_color = [0.2 * mod(i, 5)
                              0.1 * mod(i, 10)
                              0.05 * mod(i, 20)];
            else
                index_color = mod(i, 2) + 1;
                curr_color = char(color_list(index_color));
            end
            index_linestyle = mod(i + 1, 2) + 1;
            curr_linestyle = char(linestyle_list(index_linestyle));
            plot(r, p, ...
                'LineStyle', curr_linestyle, ...
                'Color', curr_color, ...
                'LineWidth', 1)  % (X, Y)
        end
        grid on;
        hold on;
    end
    % 测试完成一个数据集

    hold off;

    xticks((0 : 0.1 : 1));
    yticks((0 : 0.1 : 1));
    axis(pr_axis_list(h, :));

    title(dataset_list(h), 'FontSize', 10);
    ylabel('Precision', 'FontSize', 8);
    xlabel('Recall', 'FontSize', 8);
    legend(disp_real, 'Location','southwest', 'FontSize', 6);
    set(gca, 'FontName', 'Times New Roman');
end

% Fmcurve
fm_axis_list = [
    [0, 1, 0.2, 0.85];
    [0, 1, 0.15, 0.9];
    [0, 1, 0.3, 1];
    [0, 1, 0.2, 1];
    [0, 1, 0.3, 0.9];
    ];
for h = 1:length(dataset_list)
    dataset_name = [result_path, char(dataset_list(h))];
    fprintf('\nDrawing FM curves for proj: %s\n', dataset_name);
    if ~exist(dataset_name, 'dir')
        fprintf("the dir doesn't exist...\n");
        continue;
    end

    disp_real = [];
    for i = 1:length(path_list)

        file_name = [result_path, char(dataset_list(h)), '/', char(path_list(i)), '.mat'];
        fprintf('\nproj: %s\n', file_name);
        if ~exist(file_name, 'file')
            fprintf("the file doesn't exist...\n");
            continue;
        end

        disp_real = [disp_real, disp_list(i)];
        data = load(file_name);

        fm_curve = data.Fmeasure_Curve;
        x = linspace(0, 1, 256);
        subplot(2, length(dataset_list), length(dataset_list) + h)
        if i < use_red_num + 1
            % 指定自己的方法为红色
            plot(x', fm_curve, ...
                'LineStyle', '-', ...
                'Color', 'r', ...
                'LineWidth', 1.5)  % (X, Y)
        else  % 绘制其他算法
            if use_random_color
                % R, G, B
                curr_color = [0.2 * mod(i, 5)
                              0.1 * mod(i, 10)
                              0.05 * mod(i, 20)];
            else
                index_color = mod(i, 2) + 1;
                curr_color = char(color_list(index_color));
            end
            index_linestyle = mod(i + 1, 2) + 1;
            curr_linestyle = char(linestyle_list(index_linestyle));
            plot(x', fm_curve, ...
                'LineStyle', curr_linestyle, ...
                'Color', curr_color, ...
                'LineWidth', 1)  % (X, Y)
        end
        grid on;
        hold on;
    end
    % 测试完成一个数据集

    hold off;

    xticks((0 : 0.1 : 1));
    yticks((0 : 0.1 : 1));
    axis(fm_axis_list(h, :));

    title(dataset_list(h), 'FontSize', 10);
    ylabel('F-measure', 'FontSize', 8);
    xlabel('Threshold', 'FontSize', 8);
    legend(disp_real, 'Location','southwest', 'FontSize', 6);
    set(gca, 'FontName', 'Times New Roman');
end

save_folder = [result_path, 'Img/Total'];
save_path = [save_folder, '/', 'TotalCurve.pdf'];
if ~exist(save_folder, 'dir')
    fprintf("the dir: %s doesn't exist, so let's creat it", save_folder);
    mkdir(save_folder);
end

saveas(gcf, save_path);
