% Cargar imágenes entrenamiento
directorio_Training = 'Saarbrücken_Pano_Training_Cloudy/';

todas_imagesTraining = dir(strcat(directorio_Training,'*.jpeg'));

% Cargar imágenes test Cloudy
directorio_Cloudy = 'Saarbrücken_Pano_Test_Cloudy/';

todas_imagesCloudy = dir(strcat(directorio_Cloudy,'*.jpeg'));

% Cargar imágenes test Sunny
directorio_Sunny = 'Saarbrücken_Pano_Test_Sunny/';

todas_imagesSunny = dir(strcat(directorio_Sunny,'*.jpeg'));

% Cargar imágenes test Night
directorio_Night = 'Saarbrücken_Pano_Test_Night/';

todas_imagesNight = dir(strcat(directorio_Night,'*.jpeg'));

%Coordenadas Training
coordenadas_tr = zeros(size(todas_imagesTraining,1),2);
for i=1:size(todas_imagesTraining,1)
    
    [x y] = coordenadas(todas_imagesTraining(i).name);
    coordenadas_tr(i,:)= [x y];
    
end

save(sprintf('%sCoordenadas_Tr.mat',directorio_Training),'coordenadas_tr');

%Coordenadas TestC
coordenadas_C = zeros(size(todas_imagesCloudy,1),2);
for i=1:size(todas_imagesCloudy,1)
    
    [x y] = coordenadas(todas_imagesCloudy(i).name);
    coordenadas_C(i,:)= [x y];
    
end

save(sprintf('%sCoordenadas_C.mat',directorio_Cloudy),'coordenadas_C');

%Coordenadas TestN
coordenadas_N = zeros(size(todas_imagesNight,1),2);
for i=1:size(todas_imagesNight,1)
    
    [x y] = coordenadas(todas_imagesNight(i).name);
    coordenadas_N(i,:)= [x y];
    
end

save(sprintf('%sCoordenadas_N.mat',directorio_Night),'coordenadas_N');

%Coordenadas TestS
coordenadas_S = zeros(size(todas_imagesSunny,1),2);
for i=1:size(todas_imagesSunny,1)
    
    [x y] = coordenadas(todas_imagesSunny(i).name);
    coordenadas_S(i,:)= [x y];
    
end

save(sprintf('%sCoordenadas_S.mat',directorio_Sunny),'coordenadas_S');


