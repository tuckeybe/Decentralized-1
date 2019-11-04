function b=tridiag(n)
vector=[1/3 1/3 1/3];
b = zeros(n);
b(1,1)=1/3;
b(1,2)=1/3;
b(1,n)=1/3;
b(n,:)=flip(b(1,:));

for i=2:(n-1)
    for j=1:n
        if i==j+1
            b(i,j)=vector(1);
        elseif i==j
            b(i,j)=vector(2);
        elseif i==j-1
            b(i,j)=vector(3);
        end
    end
       
end
end
            