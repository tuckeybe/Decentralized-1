function yourcell = new_matrix(n)
    yourcell = cell(n+3,1);
    first = tridiag(n);
    yourcell{1} = first;
    
    % special case, last column goes back to first column
    second = first;
    second(1, :) = 0;
    second(2, :) = 0;
    second(1, 1) = 2/3;
    second(1, n) = 1/3;
    second(2, 2) = 1/3;
    second(2, 3) = 1/3;
    yourcell{2} = second;
    
    % n
    special1 = first;
    special1(n-1, :) = 0;
    special1(n, :) = 0;
    special1(n-1, n-1) = 2/3;
    special1(n-1, n-2) = 1/3;
    special1(n, 1) = 1/3;
    special1(n, n) = 1/3;
    yourcell{n} = special1;
    
    % special case, last line goes back to first line
    second_last = first;
    second_last(1, :) = 0;
    second_last(n, :) = 0;
    second_last(n, n) = 2/3;
    second_last(n, n-1) = 1/3;
    second_last(1, 1) = 1/3;
    second_last(1, 2) = 1/3;
    yourcell{n+1} = second_last;
 
    % connection fixed, all elements are 1/n
    last = ones(n) / n;
    yourcell{n+2} = last;
    
    % last matrix, goes back to original state
    yourcell{n+3} = first;
    
    for i=3:n-1
        New_mat = first;
        New_mat(i-1, :) = 0;
        New_mat(i, :) = 0;
        New_mat(i-1,i-1) = 2/3;
        New_mat(i-1,i-2)=1/3;
        New_mat(i,i)=1/3;
        New_mat(i,i+1)=1/3;
        yourcell{i} = New_mat;
    end
    
end
