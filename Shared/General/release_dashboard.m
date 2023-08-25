function release_dashboard ( handles, cont )

%% index = release_dashboard(hObject, cont): Replace dashboard with title of algorithms
%
%% Input:
    % 1. handles: (handles) - handles of current dashboard in InSI 
    % 2. cont: (char) - name of current algorithm
%
%% Output: 
    % 1. index: (int) - index of editable text
%
%% Require R2006A
%
% Author: Do Hai Son, Vietnam National University, Hanoi, Vietnam

% Last modified by Do Hai Son, 11-Aug-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless Communications
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France

global main_path;
global Text_handles;
global configs;
axesH = handles.board;  % Not safe! Better get the handle explicitly!
axis off;
Position = axesH.Position;
x_0 = Position(1);
y_0 = Position(2);
width = Position(3);
height = Position(4);
set(axesH, 'Tag', 'board');

try
    img = findall(axesH, 'type', 'image');
    set(img, 'Visible', 'off');
    set(handles.board_title, 'String', '');
catch
end

%get the GUI handles
board = gcf;
set(board, 'MenuBar', 'none');
set(board, 'ToolBar', 'none');

hfig = figure();
set(hfig,'position', Position);

[AVITECH_sample, ~, AVITECH_sample_alpha]   = imread(fullfile(main_path, '/Resource/Icon/AVITECH.png'));
[Orleans_sample, ~, Orleans_sample_alpha]   = imread(fullfile(main_path, '/Resource/Icon/Orleans.png'));
[Nafosted_sample, ~, Nafosted_sample_alpha] = imread(fullfile(main_path, '/Resource/Icon/Nafosted.png'));
[PRIMSE_sample, ~, PRIMSE_sample_alpha]     = imread(fullfile(main_path, '/Resource/Icon/PRISME.png'));
[VMC_sample, ~, VMC_sample_alpha]           = imread(fullfile(main_path, '/Resource/Icon/Viettel_VMC.png'));
[UET_sample, ~, UET_sample_alpha]           = imread(fullfile(main_path, '/Resource/Icon/VNU_UET.png'));

ax1 = subplot(6, 6, 1);
image(UET_sample, 'AlphaData', UET_sample_alpha);
ax1.Position = [x_0 + width / 8, y_0 + height / 4, width /6.2, height /5.5];
axis off;
ax2 = subplot(6, 6, 2);
image(Orleans_sample, 'AlphaData', Orleans_sample_alpha);
ax2.Position = [x_0 + width / 2.45, y_0 + height / 3.8, width /6,   height / 6];
axis off;
ax3 = subplot(6, 6, 3);
image(Nafosted_sample, 'AlphaData', Nafosted_sample_alpha);
ax3.Position = [x_0 + width / 1.5, y_0 + height / 4.3, width / 4.2, height / 4.2];
axis off;
ax4 = subplot(6, 6, 4);
image(AVITECH_sample, 'AlphaData', AVITECH_sample_alpha);
ax4.Position = [x_0 + width / 10, y_0, width / 4.5, height / 4.5];
axis off;
ax5 = subplot(6, 6, 5);
image(PRIMSE_sample, 'AlphaData', PRIMSE_sample_alpha);
ax5.Position = [x_0 + width / 2.6, y_0, width / 4.2, height / 4.2];
axis off;
ax6 = subplot(6, 6, 6);
image(VMC_sample, 'AlphaData', VMC_sample_alpha);
ax6.Position = [width / 1.45, y_0, width / 4, height / 4];
axis off;
ax7 = subplot(6, 6, 7);
text(0, 0, 'InSI', 'FontUnits', 'normalized', 'FontSize', 0.25, 'FontWeight', 'bold', 'Color', [0 0.30196078431372547 0.5019607843137255]);
ax7.Position = [x_0 + width / 2.3, y_0 + height / 1.05, x_0, y_0];
axis off;
ax8 = subplot(6, 6, 8);
text(0, 0, 'Informed System Identification in Wireless Communications', 'FontUnits', 'normalized', 'FontSize', 0.095, 'FontWeight', 'normal');
ax8.Position = [x_0 + width / 10, y_0 + height / 1.15, x_0, y_0];
axis off;

ax = get(hfig,'children');
%copy plotted subplots to the gui  
copyobj(ax, board);
close(hfig) % close the temporary figure

try
    % Set font size
    font_size = configs.default_title_font_size;
    if length(cont) ~= 14
        font_size = 0.15 / 1.8;
    end
    set(Text_handles, 'FontSize', font_size);
    
    % Set position
    set(Text_handles, 'HorizontalAlignment', 'center');
    set(Text_handles, 'Position', [x_0 + width * 12, y_0 - height / 2, 0]);

    % Set content
    set(Text_handles, 'String', cont);
catch ME
    disp(ME);
    return
end

end