clear,close all
%%H(6) is the first plot in the main_kernel 

%% Load all data
load('allnorm_data')
load('FLAG_floor3_2each')
open('map_floor3_blueprint.fig')
load('points_crd')
load('ap_crd')

%%choose bar:
draw_train = 1;       %draw_train: 1 draw train;0 not draw train
P_discnt_std = -100;   %To replace the 0(disconnected bssid rss) by P_discnt_std

%%initialize 
num_bssid = size(BSSID,1);
num_location = size(RSS_MOV,1);
num_ref = size(RSS_REF,2);
ref_train_order = [1,23,40,62,78];
K = 4;
N = 4; 
sigma = 8;
FLAG_TEMP = FLAG_REF;


%legend('Building and lobby on the AK 3rd floor','reference dots','moving track','APs Position')
%open('map_floor3.fig')
open('map_floor3_blueprint.fig')



%% ON EACH LOCATION DURING TRACKING HAVE AN ESTIMATION based on the observation rss and reference rss
%use flag find the present floor rss 
flag_order_temp = flag_order(FLAG_TEMP);
for i=1:num_ref
    RSS_TEMP = RSS_REF{i};
    RSS_REF_FLOOR3{i} = RSS_TEMP(:,FLAG_REF);
end
for i=1:num_location
    RSS_OBV(i,:) = RSS_MOV(i,FLAG_TEMP);
end

for i=1:num_location
    [w(i,:),M(i)] = kernel(RSS_REF_FLOOR3,RSS_OBV(i,:),flag_order_temp,K,P_discnt_std,sigma);
    ker_est_x(i) = sum(w(i,:)' .* ref_point(:,1));
    ker_est_y(i) = sum(w(i,:)' .* ref_point(:,2));
end


%% Draw Part
figure(2)

H(6) = plot(ker_est_x(1:23),ker_est_y(1:23),'o--','color','r','MarkerSize',5);hold on
H(7) = plot(ker_est_x(23:40),ker_est_y(23:40),'o--','color','k','MarkerSize',5);hold on
H(8) = plot(ker_est_x(40:62),ker_est_y(40:62),'o--','color','r','MarkerSize',5);hold on
H(9) = plot(ker_est_x(62:78),ker_est_y(62:78),'o--','color','k','MarkerSize',5);hold on

plot(ker_est_x(ref_train_order),ker_est_y(ref_train_order),'o','color','r','MarkerFaceColor',[1,0,0],'MarkerSize',10)

plot(ker_est_x(1),ker_est_y(1),'o','color','r','MarkerFaceColor',[0,1,0]),hold on
plot(ker_est_x(num_location),ker_est_y(num_location),'o','color','r','MarkerFaceColor',[1,1,0]),hold on


%% DME Caculation
for i =1:num_location
    dme(i) = sqrt((train_point(i,1)-ker_est_x(i))^2+(train_point(i,2)-ker_est_y(i))^2);
end
figure(), plot(dme,'k','LineWidth',3),hold on,title('DME Result','FontSize',20)
DME_kernel = sum(dme);
legend(num2str(DME_kernel))

%% legend set
figure(2)
for i = [7:9]
     set(get(get(H(i),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
end
legend('Building and lobby on the AK 3rd floor','reference dots','moving track','kenerl algorithm estimation','The estimation of 4 Refernece dots','Start','End')
if(draw_train==1)
H(10) = plot(train_point(1:23,1),train_point(1:23,2),'*','color','r','MarkerSize',3);hold on
H(11) = plot(train_point(23:40,1),train_point(23:40,2),'*','color','k','MarkerSize',3);hold on
H(12) = plot(train_point(40:62,1),train_point(40:62,2),'*','color','r','MarkerSize',3);hold on
H(13) = plot(train_point(62:78,1),train_point(62:78,2),'*','color','k','MarkerSize',3);hold on
for i = [11:13]
     set(get(get(H(i),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
end
legend('Building and lobby on the AK 3rd floor','reference dots','moving track','APs Position','DOOR','kenerl algorithm estimation','The estimation of 4 Refernece dots','Estimation Start','Estimation End','train dots')
end
text(train_point(ref_train_order(1),1)-5,train_point(ref_train_order(1),2)+2,'\leftarrow Counterclock Direction')
text(train_point(ref_train_order(1),1)+1,train_point(ref_train_order(1),2),'Start Point')
title({'AK 3^{rd} Floor';['Standard Deviation is ', num2str(sigma)]},'FontSize',20)
axis([-3,70,-3,52]);
%% To optimize the estimation of kernel algorithm, use particle filter
%% Using the Third Floor APs coordinations,  




