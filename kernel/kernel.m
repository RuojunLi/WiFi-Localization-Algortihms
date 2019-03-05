function [weight,M] = kernel(RSS_REF,RSS_OBV,flag_order,K,DISCNT,sigma)

AP_HIGH_ORDER = [5,6];
AP_LOW_ORDER = [1,2,3,4];
AP_HIGH = 1;
AP_LOW = 1;
num_flag_order = size(flag_order,2);
for i=1:num_flag_order
    if find(flag_order(i) == AP_HIGH_ORDER)
        AP_WEIGHT(i) = AP_HIGH;
    end
    if find(flag_order(i) == AP_LOW_ORDER)
        AP_WEIGHT(i) = AP_LOW;
    end
end
num_bssid = size(RSS_OBV,2);
num_ref = size(RSS_REF,2);
flag_temp = ones(1,num_bssid);
flag_temp(RSS_OBV==DISCNT) = 0;
for i = 1:num_ref
    flag_ref = ones(1,num_bssid);
    ref_temp = RSS_REF{i};
    ref_mean = mean(ref_temp(1:K,:));
    flag_ref(ref_mean==DISCNT) = 0;
    FLAG(i,:) = flag_ref.*flag_temp;
end
for i = 1:num_ref
   flag_temp = find(FLAG(i,:)==1);
   rss_obv = RSS_OBV(flag_temp);
   rss_temp = RSS_REF{i};
   rss_ref = rss_temp(1:K,flag_temp);
   ap_weight_temp = AP_WEIGHT(flag_temp);
   M = size(flag_temp,2);
   K_gauss = 0;
   for m = 1:M     
        for k=1:K     
            p_temp(k) = ap_weight_temp(m)*(rss_obv(m)-rss_ref(k,m))^2;
        end
        p_temp_sum = sum(p_temp);
        K_gauss(m) = 1/((sqrt(2*pi)*sigma)^K)*exp(-1*p_temp_sum/(2*sigma ^2));
   end
   P(i) = sum(K_gauss)/M;
end
P_ALL = sum(P);
for i=1:num_ref
    weight(i) = P(i)/P_ALL;
end
end
