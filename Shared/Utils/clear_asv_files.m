function clear_asv_files(folder)
    % Clears auto-save files (.asv) in a given folder (also in subfolders).
    rehash path % Refresh file system path caches
    if (nargin < 1)
        folder = '';
    end
    % Find the folders
    folders = genpath([pwd filesep folder]);
    folders = regexp(folders, ';', 'split');
    % Find the asv files in the found folders
    asvFiles = cell(0);
    for iFolder = 1:numel(folders)
        files = dir(fullfile(folders{iFolder},'*.asv'));
        nFiles = numel(files);
        for iFile = 1:nFiles
            asvFiles{end+1} = [folders{iFolder} filesep files(iFile).name]; 
        end
    end
    % Clear the asv files
    for iAsvFile = 1:numel(asvFiles)
        delete(asvFiles{iAsvFile});
    end
end