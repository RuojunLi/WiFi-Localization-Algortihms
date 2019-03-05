function estimation = plotActivity(Weight,particle_crd,train_crd,ann1,dot_num,delay)

    pred_good = [0 0.7 0.3];
    pred_bad = [1 0 0];
    thrhld = 0.1;
    Predict = find(Weight>=2);
    if ~isempty(Predict) p(1) = plot(particle_crd(Predict,1),particle_crd(Predict,2),'*','color',[1,0.9,0.9]); end

    Predict = find(Weight>=4);
    if ~isempty(Predict) thrhld = 2;p(2) = plot(particle_crd(Predict,1),particle_crd(Predict,2),'*','color',[1,0.5,0.5]); end
    
    Predict = find(Weight>=8);
    if ~isempty(Predict) thrhld = 1;p(3) = plot(particle_crd(Predict,1),particle_crd(Predict,2),'*','color',[1,0.2,0.2]); end
    
    Predict = find(Weight>=22);
    if ~isempty(Predict) thrhld = 1;p(4) = plot(particle_crd(Predict,1),particle_crd(Predict,2),'*','color',[0,0,0]); end
    
    plot(train_crd(1),train_crd(2),'o','MarkerFaceColor',[0,1,0])
    Predict_Highest = find(Weight>=max(Weight)-thrhld);
    Predict_crd = [particle_crd(Predict_Highest,1),particle_crd(Predict_Highest,2)];
    Predict_n = size(Predict_crd,1);
    for i=1:Predict_n
        Predict_temp = Predict_crd(i,:);
        
        orderx = find(particle_crd(:,1)==Predict_temp(1)-0.5|particle_crd(:,1)==Predict_temp(1)|particle_crd(:,1)==Predict_temp(1)+0.5|particle_crd(:,1)==Predict_temp(1)-1|particle_crd(:,1)==Predict_temp(1)+1|particle_crd(:,1)==Predict_temp(1)-1.5|particle_crd(:,1)==Predict_temp(1)+1.5|particle_crd(:,1)==Predict_temp(1)-2.5|particle_crd(:,1)==Predict_temp(1)+2.5);
        ordery = find(particle_crd(:,2)==Predict_temp(2)-0.5|particle_crd(:,2)==Predict_temp(2)|particle_crd(:,2)==Predict_temp(2)+0.5|particle_crd(:,2)==Predict_temp(2)-1|particle_crd(:,2)==Predict_temp(2)+1|particle_crd(:,2)==Predict_temp(2)-1.5|particle_crd(:,2)==Predict_temp(2)+1.5|particle_crd(:,2)==Predict_temp(2)-2.5|particle_crd(:,2)==Predict_temp(2)+2.5);
        order = intersect(orderx,ordery);
        
        Weight_area(i) = sum(Weight(order));
        
        Estimation_x(i) = sum(particle_crd(order,1).*Weight(order)/sum(Weight(order)));
        Estimation_y(i) = sum(particle_crd(order,2).*Weight(order)/sum(Weight(order)));
    end
    est_choose = find(Weight_area == max(Weight_area));
    estimation = [mean(Estimation_x(est_choose))',mean(Estimation_y(est_choose))'];
    dme = distance(estimation,train_crd);
    if dme>10 
        predclr = pred_bad; 
    else
        predclr = pred_good;
    end
    %plot(particle_crd(High_area,1),particle_crd(High_area,2),'o','MarkerSize',5);
    plot(estimation(1),estimation(2),'o','MarkerSize',5,'MarkerFaceColor',[1,0,0]);
    set(ann1,'String',['Predicted Activity   : ' num2str(dot_num) '   DME :' num2str(dme)],'BackgroundColor',predclr);
    pause(delay)
    delete(p)
end