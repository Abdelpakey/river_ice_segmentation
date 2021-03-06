clear all;
% plot_title='UNet';
% k=importdata('unet_summary.txt');

% plot_title='SegNet';
% k=importdata('segnet_summary.txt');

% plot_title='Deeplab';
% k=importdata('deeplab_summary.txt');

% plot_title='DenseNet';
% k=importdata('densenet_summary.txt');

% plot_title='Comparing models';
plot_title='Selective Training';

% y_label = 'Recall (%)';
% y_label = 'pixel accuracy';
y_label = 'acc/IOU';

% plot_title='Recall rates using 5000 video images for training';
% plot_title='Recall rates on 20K 3-class test set without static images';
k=importdata('combined_summary.txt');
% k=importdata('radon.txt');

line_width = 3;
transparent_bkg = 1;

% line_specs = {'-og', '-+r'};
% line_specs = {'--or', '-+g', '--xm', '-xm'};

% line_specs = {'-or', '-+g', '-*b', '--xm'};
line_specs = {'-or', ':+r', '-*b', ':xb'};

% line_specs = {'--or', '-+g', '-*b', '-xm', '-sc', '-pk'};

% line_specs = {'-or', '-+g', '-*b',...
%     '--or', '--+g', '--*b'};

% line_specs = {'-+g', '-*b', '-xm',...
%     '--+g', '--*b', '--xm'};

% line_specs = {'-or', '-+g', '-*b', '-xm',...
%     '--or', '--+g', '--*b', '--xm'};

% line_specs = {'-or', '-+g', '-*b', '-xm', '-sc',...
%     '--or', '--+g', '--*b', '--xm', '--sc'};

% line_specs = {'-or', '--*r', '-+g', '--xg'};
% line_specs = {'-or', '-+g', '--*r', '-+g', '--xg'};

% set(0,'DefaultAxesFontName', 'Times New Roman');
set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultAxesFontWeight', 'bold');

if isfield(k,'colheaders')
    n_lines = size(k.data, 2) - 1;
    plot_data = k.data(:, 2:end);
    patch_sizes = k.data(:, 1);
    plot_legend = {k.colheaders{2:end}};
    x_label='K';
else
    n_lines = size(k.data, 2)
    n_items = size(k.data, 1)
    plot_data = k.data;
%     x_label='Model';

    n_text_lines = size(k.textdata, 2)
    n_text_items = size(k.textdata, 1)
    if n_text_items == n_items + 3
        y_label = k.textdata(1, 1)
        k.textdata = k.textdata(2:end, :);
        n_text_items = n_text_items - 1;
    end
    if n_text_items == n_items + 2
        plot_title = k.textdata(1, 1)
        k.textdata = k.textdata(2:end, :);
    end
    x_label = k.textdata(1, 1)
    plot_legend = {k.textdata{1, 2:end}}
    xtick_labels = k.textdata(2:end, 1)
    patch_sizes = 1:n_items;
    
    for j = 1:n_items        
        if xtick_labels{j}(1)=='_'
            xtick_labels{j} = xtick_labels{j}(2:end);
        end
            
    end
        
end
figure

for i = 1:n_lines
    plot(patch_sizes, plot_data(:, i), line_specs{i},...
        'LineWidth', line_width);
%         'GridAlpha', 1);
    hold on
end
hold off
h_legend=legend(plot_legend, 'Interpreter','none');
set(h_legend,'FontSize',18);
set(h_legend,'FontWeight','bold');
grid on;

% ax = gca;
% ax.GridAlpha=0.25;
% ax.GridLineStyle=':';
% set (gca, 'GridAlphaMode', 'manual');
% set (gca, 'GridAlpha', 0.5);
% set (gca, 'GridLineStyle', '-');

try
    xticks(patch_sizes);
    if exist('xtick_labels', 'var')
        xticklabels(xtick_labels);
    end
catch
    set(gca, 'XTick', patch_sizes)    
    if exist('xtick_labels', 'var')
        set(gca, 'xticklabel', xtick_labels)
    end
end
% ylabel('metric value');
y_label = strtrim(y_label);
ylabel(y_label, 'fontsize',20, 'FontWeight','bold', 'Interpreter', 'none');

x_label = strtrim(x_label);
xlabel(x_label, 'fontsize',20, 'FontWeight','bold', 'Interpreter', 'none');
xticklabel_rotate([],90,[], 'fontsize',20, 'FontWeight','bold', 'Interpreter', 'none');

% ylim([0.60, 0.90]);
% ylim([0.65, 0.90]);
plot_title = strtrim(plot_title);
title(plot_title, 'fontsize',20, 'FontWeight','bold', 'Interpreter', 'none');
if transparent_bkg
    set(gca,'color','none')
    set(h_legend,'color','none');
end




