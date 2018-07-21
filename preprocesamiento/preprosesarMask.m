function [newbina] = preprosesarMask(bina)
    f = bwlabel(bina);%Etiqueto elementos en la imagen mama y elementos opacos
    g = regionprops(logical(f),'Area');%obtengo las areas de los elementos
    %obtengo el area del elemento mas grande (mama)
    v=[g.Area];
    M=max(v);

    %obtengo una imagen con el objeto mas grande
    BW2 = bwareaopen(bina, M);

    %remover pixeles aislados
    BW3 = bwmorph(BW2,'clean');

    %suavizar el ruido visible
    BW4 = bwmorph(BW3,'majority');

    %erosionar
    SE = strel('disk', 5);%objeto strel
    erodedBW = imerode(BW4,SE);

    %dilatar
    dilatedBW = imdilate(erodedBW,SE);

    %llenar hoyos usar para la extraccion del musculo pectoral
    newbina = imfill(dilatedBW,'holes');
end