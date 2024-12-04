% Cargar imágenes Cloudy Omnidireccionales

% TODAS LAS IMÁGENES SE GUARDAN MENOS LAS ROTACIONES

% meter imágenes en escala de grises y luego efecto de iluminación y por
% último recortar y pasar a pano

directorioC = 'Saarbrücken_Omni_Cloudy/' ; directorio_Blur_TestC = 'Saarbrücken_Blur_Test_Cloudy/';

todas_imagesC = dir(strcat(directorioC,'*.jpeg'));

for i = 1:size(todas_imagesC,1)  
    
    if exist(sprintf('%s%s',directorio_Blur_TestC,todas_imagesC(i).name)) == 0 %no exist in dataset
        i; %Si no existe en Dataset, no hacer nada 
    else
        i = i+1;
    end   
    
    image_i = rgb2gray(imread(sprintf('%s%s',directorioC,todas_imagesC(i).name)));
    
    LEN = 10; % Longitud del movimiento
    % Nosotros supondremos un movimiento aleatorio desde 0º hasta 359º
    THETA = 359*rand; % Ángulo de movimiento en sentido contrario a las manecillas del reloj
    PSF = fspecial('motion',LEN,THETA);
    image_i = imfilter(image_i,PSF,'conv','circular');
    omni_recortada = image_i(6:476,95:570);
    [Cx,Cy] = size(omni_recortada);
    Cx = Cx/2; Cy = Cy/2;
    panoramica = omni2panoramic(omni_recortada,Cx,Cy);
    imwrite(panoramica,sprintf('%s%s',directorio_Blur_TestC,todas_imagesC(i).name));
    
end
