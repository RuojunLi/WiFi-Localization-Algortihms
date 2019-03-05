function RSS_SIGNT = pathlossmodel(d,AP_CRD,penalty)
%zci = @(v) find(v(:).*circshift(v(:), [-1 0]) <= 0);         
%model C
dbp = 10;
sigma =8;
alpha1 = 2.5; 
alpha2 = 4;
N = size(d,2);
%T0 = [-10,-10,-10,-10,-10,-10];
T0 = 10; 
%L0 = [41.4,41.4,41.4,41.4,41.4,41.4];
L0 = 41.4;
pathloss1 = @(v) L0 +10*alpha1*log10(v);
pathloss2 = @(v) L0 + 10*alpha1*log10(dbp)+10*alpha2*log10(v/dbp);
d_less = find(d<dbp);
d_more = find(d>=dbp);
for i=d_less
Lp(i) = pathloss1(d(i));
end
for i=d_more
Lp(i) = pathloss2(d(i))+penalty;
end
RSS_SIGNT = T0 - Lp; 

end