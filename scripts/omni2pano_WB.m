% Proceso Omnidireccional-Panorámica-W/B para Imágenes Test/Training

% Cargar Imágenes Omnidireccionales
directorioC = 'Saarbrücken_Omni_Cloudy/' ; directorio_Pano_TestC = 'Saarbrücken_Pano_Test_Cloudy/';
directorioN = 'Saarbrücken_Omni_Night/' ; directorio_Pano_TestN = 'Saarbrücken_Pano_Test_Night/';
directorioS = 'Saarbrücken_Omni_Sunny/' ; directorio_Pano_TestS = 'Saarbrücken_Pano_Test_Sunny/';
directorio_Pano_TrainC = 'Saarbrücken_Pano_Training_Cloudy/';

todas_imagesC = dir(strcat(directorioC,'*.jpeg'));
todas_imagesN = dir(strcat(directorioN,'*.jpeg'));
todas_imagesS = dir(strcat(directorioS,'*.jpeg'));
muestreo = 5; % Para training al menos 1 de cada 5

% Convertir a Panoramic_TestC
for i = 1:size(todas_imagesC,1)  
    
    if exist(sprintf('%s%s',directorio_Pano_TestC,todas_imagesC(i).name)) == 0 %no exist in dataset
        i; %Si no existe en Dataset, no hacer nada 
    else
        i = i+1;
    end   
    
    image_i = rgb2gray(imread(sprintf('%s%s',directorioC,todas_imagesC(i).name)));
    omni_recortada = image_i(6:476,95:570);
    [Cx,Cy] = size(omni_recortada);
    Cx = Cx/2; Cy = Cy/2;
    panoramica = omni2panoramic(omni_recortada,Cx,Cy);
    imwrite(panoramica,sprintf('%s%s',directorio_Pano_TestC,todas_imagesC(i).name));
    
end

% Convertir a Panoramic_TestN
for i = 1:size(todas_imagesN,1)  
    
    if exist(sprintf('%s%s',directorio_Pano_TestN,todas_imagesN(i).name)) == 0 %no exist in dataset
        i; %Si no existe en Dataset, no hacer nada 
    else
        i = i+1;
    end   
    
    image_i = rgb2gray(imread(sprintf('%s%s',directorioN,todas_imagesN(i).name)));
    omni_recortada = image_i(6:476,95:570);
    [Cx,Cy] = size(omni_recortada);
    Cx = Cx/2; Cy = Cy/2;
    panoramica = omni2panoramic(omni_recortada,Cx,Cy);
    imwrite(panoramica,sprintf('%s%s',directorio_Pano_TestN,todas_imagesN(i).name));
    
end

% Convertir a Panoramic_TestS
for i = 1:size(todas_imagesS,1)  
    
    if exist(sprintf('%s%s',directorio_Pano_TestS,todas_imagesS(i).name)) == 0 %no exist in dataset
        i; %Si no existe en Dataset, no hacer nada 
    else
        i = i+1;
    end   
    
    image_i = rgb2gray(imread(sprintf('%s%s',directorioS,todas_imagesS(i).name)));
    omni_recortada = image_i(6:476,95:570);
    [Cx,Cy] = size(omni_recortada);
    Cx = Cx/2; Cy = Cy/2;
    panoramica = omni2panoramic(omni_recortada,Cx,Cy);
    imwrite(panoramica,sprintf('%s%s',directorio_Pano_TestS,todas_imagesS(i).name));
    
end

% Convertir a Panoramic_TrainingC
for i = 1:muestreo:size(todas_imagesC,1)  
    
    if exist(sprintf('%s%s',directorio_Pano_TrainC,todas_imagesC(i).name)) == 0 %no exist in dataset
        i; %Si no existe en Dataset, no hacer nada 
    else
        i = i+1;
    end   
    
    image_i = rgb2gray(imread(sprintf('%s%s',directorioC,todas_imagesC(i).name)));
    omni_recortada = image_i(6:476,95:570);
    [Cx,Cy] = size(omni_recortada);
    Cx = Cx/2; Cy = Cy/2;
    panoramica = omni2panoramic(omni_recortada,Cx,Cy);
    imwrite(panoramica,sprintf('%s%s',directorio_Pano_TrainC,todas_imagesC(i).name));
    
end