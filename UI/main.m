classdef main < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure         matlab.ui.Figure
        GridLayout       matlab.ui.container.GridLayout
        LeftPanel        matlab.ui.container.Panel
        UIAxes           matlab.ui.control.UIAxes
        RightPanel       matlab.ui.container.Panel
        GridLayout2      matlab.ui.container.GridLayout
        EditField        matlab.ui.control.NumericEditField
        FrameLabel       matlab.ui.control.Label
        ChannelLabel     matlab.ui.control.Label
        MonteCarloLabel  matlab.ui.control.Label
        SensorsLabel     matlab.ui.control.Label
        AlgorithmLabel   matlab.ui.control.Label
        WindowLabel      matlab.ui.control.Label
        ChLengthLabel    matlab.ui.control.Label
        ModulationLabel  matlab.ui.control.Label
        SNRLabel         matlab.ui.control.Label
        DropDown         matlab.ui.control.DropDown
        DropDown_2       matlab.ui.control.DropDown
        DropDown_3       matlab.ui.control.DropDown
        EditField_2      matlab.ui.control.NumericEditField
        EditField_3      matlab.ui.control.NumericEditField
        EditField_4      matlab.ui.control.NumericEditField
        EditField_5      matlab.ui.control.NumericEditField
        EditField_6      matlab.ui.control.NumericEditField
        FileMenu         matlab.ui.container.Menu
        OpenMenu         matlab.ui.container.Menu
        SaveMenu         matlab.ui.container.Menu
        CloseMenu        matlab.ui.container.Menu
        WindowMenu       matlab.ui.container.Menu
        OptionMenu       matlab.ui.container.Menu
        HelpMenu         matlab.ui.container.Menu
        AboutMenu        matlab.ui.container.Menu
    end

    % Properties that correspond to apps with auto-reflow
    properties (Access = private)
        onePanelWidth = 576;
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Callback function
        function AboutMenuSelected(app, event)
            
        end

        % Menu selected function: AboutMenu
        function AboutMenuSelected2(app, event)
            % Disable Plot Options button while dialog is open
            % BSI.OptionsButton.Enable = 'off';
            
            % Open the options dialog and pass inputs
            About
        end

        % Changes arrangement of the app based on UIFigure width
        function updateAppLayout(app, event)
            currentFigureWidth = app.UIFigure.Position(3);
            if(currentFigureWidth <= app.onePanelWidth)
                % Change to a 2x1 grid
                app.GridLayout.RowHeight = {462, 462};
                app.GridLayout.ColumnWidth = {'1x'};
                app.RightPanel.Layout.Row = 2;
                app.RightPanel.Layout.Column = 1;
            else
                % Change to a 1x2 grid
                app.GridLayout.RowHeight = {'1x'};
                app.GridLayout.ColumnWidth = {443, '1x'};
                app.RightPanel.Layout.Row = 1;
                app.RightPanel.Layout.Column = 2;
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.AutoResizeChildren = 'off';
            app.UIFigure.Position = [100 100 714 462];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.SizeChangedFcn = createCallbackFcn(app, @updateAppLayout, true);

            % Create GridLayout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.ColumnWidth = {443, '1x'};
            app.GridLayout.RowHeight = {'1x'};
            app.GridLayout.ColumnSpacing = 0;
            app.GridLayout.RowSpacing = 0;
            app.GridLayout.Padding = [0 0 0 0];
            app.GridLayout.Scrollable = 'on';

            % Create LeftPanel
            app.LeftPanel = uipanel(app.GridLayout);
            app.LeftPanel.Layout.Row = 1;
            app.LeftPanel.Layout.Column = 1;

            % Create UIAxes
            app.UIAxes = uiaxes(app.LeftPanel);
            title(app.UIAxes, 'Title')
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.Position = [18 13 407 437];

            % Create RightPanel
            app.RightPanel = uipanel(app.GridLayout);
            app.RightPanel.Layout.Row = 1;
            app.RightPanel.Layout.Column = 2;

            % Create GridLayout2
            app.GridLayout2 = uigridlayout(app.RightPanel);
            app.GridLayout2.ColumnWidth = {'1x', '1x', '1x', '1x', '1x', '1x'};
            app.GridLayout2.RowHeight = {'1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x'};

            % Create EditField
            app.EditField = uieditfield(app.GridLayout2, 'numeric');
            app.EditField.HorizontalAlignment = 'center';
            app.EditField.Layout.Row = 3;
            app.EditField.Layout.Column = [1 2];

            % Create FrameLabel
            app.FrameLabel = uilabel(app.GridLayout2);
            app.FrameLabel.HorizontalAlignment = 'center';
            app.FrameLabel.Layout.Row = 2;
            app.FrameLabel.Layout.Column = [1 2];
            app.FrameLabel.Text = 'Frame';

            % Create ChannelLabel
            app.ChannelLabel = uilabel(app.GridLayout2);
            app.ChannelLabel.HorizontalAlignment = 'center';
            app.ChannelLabel.Layout.Row = 2;
            app.ChannelLabel.Layout.Column = [3 4];
            app.ChannelLabel.Text = 'Channel';

            % Create MonteCarloLabel
            app.MonteCarloLabel = uilabel(app.GridLayout2);
            app.MonteCarloLabel.HorizontalAlignment = 'center';
            app.MonteCarloLabel.Layout.Row = 2;
            app.MonteCarloLabel.Layout.Column = [5 6];
            app.MonteCarloLabel.Text = 'Monte Carlo';

            % Create SensorsLabel
            app.SensorsLabel = uilabel(app.GridLayout2);
            app.SensorsLabel.HorizontalAlignment = 'center';
            app.SensorsLabel.Layout.Row = 4;
            app.SensorsLabel.Layout.Column = [1 2];
            app.SensorsLabel.Text = 'Sensors';

            % Create AlgorithmLabel
            app.AlgorithmLabel = uilabel(app.GridLayout2);
            app.AlgorithmLabel.HorizontalAlignment = 'center';
            app.AlgorithmLabel.Layout.Row = 4;
            app.AlgorithmLabel.Layout.Column = [3 4];
            app.AlgorithmLabel.Text = 'Algorithm';

            % Create WindowLabel
            app.WindowLabel = uilabel(app.GridLayout2);
            app.WindowLabel.HorizontalAlignment = 'center';
            app.WindowLabel.Layout.Row = 4;
            app.WindowLabel.Layout.Column = [5 6];
            app.WindowLabel.Text = 'Window';

            % Create ChLengthLabel
            app.ChLengthLabel = uilabel(app.GridLayout2);
            app.ChLengthLabel.HorizontalAlignment = 'center';
            app.ChLengthLabel.Layout.Row = 6;
            app.ChLengthLabel.Layout.Column = [1 2];
            app.ChLengthLabel.Text = 'Ch Length';

            % Create ModulationLabel
            app.ModulationLabel = uilabel(app.GridLayout2);
            app.ModulationLabel.HorizontalAlignment = 'center';
            app.ModulationLabel.Layout.Row = 6;
            app.ModulationLabel.Layout.Column = [3 4];
            app.ModulationLabel.Text = 'Modulation';

            % Create SNRLabel
            app.SNRLabel = uilabel(app.GridLayout2);
            app.SNRLabel.HorizontalAlignment = 'center';
            app.SNRLabel.Layout.Row = 6;
            app.SNRLabel.Layout.Column = [5 6];
            app.SNRLabel.Text = 'SNR';

            % Create DropDown
            app.DropDown = uidropdown(app.GridLayout2);
            app.DropDown.Items = {'Option 1', 'Option 2', 'Option 3'};
            app.DropDown.Layout.Row = 3;
            app.DropDown.Layout.Column = [3 4];

            % Create DropDown_2
            app.DropDown_2 = uidropdown(app.GridLayout2);
            app.DropDown_2.Layout.Row = 5;
            app.DropDown_2.Layout.Column = [3 4];

            % Create DropDown_3
            app.DropDown_3 = uidropdown(app.GridLayout2);
            app.DropDown_3.Layout.Row = 7;
            app.DropDown_3.Layout.Column = [3 4];

            % Create EditField_2
            app.EditField_2 = uieditfield(app.GridLayout2, 'numeric');
            app.EditField_2.HorizontalAlignment = 'center';
            app.EditField_2.Layout.Row = 3;
            app.EditField_2.Layout.Column = [5 6];

            % Create EditField_3
            app.EditField_3 = uieditfield(app.GridLayout2, 'numeric');
            app.EditField_3.HorizontalAlignment = 'center';
            app.EditField_3.Layout.Row = 5;
            app.EditField_3.Layout.Column = [1 2];

            % Create EditField_4
            app.EditField_4 = uieditfield(app.GridLayout2, 'numeric');
            app.EditField_4.HorizontalAlignment = 'center';
            app.EditField_4.Layout.Row = 5;
            app.EditField_4.Layout.Column = [5 6];

            % Create EditField_5
            app.EditField_5 = uieditfield(app.GridLayout2, 'numeric');
            app.EditField_5.HorizontalAlignment = 'center';
            app.EditField_5.Layout.Row = 7;
            app.EditField_5.Layout.Column = [1 2];

            % Create EditField_6
            app.EditField_6 = uieditfield(app.GridLayout2, 'numeric');
            app.EditField_6.HorizontalAlignment = 'center';
            app.EditField_6.Layout.Row = 7;
            app.EditField_6.Layout.Column = [5 6];

            % Create FileMenu
            app.FileMenu = uimenu(app.UIFigure);
            app.FileMenu.Text = 'File';

            % Create OpenMenu
            app.OpenMenu = uimenu(app.FileMenu);
            app.OpenMenu.Separator = 'on';
            app.OpenMenu.Text = 'Open';

            % Create SaveMenu
            app.SaveMenu = uimenu(app.FileMenu);
            app.SaveMenu.Separator = 'on';
            app.SaveMenu.Text = 'Save';

            % Create CloseMenu
            app.CloseMenu = uimenu(app.FileMenu);
            app.CloseMenu.Separator = 'on';
            app.CloseMenu.Text = 'Close';

            % Create WindowMenu
            app.WindowMenu = uimenu(app.UIFigure);
            app.WindowMenu.Text = 'Window';

            % Create OptionMenu
            app.OptionMenu = uimenu(app.UIFigure);
            app.OptionMenu.Text = 'Option';

            % Create HelpMenu
            app.HelpMenu = uimenu(app.UIFigure);
            app.HelpMenu.Text = 'Help';

            % Create AboutMenu
            app.AboutMenu = uimenu(app.HelpMenu);
            app.AboutMenu.MenuSelectedFcn = createCallbackFcn(app, @AboutMenuSelected2, true);
            app.AboutMenu.Text = 'About';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = main

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end