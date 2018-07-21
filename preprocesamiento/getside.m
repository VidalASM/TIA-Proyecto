function [y,pos] = getside(imagen)
    %L = imagen(:,382:386);
    %R = imagen(:,894:898);
    
    ref = imagen(512,:);
    posL = find(ref, 1, 'first');%a la izquierda
    posR = (1024 - find(wrev(ref), 1, 'first'))+1;%a la derecha
    
    L = imagen(:,posL);
    R = imagen(:,posR);
    
    SL = sum(sum(L));
    SR = sum(sum(R));
    
    if(SL>SR)
       y = 0; %izquierda
       pos = posL;
    else
        y = 1; %derecha
        pos = posR;
    end
end