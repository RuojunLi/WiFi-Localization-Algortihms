function d = distance(crd1,crd2)
N1 = size(crd1,1);
N2 = size(crd2,1);

for i=1:N1
temp1 = crd1(i,:);
    for j = 1:N2
        temp2 = crd2(j,:);
        d(i,j) = sqrt((temp1(1)-temp2(1))^2+(temp1(2)-temp2(2))^2);
    end
end
end