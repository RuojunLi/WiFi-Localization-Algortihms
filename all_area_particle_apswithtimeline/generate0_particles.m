clear,close all
%% create the particles coordination on the whole floor

open('map_floor3_blueprint.fig')

load('map')
x_max = max(building(:,1));
x_min = min(building(:,1));
y_max = max(building(:,2));
y_min = min(building(:,2));

x_blank = [0,12.3;19.4,44.8;52.3,64.2];
y_blank = [0,6.9;29.9,46.2;0,6.9];
gap = 0.5;

particle_x = 0:gap:x_max;
particle_y = 0:gap:y_max;

nx = size(particle_x,2);
ny = size(particle_y,2);
    
particle_x = repmat(particle_x,[ny,1]);
particle_x = reshape(particle_x,[nx*ny,1]);
particle_y = repmat(particle_y,[1,nx]);
particle_crd = [particle_x,particle_y'];
N_P = size(particle_x,2); 

drop_x = ceil(x_blank(1,1)):gap:floor(x_blank(1,2));
drop_y = ceil(y_blank(1,1)):gap:floor(y_blank(1,2));

nx = size(drop_x,2);
ny = size(drop_y,2);
drop_x = repmat(drop_x,[1,ny]);
drop_x = reshape(drop_x,[nx*ny,1]);
drop_y = repmat(drop_y,[1,nx]);
drop_crd = [drop_x,drop_y'];

drop_x = ceil(x_blank(2,1)):gap:floor(x_blank(2,2));
drop_y = ceil(y_blank(2,1)):gap:floor(y_blank(2,2));

nx = size(drop_x,2);
ny = size(drop_y,2);
drop_x = repmat(drop_x,[1,ny]);
drop_x = reshape(drop_x,[nx*ny,1]);
drop_y = repmat(drop_y,[1,nx]);
drop_crd = [drop_crd;drop_x,drop_y'];

drop_x = ceil(x_blank(3,1)):gap:floor(x_blank(3,2));
drop_y = ceil(y_blank(3,1)):gap:floor(y_blank(3,2));

nx = size(drop_x,2);
ny = size(drop_y,2);
drop_x = repmat(drop_x,[1,ny]);
drop_x = reshape(drop_x,[nx*ny,1]);
drop_y = repmat(drop_y,[1,nx]);
drop_crd = [drop_crd;drop_x,drop_y'];

%plot(drop_crd(:,1),drop_crd(:,2),'o')
N_DROP = size(drop_crd,1);
[flag,idx] = ismember(particle_crd,drop_crd,'rows');
particle_crd(flag==1,:) = [];
plot(particle_crd(:,1),particle_crd(:,2),'o');   
