% Export the data from those `.mat` files to a `.xls` file.

data_name = 'DUTS';
output_folder = './Results/';
mat_path = [output_folder, data_name, '/'];

fprintf("Dataset Name: %s\n", data_name);
fprintf("Output Folder Name: %s\n", output_folder);
fprintf("Mat File Path: %s\n", mat_path);

if(isfolder(mat_path) && ~isempty(mat_path))
    mat_list = dir(mat_path);
    mat_list = mat_list(3:end, 1);
else
    fprintf("%s should be a folder that has some files\n", mat_path);
end

num_model = length(mat_list);
output_data = cell(num_model + 1, 7);
output_data(1, :) =  {'Model', 'MaxF', 'MeanF', 'WFm', 'Emeasure', 'Smeasure', 'MAE'};

for i = 1 : num_model
    mat_data = load([mat_path, mat_list(i).name]);
    model_name = strsplit(mat_list(i).name, '.');
    output_data(i + 1, :) = { ...
        model_name{1}, ...
        mat_data.MaxFmeasure, ...
        mat_data.mean_Fmeasure(3), ...
        mat_data.wFmeasure, ...
        mat_data.Emeasure, ...
        mat_data.S_measure, ...
        mat_data.MAE
    };
end

output_data_model = output_data(2:end, :);
output_table = cell2table(output_data_model);
output_table.Properties.VariableNames = output_data(1, :);

filename = [output_folder, 'record_ablation.xls'];
writetable(output_table, filename, 'Sheet', data_name, 'Range', 'A1')
