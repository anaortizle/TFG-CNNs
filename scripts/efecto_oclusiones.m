% Cargar imágenes Cloudy Omnidireccionales

% TODAS LAS IMÁGENES SE GUARDAN MENOS LAS ROTACIONES

% meter imágenes en escala de grises y luego efecto de iluminación y por
% último recortar y pasar a pano

directorioC = 'Saarbrücken_Omni_Cloudy/' ; directorio_Oclusiones_TestC = 'Saarbrücken_Oclusiones_Test_Cloudy/';

todas_imagesC = dir(strcat(directorioC,'*.jpeg'));

for i = 1:size(todas_imagesC,1)  
    
    if exist(sprintf('%s%s',directorio_Oclusiones_TestC,todas_imagesC(i).name)) == 0 %no exist in dataset
        i; %Si no existe en Dataset, no hacer nada 
    else
        i = i+1;
    end   
    
    image_i = rgb2gray(imread(sprintf('%s%s',directorioC,todas_imagesC(i).name)));
    omni_recortada = image_i(6:476,95:570);
    [Cx,Cy] = size(omni_recortada);
    Cx = Cx/2; Cy = Cy/2;
    panoramica = omni2panoramic(omni_recortada,Cx,Cy);
    % El efecto de oclusiones lo realizaremos una vez tengamos la panorámica, ya que de hacerlo en
    % su forma omnidireccional perderíamos algunas oclusiones y eso no nos favorece en los cálculos
    media = mean(mean(panoramica));
    panoramica(36:71,321:392) = media;
    panoramica(80:98,143:241) = media;
    panoramica(20:36,121:207) = media;
    imwrite(panoramica,sprintf('%s%s',directorio_Oclusiones_TestC,todas_imagesC(i).name));
   
end
