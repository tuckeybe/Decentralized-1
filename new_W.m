function newW = new_W(W, n)
    newW = W;
    row = floor(rand * n + 1);
    col = floor(rand * n + 1);
    newW(row, col) = 0;
    row_sum = sum(newW(row, :));
    for j = 1:n
        if (j ~= col)
            newW(row, j) = W(row, j) / row_sum; %fix row
        end
    end
    
    %disp(W)
    %disp(newW)
end
           
           