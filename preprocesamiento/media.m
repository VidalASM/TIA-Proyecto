function M = media(Area,Img) 
    t=size(Area);
    suma=0;
    for i=1:1:t(1)
        suma=suma+Img(Area(i,1),Area(i,2));
    end

    M = suma/t(2);
end