function[descriptor_tr_resnet50] = descriptor_training_resnet50(capa,canal)

% Cargar imágenes entrenamiento
directorio_Training = 'Saarbrücken_Pano_Training_Cloudy/';

todas_imagesTraining = dir(strcat(directorio_Training,'*.jpeg'));

% CNN
net = resnet50();

% Descriptor training
for i = 1:size(todas_imagesTraining,1)
   
    descriptor_imagen = [];
    image_training = imread(sprintf('%s%s',directorio_Training,todas_imagesTraining(i).name)); 
    image_training = imresize(image_training,[224 224]);
    image_training = image_training(:,:,[1 1 1]);     
    descriptor_training = activations(net,image_training,capa);
    descriptor_training = descriptor_training(:,:,canal);  
    for j = 1:size(descriptor_training,1)
        
        descriptor_imagen = [descriptor_imagen descriptor_training(j,:)];
        
    end
    
    descriptor_tr_resnet50(i,:) = descriptor_imagen;
    
end
