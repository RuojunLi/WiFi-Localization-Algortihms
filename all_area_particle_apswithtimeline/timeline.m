function weight = timeline(weight_org,est)
weight = zeros(size(weight_org));
%weight = weight_org;
range = 10;
gap = 0.5;
num = range/gap;
start_x = est(1) - range/2;
start_y = est(2) - range/2;
for i=0:num
    for j = 0:num
        order = i*num+j+1;
        %test(order,:) = [start_x+i*gap,start_y+j*gap];
        particle_near_temp = findparticle(start_x+i*gap,start_y+j*gap);
        if isempty(particle_near_temp)
            particle_near(order) = particle_near(order-1);
        else
            particle_near(order) = particle_near_temp;
        end
    end
end
weight(particle_near,:) = weight_org(particle_near,:);

end