function distance = inverse_pathloss(RSS,penalty)
dbp = 10;
alpha1 = 2.5; 
alpha2 = 4;
T0 = 10; 
L0 = 41.4;

pathloss1 = @(v) L0 +10*alpha1*log10(v);
pathloss2 = @(v) L0 + 10*alpha1*log10(dbp)+10*alpha2*log10(v/dbp);

rss_dbp = T0-pathloss1(dbp);

pl_less = find(RSS>=rss_dbp);
pl_more = find(RSS<rss_dbp);


pathloss_d1 = @(v) 10^((T0-v-L0)/(10*alpha1));
pathloss_d2 = @(v) dbp*10^((rss_dbp-v-penalty)/(10*alpha2));

for i=pl_less
distance(i) = pathloss_d1(RSS(i));
end
for i=pl_more
distance(i) = pathloss_d2(RSS(i));
end
end