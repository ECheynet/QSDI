function [S,scale_labels] = QSDI(supervisorName, studentName, varargin)
% QSDI  Computes the supervisor–doctoral student interaction (QSDI) profile.
%
%   S = QSDI(supervisorName, studentName) reads two CSV or Excel files
%   containing responses from a supervisor and a doctoral student,
%   respectively. It calculates the median response per interpersonal
%   category defined by the QSDI framework (Mainhard et al., 2009).
%
%   S = QSDI(supervisorName, studentName, 'randomize', true) runs the
%   function in *testing mode*, replacing all responses with random
%   integers from 1 to 5. This can be used to test the structure and
%   functionality of the code without using actual data.
%
%   INPUT ARGUMENTS:
%       supervisorName : string or char
%           Path or filename of the supervisor response table (e.g. 'supervisor.csv').
%           The table must include a variable named 'scale_code' and a response column
%           in the 3rd position.
%
%       studentName : string or char
%           Path or filename of the student response table (e.g. 'student.csv').
%           The table must include the same structure as the supervisor table.
%
%   OPTIONAL NAME-VALUE PAIR:
%       'randomize' : logical (default = false)
%           If true, the supervisor and student responses are replaced by
%           random integers between 1 and 5 for testing purposes.
%
%   OUTPUT:
%       S : 2-by-N numeric matrix
%           Median category scores for supervisor (row 1) and student (row 2),
%           where N is the number of interpersonal categories (8 by default).
%
%   DESCRIPTION:
%       The QSDI model (Questionnaire on Supervisor–Doctoral Student Interaction)
%       is based on Mainhard et al. (2009), which builds upon Wubbels et al.'s
%       interpersonal behavior model. It characterizes the supervisor–student
%       relationship along eight categories representing interpersonal dimensions:
%
%           {'DC','CD','CS','SC','SO','OS','OD','DO'}
%
%       Each category corresponds to a distinct interaction type in the
%       supervisor–doctoral student communication model.
%
%   EXAMPLE:
%       % Example 1: Normal use
%       S = QSDI('supervisor.xlsx', 'student.xlsx');
%
%       % Example 2: Testing with random data
%       S = QSDI('supervisor.xlsx', 'student.xlsx', 'randomize', true);
%
%   REFERENCES:
%       Mainhard, T., van der Rijst, R., van Tartwijk, J., & Wubbels, T. (2009).
%       A model for the supervisor–doctoral student relationship.
%       *Higher Education, 58*, 359–373. doi:10.1007/s10734-009-9199-8
%
%   See also: READTABLE, MEDIAN, FIND, RANDI
%
% Author: E. Cheynet UiB (2025-10-10)


% Parse optional arguments
p = inputParser;
addParameter(p, 'randomize', false, @(x)islogical(x) || isnumeric(x));
parse(p, varargin{:});
randomize = logical(p.Results.randomize);

% Read tables
Tsu = readtable(supervisorName); % Supervisor
Tst = readtable(studentName);    % Student

% Apply randomization if requested
if randomize
    Tsu{:,3} = randi([1,5], size(Tsu{:,3},1), 1);
    Tst{:,3} = randi([1,5], size(Tst{:,3},1), 1);
end

% Extract responses
respSupervisor = Tsu{:,3};  % Supervisor responses
respStudent = Tst{:,3};  % Student responses
responses = [respSupervisor(:), respStudent(:)]';

% Define categories
scale_labels = {'DC','CD','CS','SC','SO','OS','OD','DO'};
Nlabel = numel(scale_labels);

% Locate indices for each scale in the supervisor table
for ii = 1:Nlabel
    idx.(scale_labels{ii}) = find(strcmpi(Tsu.scale_code, scale_labels{ii}))';
end

% Compute median per category
S = zeros(size(responses,1), Nlabel);
for ii = 1:size(responses,1)
    x = responses(ii,:);
    for jj = 1:Nlabel
        S(ii,jj) = mean(x(idx.(scale_labels{jj})), 'omitnan');
    end
end

end
