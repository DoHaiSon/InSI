% http://www.mathworks.com/help/matlab/matlab_prog/suppress-warnings.html
function TurnOffWarnings
try
  % To set the warning state, you must first know the message identifier for the one warning you want to enable.
  % Query the last warning to acquire the identifier.  For example:
  % warnStruct = warning('query', 'last')
  % messageID = warnStruct.identifier
  % messageID =
  %    MATLAB:concatenation:integerInteraction
  
  % Turn off this warning "Warning: Image is too big to fit on screen; displaying at 33% "
  warning('off', 'Images:initSize:adjustingMag');
  
  % Get rid of warning about directory already existing:
  % "Warning: Directory already exists."
  warning('off', 'MATLAB:MKDIR:DirectoryExists');
  
  % Turn off note "Warning: Added specified worksheet." that appears in the command window.
  warning('off', 'MATLAB:xlswrite:AddSheet');
  
  % Get rid of warning about roipolyold being deprecated:
  % "Warning: Function ROIPOLYOLD will be removed in the future. Use ROIPOLY instead"
  warning('off', 'images:removing:function');
  
  % Get rid of warning about wavread() being deprecated:
  % "Warning: WAVREAD will be removed in a future release. Use AUDIOREAD instead."
  warning('off', 'MATLAB:audiovideo:wavread:functionToBeRemoved');
  
  % Get rid of warning about wavread() being deprecated:
  % "Warning: figure JavaFrame property will be obsoleted in a future release. For more information see the JavaFrame resource on the MathWorks web site."
  warning('off', 'MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
  
catch ME
  errorMessage = sprintf('Error in function %s() at line %d.\n\nError Message:\n%s', ...
    ME.stack(1).name, ME.stack(1).line, ME.message);
  fprintf(1, '%s\n', errorMessage);
  WarnUser(errorMessage);
end
return; % from TurnOffWarnings