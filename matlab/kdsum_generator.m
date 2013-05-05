n = 11;
text = 'brick_edge';

numbits = ceil(log2((n^2)+1));
fprintf('\nwire [');
fprintf(int2str(numbits-1));
fprintf([':0] kd_', text, '_sum_r = ']);

for j = 1:(n^2)
    fprintf(['kd_', text, '_r[', int2str(n^2 - j), ']']);
    if (j ~= n^2)
        fprintf(' + ');
    else
        fprintf(';');
    end
end

fprintf('\nwire [');
fprintf(int2str(numbits-1));
fprintf([':0] kd_', text, '_sum_g = ']);

for j = 1:(n^2)
    fprintf(['kd_', text, '_g[', int2str(n^2 - j), ']']);
    if (j ~= n^2)
        fprintf(' + ');
    else
        fprintf(';');
    end
end

fprintf('\nwire [');
fprintf(int2str(numbits-1));
fprintf([':0] kd_', text, '_sum_b = ']);

for j = 1:(n^2)
    fprintf(['kd_', text, '_b[', int2str(n^2 - j), ']']);
    if (j ~= n^2)
        fprintf(' + ');
    else
        fprintf(';');
    end
end

fprintf('\n\n');

