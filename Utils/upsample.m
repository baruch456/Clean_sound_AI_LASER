%מעלה כפול 4 

% Load an example WAV file
[inputAudio, originalFs] = audioread('13.wav');

% Define the upsampling factor and new sample rate
upsamplingFactor = 4;
newFs = originalFs * upsamplingFactor;

% Create original and new time vectors
tOriginal = (0:length(inputAudio) - 1) / originalFs;
tNew = (0:(upsamplingFactor * (length(inputAudio) - 1))) / newFs;

% Interpolate to upsample
outputAudio = interp1(tOriginal, inputAudio, tNew, 'linear'); % Linear interpolation

% Write the interpolated audio to a new WAV file
audiowrite('13_upsampled_interp.wav', outputAudio, newFs);

disp('Audio file has been upsampled and saved as "output_upsampled_interp.wav".');

%-----------------------------------------------------------------
%הקוד הסופי מפה

% Set the folder where the recordings are located
folderPath = 'C:\Users\oror8\Downloads\ForSync\ForSync'; % Change this to your actual folder path

% Define the upsampling factor
upsamplingFactor = 4;

% List of filename patterns to process
filePatterns = {'dpos1', 'dpos2', 'pos1', 'pos2'};

% Loop through the specified range and file patterns
for i = 558:567
    for pattern = filePatterns
        % Construct the filename
        fileName = sprintf('%d_%s.wav', i, pattern{1});
        fullFilePath = fullfile(folderPath, fileName);

        % Check if the file exists
        if exist(fullFilePath, 'file')
            try
                % Load the original WAV file
                [inputAudio, originalFs] = audioread(fullFilePath);

                % Calculate the new sample rate after upsampling
                newFs = originalFs * upsamplingFactor; % New sample rate

                % Create original and upsampled time vectors
                tOriginal = (0:length(inputAudio) - 1) / originalFs;
                tNew = linspace(tOriginal(1), tOriginal(end), upsamplingFactor * length(inputAudio)); % Alternative time vector creation

                % Interpolate to upsample
                outputAudio = interp1(tOriginal, inputAudio, tNew, 'linear'); % Linear interpolation

                % Construct the output filename with "_upsampled" suffix
                outputFileName = sprintf('%d_%s_upsampled.wav', i, pattern{1});
                outputFullFilePath = fullfile(folderPath, outputFileName);

                % Write the upsampled audio to a new WAV file
                audiowrite(outputFullFilePath, outputAudio, newFs);

                % Inform that the file has been processed
                disp(['File "', fileName, '" has been upsampled and saved as "', outputFileName, '".']);
            catch ME
                disp(['Error processing file "', fileName, '": ', ME.message]);
            end
        else
            disp(['File "', fileName, '" does not exist in the specified folder.']);
        end
    end
end
