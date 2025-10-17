function [summaryTable, promptText] = postprocess_QSDI(S, scale_labels)
%POSTPROCESS_QSDI  Prepare QSDI results for LLM interpretation.
%
%   [summaryTable, promptText] = postprocess_QSDI(S_pair, scale_labels)
%   Applies a 0.25 significance threshold between supervisor and student
%   scores, flags agreements vs. differences, and builds a formatted text
%   block you can feed directly to ChatGPT.
%
%   Inputs:
%     S_pair        - struct from QSDI() containing fields .supervisor and .student (1x8)
%     scale_labels  - cell array of 8 labels, e.g. {'DC','CD','CS','SC','SO','OS','OD','DO'}
%
%   Outputs:
%     summaryTable  - MATLAB table listing both scores, their difference,
%                     and whether it's 'Agreement' or 'Difference'
%     promptText    - preformatted text block for ChatGPT input

    THRESH = 0.34;  % significance threshold

    sup = S(1,:);
    stu = S(2,:);
    diff = abs(sup - stu);
    status = repmat("Agreement", size(diff));
    status(diff > THRESH) = "Difference";

    summaryTable = table(scale_labels(:), sup(:), stu(:), diff(:), status(:), ...
        'VariableNames', {'Scale','Supervisor','Student','Difference','Status'});

    % Build compact text for the LLM prompt
    lines = strings(length(scale_labels),1);
    for k = 1:length(scale_labels)
        lines(k) = sprintf('%s: %s (Supervisor %.2f vs Student %.2f, Δ=%.2f)', ...
            scale_labels{k}, status(k), sup(k), stu(k), diff(k));
    end
    promptText = strjoin(lines, newline);
end
