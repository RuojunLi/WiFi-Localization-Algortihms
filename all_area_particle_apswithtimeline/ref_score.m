function score = ref_score(particle_signt,ref_rss) 
sigma = 5;
G_dis = @(v) (1/(sqrt(2*pi)*sigma))*exp((-1/(2*sigma^2))*v.^2);

N_ref = size(ref_rss,1);


for i=1:N_ref
    RSS_DIF = particle_signt-ref_rss(i,:);
    P(i,:) = G_dis(RSS_DIF)/G_dis(0); 
end
end