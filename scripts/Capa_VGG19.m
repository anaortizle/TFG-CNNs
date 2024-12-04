% Cálculo del mejor canal de cada capa de la CNN - VGG19 (conv1_1/conv2_1/conv3_1/conv4_1/conv5_1) por el
% cual se obtiene un mejor resultado en la localización

tic

directorio_Cloudy = 'Saarbrücken_Pano_Test_Cloudy/';
directorio_Night = 'Saarbrücken_Pano_Test_Night/';
directorio_Sunny = 'Saarbrücken_Pano_Test_Sunny/';
directorio_Training = 'Saarbrücken_Pano_Training_Cloudy/';

todas_imagesCloudy = dir(strcat(directorio_Cloudy,'*.jpeg'));
todas_imagesNight = dir(strcat(directorio_Night,'*.jpeg'));
todas_imagesSunny = dir(strcat(directorio_Sunny,'*.jpeg'));
todas_imagesTraining = dir(strcat(directorio_Training,'*.jpeg'));

% A continuación se creará la red con la que estaremos trabajando
net = vgg19();

% Cargamos los resultados de las coordenadas de posición de Tr y C,N,S
load(sprintf('%sCoordenadas_Tr',directorio_Training));
load(sprintf('%sCoordenadas_C',directorio_Cloudy));
load(sprintf('%sCoordenadas_N',directorio_Night));
load(sprintf('%sCoordenadas_S',directorio_Sunny));

layer_name = {'conv1_1','conv2_1','conv3_1','conv4_1','conv5_1'};

% Cálculo del parámetro error para C
num_canales = [64 128 256 512 512];
fila = 1; columnas = 8;
matriz_parametrosCNNVGG19Cloudy = zeros(fila,columnas);

for capa = 1:5
    for canal = 1:num_canales(capa)
        descriptor_tr_VGG19 = descriptor_training_VGG19(layer_name{capa},canal);
        m = 0;
        for i = 1:2:size(todas_imagesCloudy,1)
            m = m + 1;
            descriptor_C = [];
            image = imread(sprintf('%s%s',directorio_Cloudy,todas_imagesCloudy(i).name));
            image = imresize(image,[224 224]);
            image = image(:,:,[1 1 1]);
            
            tic
            d_ConvC = activations(net,image,layer_name{capa});
            d_ConvC = d_ConvC(:,:,canal);
            for j = 1:size(d_ConvC,1)
                descriptor_C = [descriptor_C d_ConvC(j,:)];
            end
            
            tiempo_dConvTC(m) = toc;
            
            tic
            pdist2_dConvC = pdist2(descriptor_C,descriptor_tr_VGG19(:,:),'cosine');
            [~,posicion] = min(pdist2_dConvC);
            posicion_estimada_dConvC(m,:) = coordenadas_tr(posicion,:);
            tiempoestimado_dConvTC(m) = toc;
            
            posicion_real_dConvC(m,:) = coordenadas_C(i,:);
            error_posicion_dConvC(m) = pdist2(posicion_estimada_dConvC(m,:),posicion_real_dConvC(m,:),'euclidean');
        end
        e_m_dConvTC = mean(error_posicion_dConvC);
        e_v_dConvTC = var(error_posicion_dConvC);
        
        t_m_dConvTC = mean(tiempo_dConvTC);
        t_v_dConvTC = var(tiempo_dConvTC);

        t_est_m_dConvTC = mean(tiempoestimado_dConvTC);
        t_est_v_dConvTC = var(tiempoestimado_dConvTC);
        
        matriz_parametrosCNNVGG19Cloudy(fila,:) = [capa,canal,e_m_dConvTC,e_v_dConvTC,t_m_dConvTC,t_v_dConvTC,t_est_m_dConvTC,t_est_v_dConvTC];
        fila = fila + 1;
        save(sprintf('%sMatrizResultadosCNNVGG19_dConvC.mat',directorio_Cloudy),'matriz_parametrosCNNVGG19Cloudy');
    end
end

% Obtención de los resultados mínimos entre todos los canales de la capa 'conv1_1'
[e_m_Conv1TC,pos_min_emConv1TC] = min(matriz_parametrosCNNVGG19Cloudy(1:64,3));

canal_Conv1TC = matriz_parametrosCNNVGG19Cloudy(pos_min_emConv1TC,2);
e_v_Conv1TC = matriz_parametrosCNNVGG19Cloudy(pos_min_emConv1TC,4);
t_m_Conv1TC = matriz_parametrosCNNVGG19Cloudy(pos_min_emConv1TC,5);
t_v_Conv1TC = matriz_parametrosCNNVGG19Cloudy(pos_min_emConv1TC,6);
t_est_m_Conv1TC = matriz_parametrosCNNVGG19Cloudy(pos_min_emConv1TC,7);
t_est_v_Conv1TC = matriz_parametrosCNNVGG19Cloudy(pos_min_emConv1TC,8);

% Obtención de los resultados mínimos entre todos los canales de la capa 'conv2_1'
[e_m_Conv2TC,pos_min_emConv2TC] = min(matriz_parametrosCNNVGG19Cloudy(65:192,3));
pos_min_emConv2TC = pos_min_emConv2TC + 64;

canal_Conv2TC = matriz_parametrosCNNVGG19Cloudy(pos_min_emConv2TC,2);
e_v_Conv2TC = matriz_parametrosCNNVGG19Cloudy(pos_min_emConv2TC,4);
t_m_Conv2TC = matriz_parametrosCNNVGG19Cloudy(pos_min_emConv2TC,5);
t_v_Conv2TC = matriz_parametrosCNNVGG19Cloudy(pos_min_emConv2TC,6);
t_est_m_Conv2TC = matriz_parametrosCNNVGG19Cloudy(pos_min_emConv2TC,7);
t_est_v_Conv2TC = matriz_parametrosCNNVGG19Cloudy(pos_min_emConv2TC,8);

% Obtención de los resultados mínimos entre todos los canales de la capa 'conv3_1'
[e_m_Conv3TC,pos_min_emConv3TC] = min(matriz_parametrosCNNVGG19Cloudy(193:448,3));
pos_min_emConv3TC = pos_min_emConv3TC + 192;

canal_Conv3TC = matriz_parametrosCNNVGG19Cloudy(pos_min_emConv3TC,2);
e_v_Conv3TC = matriz_parametrosCNNVGG19Cloudy(pos_min_emConv3TC,4);
t_m_Conv3TC = matriz_parametrosCNNVGG19Cloudy(pos_min_emConv3TC,5);
t_v_Conv3TC = matriz_parametrosCNNVGG19Cloudy(pos_min_emConv3TC,6);
t_est_m_Conv3TC = matriz_parametrosCNNVGG19Cloudy(pos_min_emConv3TC,7);
t_est_v_Conv3TC = matriz_parametrosCNNVGG19Cloudy(pos_min_emConv3TC,8);

% Obtención de los resultados mínimos entre todos los canales de la capa 'conv4_1'
[e_m_Conv4TC,pos_min_emConv4TC] = min(matriz_parametrosCNNVGG19Cloudy(449:960,3));
pos_min_emConv4TC = pos_min_emConv4TC + 448;

canal_Conv4TC = matriz_parametrosCNNVGG19Cloudy(pos_min_emConv4TC,2);
e_v_Conv4TC = matriz_parametrosCNNVGG19Cloudy(pos_min_emConv4TC,4);
t_m_Conv4TC = matriz_parametrosCNNVGG19Cloudy(pos_min_emConv4TC,5);
t_v_Conv4TC = matriz_parametrosCNNVGG19Cloudy(pos_min_emConv4TC,6);
t_est_m_Conv4TC = matriz_parametrosCNNVGG19Cloudy(pos_min_emConv4TC,7);
t_est_v_Conv4TC = matriz_parametrosCNNVGG19Cloudy(pos_min_emConv4TC,8);

% Obtención de los resultados mínimos entre todos los canales de la capa 'conv5_1'
[e_m_Conv5TC,pos_min_emConv5TC] = min(matriz_parametrosCNNVGG19Cloudy(961:1472,3));
pos_min_emConv5TC = pos_min_emConv5TC + 960;

canal_Conv5TC = matriz_parametrosCNNVGG19Cloudy(pos_min_emConv5TC,2);
e_v_Conv5TC = matriz_parametrosCNNVGG19Cloudy(pos_min_emConv5TC,4);
t_m_Conv5TC = matriz_parametrosCNNVGG19Cloudy(pos_min_emConv5TC,5);
t_v_Conv5TC = matriz_parametrosCNNVGG19Cloudy(pos_min_emConv5TC,6);
t_est_m_Conv5TC = matriz_parametrosCNNVGG19Cloudy(pos_min_emConv5TC,7);
t_est_v_Conv5TC = matriz_parametrosCNNVGG19Cloudy(pos_min_emConv5TC,8);

tiempo_final = toc;