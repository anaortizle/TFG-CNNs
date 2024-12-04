% Cargar imágenes Cloudy Omnidireccionales

% TODAS LAS IMÁGENES SE GUARDAN MENOS LAS ROTACIONES

% meter imágenes en escala de grises y luego efecto de iluminación y por
% último recortar y pasar a pano

directorioC = 'Saarbrücken_Omni_Cloudy/' ; directorio_Rotaciones_TestC = 'Saarbrücken_Rotaciones_Test_Cloudy/';

todas_imagesC = dir(strcat(directorioC,'*.jpeg'));

cte = 14; % 512 / 36 = 14,22 píxeles --> aproximación de 14 píxeles

for i = 1:size(todas_imagesC,1)  
    
    if exist(sprintf('%s%s',directorio_Rotaciones_TestC,todas_imagesC(i).name)) == 0 %no exist in dataset
        i; %Si no existe en Dataset, no hacer nada 
    else
        i = i+1;
    end   
        
    image_i = rgb2gray(imread(sprintf('%s%s',directorioC,todas_imagesC(i).name)));
    omni_recortada = image_i(6:476,95:570);
    [Cx,Cy] = size(omni_recortada);
    Cx = Cx/2; Cy = Cy/2;
    panoramica = omni2panoramic(omni_recortada,Cx,Cy);

    j = ceil(35*rand);
    image_rot = circshift(panoramica,j*cte,2);
    
    imwrite(image_rot,sprintf('%s%s',directorio_Rotaciones_TestC,todas_imagesC(i).name));
   
end

% La imagen panorámicaWB tiene 512 píxeles en su base que corresponden a un rango de [0º,360º].
% Tomar una rotación aleatoria de la imagen cada grado nos parece obtener mucha información de cada
% imagen, por lo que reduciremos esta toma de datos a una rotación aleatoria de la imagen cada 10º,
% esto implica que ya no obtendríamos 360 muestras, sino que serán 36.
% Al notar que la IPWB está formada por 512 píxeles en su base, y sabiendo que tomaremos un número
% total de muestras de 36, tendremos por tanto que tomar una muestra cada 14 píxeles.

