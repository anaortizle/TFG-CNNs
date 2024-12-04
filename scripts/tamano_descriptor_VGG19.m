directorio_Cloudy = 'Saarbrücken_Pano_Test_Cloudy/';

todas_images = dir(strcat(directorio_Cloudy,'*.jpeg'));

% A continuación se creará la red con la que estaremos trabajando junto con
net = vgg19();

%Rellenar con el mejor canal de cada capa
layer_name = {'conv1_1','conv2_1','conv3_1','conv4_1','conv5_1'};
best_channel = [37,124,228,260,284];

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
       