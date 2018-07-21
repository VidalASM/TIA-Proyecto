function [bina,pre] = preprosesar(our_images)
    Threshold=18;
    reNoise = zeros(1024,1024,1);
    
    reNoise(:,:,1) = medfilt2(our_images);
  
    BW = imbinarize(reNoise(:,:,1),Threshold);
    
    bina = preprosesarMask(BW);
%{
    f = bwlabel(BW);%Etiqueto elementos en la imagen mama y elementos opacos
    g = regionprops(logical(f),'Area');%obtengo las areas de los elementos
    %obtengo el area del elemento mas grande (mama)
    v=[g.Area];
    M=max(v);

    %obtengo una imagen con el objeto mas grande
    BW2 = bwareaopen(BW, M);

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
    bina = imfill(dilatedBW,'holes');
%}
    %generar fotos
    pre = immultiply(bina,reNoise(:,:,1));

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
end