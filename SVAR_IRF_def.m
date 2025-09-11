% ------------------ Version 1 ------------------
% y = [output_a, price, interest_rate, assets, housing, borrowing]
% shorthand: y, \pi, i, fa, nfa, d
vars_v1 = {'y','\pi','i','fa','nfa','d'};
title_IRF_v1 = cell(1,36);
idx = 1;
for r = 1:6
    for c = 1:6
        % r = shock  c = response
        title_IRF_v1{idx} = ['$' vars_v1{r} ' \rightarrow ' vars_v1{c} '$'];
        idx = idx + 1;
    end
end

% ------------------ Version 2 ------------------
% y = [output_a, price, interest_rate, borrowing, assets, housing]
vars_v2 = {'y','\pi','i','d','fa','nfa'};
title_IRF_v2 = cell(1,36);
idx = 1;
for r = 1:6
    for c = 1:6
        title_IRF_v2{idx} = ['$' vars_v2{r} ' \rightarrow ' vars_v2{c} '$'];
        idx = idx + 1;
    end
end

% ------------------ Version 3 ------------------
% y = [output_a, price, interest_rate, assets, borrowing, housing]
vars_v3 = {'y','\pi','i','fa','d','nfa'};
title_IRF_v3 = cell(1,36);
idx = 1;
for r = 1:6
    for c = 1:6
        title_IRF_v3{idx} = ['$' vars_v3{r} ' \rightarrow ' vars_v3{c} '$'];
        idx = idx + 1;
    end
end

% ------------------ Version 4 ------------------
% y = [assets, housing, borrowing, output_a, price, interest_rate]
vars_v4 = {'fa','nfa','d','y','\pi','i'};
title_IRF_v4 = cell(1,36);
idx = 1;
for r = 1:6
    for c = 1:6
        title_IRF_v4{idx} = ['$' vars_v4{r} ' \rightarrow ' vars_v4{c} '$'];
        idx = idx + 1;
    end
end
