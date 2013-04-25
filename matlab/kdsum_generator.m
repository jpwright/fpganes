n = 11;

numbits = ceil(log2((n^2)+1));
fprintf('wire [');
fprintf(int2str(numbits-1));
fprintf(':0] kd_sum = ');

for j = 1:(n^2)
    fprintf(['kd[', int2str(n^2 - j), ']']);
    if (j ~= n^2)
        fprintf(' + ');
    else
        fprintf(';');
    end
end
