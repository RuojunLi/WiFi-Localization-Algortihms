function P = particlefilter(obv_rss,ref_rss,sigma)
G_dis = @(v) (1/(sqrt(2*pi)*sigma))*exp((-1/(2*sigma^2))*v.^2);
N_OBV = size(obv_rss,1);
RSS_DIF = obv_rss-ref_rss;
P = G_dis(RSS_DIF)/G_dis(0); 

for i=1:N_OBV
P_norm(i,:) = P(i,:)/sum(P(i,:));
end 

end