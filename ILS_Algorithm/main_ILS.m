clear,close all
%%%%%%%%%%%%%%%
%% load data
fig = open('map_floor3_blueprint.fig'),hold on;
ax1 = gca;
legend('off')
load('map')
load('allnorm_data')
load('floor3APsnum2')
load('ap_crd')
load('points_crd')
ann1 = annotation(fig,'textbox',[ax1.Position(1:3) 0.04],...
    'String','Num.NA','FontSize',12,'FitBoxToText','off',...
    'BackgroundColor',[0 0.7 0.3],'HorizontalAlignment','Center','VerticalAlignment','middle','FaceAlpha',0.5);

AP_N = max(floor3order);
ref_N = size(ref_crd,1);
BSSID_N = size(floor3bssid,1);
MOV_N = size(RSS_MOV,1);  
penalty = 10;

[RSS_REF,RSS_MOV] = choosefloorAPs(AP_N,floor3bssid,floor3order,BSSID,RSS_MOV,RSS_REF);
start_x = 35;
start_y = 15;
for i = 1:MOV_N 
    RSS_temp = RSS_MOV(i,:);
    Distance = inverse_pathloss(RSS_temp,penalty);
    [est_x(i),est_y(i)] = ILS(AP_CRD,start_x,start_y,Distance);
    dme(i) = distance(train_crd(i,:),[est_x(i),est_y(i)]);
    start_x = est_x(i);
    start_y = est_y(i);
end
est_ILS = [est_x',est_y'];
plot(est_x,est_y,'o--')
mean(dme)
std(dme)