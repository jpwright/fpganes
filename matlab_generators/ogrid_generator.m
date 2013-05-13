n = 11;

fprintf('assign oGrid = {');
for j = 1:n
    for k = 1:n
        fprintf(['line', int2str(j), '[', int2str(640-k), ']']);
        if (j ~= n || k ~= n)
            fprintf(',');
        end
    end
    if (j ~= n)
        fprintf('\n');
    end
end
fprintf('};');