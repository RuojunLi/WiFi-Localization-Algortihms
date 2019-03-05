clear,close all
open('map_floor3.fig')
N = 3;

door1 = [55,22.2;56,22.2];
door2 = [55.3,24.2;56.5,24.2];
door3 = [9.7,24.2;11,24.2];
door = {door1,door2,door3};
for i=1:N
    door_temp = door{i};
    ax = gca;
    ax.ColorOrderIndex = 2;
    H(i) = plot(door_temp(:,1),door_temp(:,2),'LineWidth',5);
end
for i = [1,N]
set(get(get(H(i),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
end
staircase1 = [51.5,25];

for i=1:5
w = 0.5;
h = 3; 
ax = gca;
ax.ColorOrderIndex = 2;
rectangle('Position',[staircase1(1)+0.5*i,staircase1(2)+0.5*i,w,h],'LineWidth',2)
end
staircase2 = [13.5,25];
for i=1:5
w = 0.5;
h = 3; 
ax = gca;
ax.ColorOrderIndex = 2;
rectangle('Position',[staircase2(1)-0.5*i,staircase2(2)+0.5*i,w,h],'LineWidth',2)
end

staircase3 = [16,0.5];
for i=1:5
w = 0.5;
h = 3; 
ax = gca;
ax.ColorOrderIndex = 2;
rectangle('Position',[staircase3(1)-0.5*i,staircase3(2)+0.5*i,w,h],'LineWidth',2)
end

staircase4 = [16,0.5];
for i=1:5
w = 0.5;
h = 3; 
ax = gca;
ax.ColorOrderIndex = 2;
rectangle('Position',[staircase3(1)-0.5*i,staircase3(2)+0.5*i,w,h],'LineWidth',2)
end

elavator = [15.5,15];
rectangle('Position',[elavator(1),elavator(2),2,3],'LineWidth',3)
text(elavator(1)+0.7,elavator(2)+1.7,'E','FontSize',15)
title('AK 3^{rd} Floor','FontSize',30)