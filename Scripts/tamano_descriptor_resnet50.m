directorio_Cloudy = 'Saarbrücken_Pano_Test_Cloudy/';

todas_images = dir(strcat(directorio_Cloudy,'*.jpeg'));

% A continuación se creará la red con la que estaremos trabajando junto con
net = resnet50();

%Rellenar con el mejor canal de cada capa
layer_name = {'conv1','res2a_branch2a','res3a_branch2a','res4a_branch2a','res5a_branch2a'};
best_channel = [17,8,74,20,113];

capa = 5;
canal = best_channel(capa);

descriptor_C = [];
image = imread(sprintf('%s%s',directorio_Cloudy,todas_images(1).name));
image = imresize(image,[224 224]);
image = image(:,:,[1 1 1]);
            
d_ConvC = activations(net,image,layer_name{capa});
d_ConvC = d_ConvC(:,:,canal);

       for j = 1:size(d_ConvC,1)
                descriptor_C = [descriptor_C d_ConvC(j,:)];
       end
       