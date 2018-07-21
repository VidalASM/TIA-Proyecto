image_folder = 'all-mias';
filenames = dir(fullfile(image_folder, '*.pgm'));
total_images = numel(filenames);
%97,133,137,138,143,151,152,154,155,175,191,195,200,206,218,234,254,280,287
%11,12
%S=7;
%S=15;
S=32;%%varia
cont=2;

for n = cont:cont
%n=2;
    full_name= fullfile(image_folder, filenames(n).name);%nombres completos         
    our_images = imread(full_name); 
    
    [mask,img] = preprosesar(our_images);%%desde aca inicia
    
    primerPrepro = immultiply(mask,img);

    [lado , posInicial] = getside(mask); %0 I, 1 D usado para poner seed

    if(lado==0)
        posInicialX = posInicial+20;
        posInicialY = 100;%%cambiar por el sticker

    else
        posInicialX = posInicial-20;
        posInicialY = 100;

    end
    %32
    J=regiongrowing(img,posInicialY,posInicialX,S);
    mask2 = imsubtract(mask,J);
    semiMask = preprosesarMask(mask2); %point 4
    %%hallar las cordenadas x y y iniciales para crear recta
    if(lado==0)
        py1 = posInicialY;
        px1 = find(semiMask(py1,:), 1, 'first');%a la izquierda
        
        px2 = posInicialX;
        py2 = find(semiMask(:,px2)',1,'first');
        
    else
        py1 = posInicialY;
        px1 = (1024 - find(wrev(semiMask(py1,:)), 1, 'first'))+1;%a la derecha
        
        px2 = posInicialX;
        py2 = find(semiMask(:,px2)',1,'first');
    end
    
    %%%%%%%%%%%%%%Recta%%%%%%%%%%%%%%%
  
    
    %    pend = (py2-py1)/(px2-px1);

     %   puntosX = px1:px2;
     %   yy = puntosX*pend - px1*pend + py1;
     %   puntosY = floor(yy);
     %   tam=size(puntosY);

      %  for i=1:tam(2)
       %    semiMask(puntosY(i),puntosX(i)) = 1;
        %   for j=1:10
         %   if(lado ==0)
          %      semiMask(puntosY(i),puntosX(i)+j) = 1;
           %     semiMask(puntosY(i)+j,puntosX(i)+j) = 1;
                
           %     semiMask(puntosY(i),puntosX(i)-j) = 0;
           %     semiMask(puntosY(i)+j,puntosX(i)-j) = 0;
            %else
           %     semiMask(puntosY(i),puntosX(i)-j) = 1;
           %     semiMask(puntosY(i)+j,puntosX(i)-j) = 1;
                
           %     semiMask(puntosY(i),puntosX(i)+j) = 0;
           %     semiMask(puntosY(i)+j,puntosX(i)+j) = 0;
              
           % end
           %end
           
       % end       
    
   Mascara = preprosesarMask(semiMask); %final mask
   
   finalPrepro = immultiply(Mascara,primerPrepro);
   
   %[lado , posInicial] = getside(mask); %0 I, 1 D usado para poner seed
   
   %%%%Recortar lados%%%%
   %%%%get position%%%
   posInicial2=1;
   if (lado==1)
      for i=1:1024
        ssm = sum(finalPrepro(:,i));
        if(ssm>0)
           posInicial2 = i; 
           break
        end
      end
   else
       for i=1024:-1:1
        ssm = sum(finalPrepro(:,i));
        if(ssm>0)
           posInicial2 = i; 
           break
        end
      end
   end
   
   imgFinal=0;
   imgNormalCut=0;
   imgMask=0;
   if(lado==1)      
     imgFinal = finalPrepro(1:1024,posInicial2:posInicial);
     imgNormalCut = our_images(1:1024,posInicial2:posInicial);
     imgMask = Mascara(1:1024,posInicial2:posInicial);
     
   else
     imgFinal = finalPrepro(1:1024,posInicial:posInicial2); 
     imgNormalCut = our_images(1:1024,posInicial:posInicial2); 
     imgMask = Mascara(1:1024,posInicial:posInicial2); 
   end
   
   %lado
   %lado2
   %filenames(n).name
   %token = strtok(filenames(n).name,'.')
   
   %imwrite(Mascara, strcat('mask4/mask',int2str(n),'.jpg')) 
   %imwrite(primerPrepro, strcat('imgfinal/',strtok(filenames(n).name,'.'),'.jpg')) 
   imwrite(imgNormalCut, strcat('imgfinal/',strtok(filenames(n).name,'.'),'.pgm')) 
   imwrite(imgMask, strcat('mascaras/',strtok(filenames(n).name,'.'),'.pgm')) 
   
    
end
%imshowpair(imgFinal,finalPrepro,'montage')
imshowpair(imgFinal,primerPrepro,'montage')

 %   imshowpair(img,semiMask,'montage')
    %imshowpair(mask,semiMask,'montage')
    
    
    %area = [posInicialX,posInicialY];
    %filei = 2;
    
    %X = 0;
    %Y = 0;
    
    %Radio = 1;
    
    %Result=zeros(1024,1024);
    
    %%%%%%%%%%%%%Pos originales%%%%%%%%%%%%%%%%%%%%
    
    %estaTodo = true;
    
    
    
    %{
    while(estaTodo==true)
       recorridoX = X + Radio;
       recorridoY = Y + Radio;
       
       S = 32;
       
       estaTodo = false;
        
       for i=recorridoY:-1:0
               
               if(recorridoX==0 || i==0)
                    if((recorridoX+posInicialX<=1024&&recorridoX+posInicialX>=1)&&(i+posInicialY<=1024&&i+posInicialY>=1))
                        if(abs(img(recorridoX+posInicialX,i+posInicialY)- media(area,img))<S)
                            area(filei,:)=[recorridoX+posInicialX,i+posInicialY];
                            
                            Result(recorridoX+posInicialX,i+posInicialY)=1;
                            
                            filei=filei+1;
                            estaTodo = true;
                        end
                        
                        if(abs(img(i+posInicialY,recorridoX+posInicialX)- media(area,img))<S)
                            area(filei,:)=[i+posInicialY,recorridoX+posInicialX];
                            
                            Result(i+posInicialY,recorridoX+posInicialX)=1;
                            
                            filei=filei+1;
                            estaTodo = true;
                        end
                    end
                    
                    if((-recorridoX+posInicialX<=1024&&-recorridoX+posInicialX>=1)&&(-i+posInicialY<=1024&&-i+posInicialY>=1))
                        if(abs(img(-recorridoX+posInicialX,-i+posInicialY)- media(area,img))<S)
                            area(filei,:)=[-recorridoX+posInicialX,-i+posInicialY];
                            
                            Result(-recorridoX+posInicialX,-i+posInicialY)=1;
                            
                            filei=filei+1;
                            estaTodo = true;
                        end
                        
                        if(abs(img(-i+posInicialY,-recorridoX+posInicialX)- media(area,img))<S)
                            area(filei,:)=[-i+posInicialY,-recorridoX+posInicialX];
                            
                            Result(-i+posInicialY,-recorridoX+posInicialX)=1;
                            
                            filei=filei+1;
                            estaTodo = true;
                        end
                    end
                    
                    
                    
               elseif (recorridoX==i)
                   if((recorridoX+posInicialX<=1024&&recorridoX+posInicialX>=1)&&(i+posInicialY<=1024&&i+posInicialY>=1))
                        if(abs(img(recorridoX+posInicialX,i+posInicialY)- media(area,img))<S)
                            area(filei,:)=[recorridoX+posInicialX,i+posInicialY];
                            
                            Result(recorridoX+posInicialX,i+posInicialY)=1;
                            
                            filei=filei+1;
                            estaTodo = true;
                        end
                   end
                   
                   if((-recorridoX+posInicialX<=1024&&-recorridoX+posInicialX>=1)&&(-i+posInicialY<=1024&&-i+posInicialY>=1))
                        if(abs(img(-recorridoX+posInicialX,-i+posInicialY)- media(area,img))<S)
                    %        D1=-recorridoX+posInicialX
                    %        D2=-i+posInicialY
                            
                            area(filei,:)=[-recorridoX+posInicialX,-i+posInicialY];
                            
                            Result(-recorridoX+posInicialX,-i+posInicialY)=1;
                            
                            filei=filei+1;
                            estaTodo = true;
                        end
                   end
                    
                   if((recorridoX+posInicialX<=1024&&recorridoX+posInicialX>=1)&&(-i+posInicialY<=1024&&-i+posInicialY>=1))
                         if(abs(img(recorridoX+posInicialX,-i+posInicialY)- media(area,img))<S)
                            area(filei,:)=[recorridoX+posInicialX,-i+posInicialY];
                            
                            Result(recorridoX+posInicialX,-i+posInicialY)=1;
                            
                            filei=filei+1;
                            estaTodo = true;
                         end
                   end
                   
                   if((-recorridoX+posInicialX<=1024&&-recorridoX+posInicialX>=1)&&(i+posInicialY<=1024&&i+posInicialY>=1))
                         if(abs(img(-recorridoX+posInicialX,i+posInicialY)- media(area,img))<S)
                            area(filei,:)=[-recorridoX+posInicialX,i+posInicialY];
                            
                            Result(-recorridoX+posInicialX,i+posInicialY)=1;
                            
                            filei=filei+1;
                            estaTodo = true;
                         end  
                   end

               else
                   if((recorridoX+posInicialX<=1024&&recorridoX+posInicialX>=1)&&(i+posInicialY<=1024&&i+posInicialY>=1))
                        if(abs(img(recorridoX+posInicialX,i+posInicialY)- media(area,img))<S)
                            area(filei,:)=[recorridoX+posInicialX,i+posInicialY];
                            
                            Result(recorridoX+posInicialX,i+posInicialY)=1;
                            
                            filei=filei+1;
                            estaTodo = true;
                        end
                   end
                      
                   if((recorridoX+posInicialX<=1024&&recorridoX+posInicialX>=1)&&(-i+posInicialY<=1024&&-i+posInicialY>=1))
                        if(abs(img(recorridoX+posInicialX,-i+posInicialY)- media(area,img))<S)
                            area(filei,:)=[recorridoX+posInicialX,-i+posInicialY];
                            
                            Result(recorridoX+posInicialX,-i+posInicialY)=1;
                            
                            filei=filei+1;
                            estaTodo = true;
                        end
                   end
                      
                   if((-recorridoX+posInicialX<=1024&&-recorridoX+posInicialX>=1)&&(i+posInicialY<=1024&&i+posInicialY>=1))
                        if(abs(img(-recorridoX+posInicialX,i+posInicialY)- media(area,img))<S)
                            area(filei,:)=[-recorridoX+posInicialX,i+posInicialY];
                            
                            Result(-recorridoX+posInicialX,i+posInicialY)=1;
                            
                            filei=filei+1;
                            estaTodo = true;
                        end
                   end
                      
                   if((recorridoX+posInicialX<=1024&&recorridoX+posInicialX>=1)&&(i+posInicialY<=1024&&i+posInicialY>=1))
                        if(abs(img(i+posInicialY,recorridoX+posInicialX)- media(area,img))<S)
                            area(filei,:)=[i+posInicialY,recorridoX+posInicialX];
                            
                            Result(i+posInicialY,recorridoX+posInicialX)=1;
                            
                            filei=filei+1;
                            estaTodo = true;
                        end
                   end
                        
                   if((-recorridoX+posInicialX<=1024&&-recorridoX+posInicialX>=1)&&(i+posInicialY<=1024&&i+posInicialY>=1))
                        if(abs(img(i+posInicialY,-recorridoX+posInicialX)- media(area,img))<S)
                            area(filei,:)=[i+posInicialY,-recorridoX+posInicialX];
                            
                            Result(i+posInicialY,-recorridoX+posInicialX)=1;
                            
                            filei=filei+1;
                            estaTodo = true;
                        end
                   end
                      
                   if((recorridoX+posInicialX<=1024&&recorridoX+posInicialX>=1)&&(-i+posInicialY<=1024&&-i+posInicialY>=1))
                        if(abs(img(-i+posInicialY,recorridoX+posInicialX)- media(area,img))<S)
                            area(filei,:)=[-i+posInicialY,recorridoX+posInicialX];
                            
                            Result(-i+posInicialY,recorridoX+posInicialX)=1;
                            
                            filei=filei+1;
                            estaTodo = true;
                        end
                   end
                    
                   if((-recorridoX+posInicialX<=1024&&-recorridoX+posInicialX>=1)&&(-i+posInicialY<=1024&&-i+posInicialY>=1))
                        if(abs(img(-recorridoX+posInicialX,-i+posInicialY)- media(area,img))<S)
                            area(filei,:)=[-recorridoX+posInicialX,-i+posInicialY];
                            
                            Result(-recorridoX+posInicialX,-i+posInicialY)=1;
                            
                            filei=filei+1;
                            estaTodo = true;
                        end
                   end
                      
                   if((-recorridoX+posInicialX<=1024&&-recorridoX+posInicialX>=1)&&(-i+posInicialY<=1024&&-i+posInicialY>=1))
                        if(abs(img(-i+posInicialY,-recorridoX+posInicialX)- media(area,img))<S)
                            area(filei,:)=[-i+posInicialY,-recorridoX+posInicialX];
                            
                            Result(-i+posInicialY,-recorridoX+posInicialX)=1;
                            
                            filei=filei+1;
                            estaTodo = true;
                        end
                   end

               end
           
       end
        
        Radio=Radio+1;
        
        
        end
    %}

%imshowpair(img,reNoise(:,:,2),'montage')




