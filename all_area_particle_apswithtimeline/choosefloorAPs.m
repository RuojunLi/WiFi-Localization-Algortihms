function [RSS_REF,RSS_OBV]=choosefloorAPs(N_AP,floor_bssid,floor_order,BSSID,RSS_MOV,rss_ref)

N_bssid = size(floor_bssid,1);
N_trainbssid = size(RSS_MOV,2);
N_trainlocation =size(RSS_MOV,1);
N_ref = size(rss_ref,2);
%N_train_floor3 = 0;
flag_floor = zeros(1,N_trainbssid);
flag_order = zeros(1,N_trainbssid);
j=0;
for i =1:N_trainbssid
    if(find(BSSID(i) == floor_bssid))
        j = j+1;
        flag_floor(i) = 1;
        order_temp = find(BSSID(i) == floor_bssid);
        flag_order(i) = floor_order(order_temp);
    end
end

FLAG_REF = find(flag_floor==1);
RSS_ORDER = flag_order(FLAG_REF);

for i = 1:N_trainlocation
RSS_TEMP = RSS_MOV(i,FLAG_REF);
RSS_OBV(i,RSS_ORDER) = RSS_TEMP;
end

RSS_OBV(RSS_OBV==0)=-100;
%}
for i = 1:N_ref
    RSS_REF_TEMP = rss_ref{1,i};
    RSS_REF_TEMP = RSS_REF_TEMP(:,FLAG_REF);
    RSS_REF_TEMP = mean(RSS_REF_TEMP,1);
    RSS_REF(i,RSS_ORDER) = RSS_REF_TEMP;
end
end
