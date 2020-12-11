classdef about < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        AboutUIFigure  matlab.ui.Figure
        Blindsystemidentification10Copyright2020AVITECHLabel  matlab.ui.control.Label
        OKButton       matlab.ui.control.Button
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
         
        end

        % Button pushed function: OKButton
        function OKButtonPushed(app, event)
            delete(app)
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create AboutUIFigure and hide until all components are created
            app.AboutUIFigure = uifigure('Visible', 'off');
            app.AboutUIFigure.Position = [100 100 274 139];
            app.AboutUIFigure.Name = 'About';
            app.AboutUIFigure.Icon = 'about.png';
            
            % Create Blindsystemidentification10Copyright2020AVITECHLabel
            app.Blindsystemidentification10Copyright2020AVITECHLabel = uilabel(app.AboutUIFigure);
            app.Blindsystemidentification10Copyright2020AVITECHLabel.FontSize = 13;
            app.Blindsystemidentification10Copyright2020AVITECHLabel.Position = [42 60 191 43];
            movegui(app.AboutUIFigure,"center");
            app.Blindsystemidentification10Copyright2020AVITECHLabel.Text = {'Blind system identification 1.0.'; 'Copyright 2020 AVITECH.'};

            % Create OKButton
            app.OKButton = uibutton(app.AboutUIFigure, 'push');
            app.OKButton.ButtonPushedFcn = createCallbackFcn(app, @OKButtonPushed, true);
            app.OKButton.Position = [88 15 100 22];
            app.OKButton.Text = 'OK';

            % Show the figure after all components are created
            app.AboutUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = about

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.AboutUIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.AboutUIFigure)
        end
    end
end