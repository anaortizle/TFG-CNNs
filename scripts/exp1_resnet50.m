directorio_Cloudy = 'Saarbrücken_Pano_Test_Cloudy/';
directorio_Night = 'Saarbrücken_Pano_Test_Night/';
directorio_Sunny = 'Saarbrücken_Pano_Test_Sunny/';
directorio_Training = 'Saarbrücken_Pano_Training_Cloudy/';

todas_imagesCloudy = dir(strcat(directorio_Cloudy,'*.jpeg'));
todas_imagesNight = dir(strcat(directorio_Night,'*.jpeg'));
todas_imagesSunny = dir(strcat(directorio_Sunny,'*.jpeg'));
todas_imagesTraining = dir(strcat(directorio_Training,'*.jpeg'));

% A continuación se creará la red con la que estaremos trabajando junto con
net = resnet50();

% Cargamos los resultados de las coordenadas de posición de Tr y C,N,S
load(sprintf('%sCoordenadas_Tr',directorio_Training));
load(sprintf('%sCoordenadas_C',directorio_Cloudy));
load(sprintf('%sCoordenadas_N',directorio_Night));
load(sprintf('%sCoordenadas_S',directorio_Sunny));

%Rellenar con el mejor canal de cada capa
layer_name = {'conv1','res2a_branch2a','res3a_branch2a','res4a_branch2a','res5a_branch2a'};
best_channel = [17,8,74,20,113];

% Cálculo de los parámetros tiempo y error para C
fila = 1; columnas = 8;
exp1matriz_parametrosCNNresnet50Cloudy = zeros(fila,columnas);

for capa = 1:5
        canal = best_channel(capa);
        descriptor_tr_resnet50 = descriptor_training_resnet50(layer_name{capa},canal);
        for i = 1:size(todas_imagesCloudy,1)
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
            
            tiempo_dConvTC(i) = toc;
            
            tic
            pdist2_dConvC = pdist2(descriptor_C,descriptor_tr_resnet50(:,:),'cosine');
            [~,posicion] = min(pdist2_dConvC);
            posicion_estimada_dConvC(i,:) = coordenadas_tr(posicion,:);
            tiempoestimado_dConvTC(i) = toc;
            
            posicion_real_dConvC(i,:) = coordenadas_C(i,:);
            error_posicion_dConvC(i) = pdist2(posicion_estimada_dConvC(i,:),posicion_real_dConvC(i,:),'euclidean');
        end
        e_m_dConvTC = mean(error_posicion_dConvC);
        e_v_dConvTC = var(error_posicion_dConvC);
        
        t_m_dConvTC = mean(tiempo_dConvTC);
        t_v_dConvTC = var(tiempo_dConvTC);

        t_est_m_dConvTC = mean(tiempoestimado_dConvTC);
        t_est_v_dConvTC = var(tiempoestimado_dConvTC);
        
        exp1matriz_parametrosCNNresnet50Cloudy(fila,:) = [capa,canal,e_m_dConvTC,e_v_dConvTC,t_m_dConvTC,t_v_dConvTC,t_est_m_dConvTC,t_est_v_dConvTC];
        fila = fila + 1;
        save(sprintf('%sExp1MatrizResultadosCNNresnet50_dConvC.mat',directorio_Cloudy),'exp1matriz_parametrosCNNresnet50Cloudy');
end

% Obtención de los resultados mínimos en el mejor canal de la capa 'conv1'
canal_Conv1TC = exp1matriz_parametrosCNNresnet50Cloudy(1,2);
e_m_Conv1TC = exp1matriz_parametrosCNNresnet50Cloudy(1,3);
e_v_Conv1TC = exp1matriz_parametrosCNNresnet50Cloudy(1,4);
t_m_Conv1TC = exp1matriz_parametrosCNNresnet50Cloudy(1,5);
t_v_Conv1TC = exp1matriz_parametrosCNNresnet50Cloudy(1,6);
t_est_m_Conv1TC = exp1matriz_parametrosCNNresnet50Cloudy(1,7);
t_est_v_Conv1TC = exp1matriz_parametrosCNNresnet50Cloudy(1,8);

% Obtención de los resultados mínimos en el mejor canal de la capa 'res2a_branch2a'
canal_Conv2TC = exp1matriz_parametrosCNNresnet50Cloudy(2,2);
e_m_Conv2TC = exp1matriz_parametrosCNNresnet50Cloudy(2,3);
e_v_Conv2TC = exp1matriz_parametrosCNNresnet50Cloudy(2,4);
t_m_Conv2TC = exp1matriz_parametrosCNNresnet50Cloudy(2,5);
t_v_Conv2TC = exp1matriz_parametrosCNNresnet50Cloudy(2,6);
t_est_m_Conv2TC = exp1matriz_parametrosCNNresnet50Cloudy(2,7);
t_est_v_Conv2TC = exp1matriz_parametrosCNNresnet50Cloudy(2,8);

% Obtención de los resultados mínimos en el mejor canal de la capa 'res3a_branch2a'
canal_Conv3TC = exp1matriz_parametrosCNNresnet50Cloudy(3,2);
e_m_Conv3TC = exp1matriz_parametrosCNNresnet50Cloudy(3,3);
e_v_Conv3TC = exp1matriz_parametrosCNNresnet50Cloudy(3,4);
t_m_Conv3TC = exp1matriz_parametrosCNNresnet50Cloudy(3,5);
t_v_Conv3TC = exp1matriz_parametrosCNNresnet50Cloudy(3,6);
t_est_m_Conv3TC = exp1matriz_parametrosCNNresnet50Cloudy(3,7);
t_est_v_Conv3TC = exp1matriz_parametrosCNNresnet50Cloudy(3,8);

% Obtención de los resultados mínimos en el mejor canal de la capa 'res4a_branch2a'
canal_Conv4TC = exp1matriz_parametrosCNNresnet50Cloudy(4,2);
e_m_Conv4TC = exp1matriz_parametrosCNNresnet50Cloudy(4,3);
e_v_Conv4TC = exp1matriz_parametrosCNNresnet50Cloudy(4,4);
t_m_Conv4TC = exp1matriz_parametrosCNNresnet50Cloudy(4,5);
t_v_Conv4TC = exp1matriz_parametrosCNNresnet50Cloudy(4,6);
t_est_m_Conv4TC = exp1matriz_parametrosCNNresnet50Cloudy(4,7);
t_est_v_Conv4TC = exp1matriz_parametrosCNNresnet50Cloudy(4,8);

% Obtención de los resultados mínimos en el mejor canal de la capa 'res5a_branch2a'
canal_Conv5TC = exp1matriz_parametrosCNNresnet50Cloudy(5,2);
e_m_Conv5TC = exp1matriz_parametrosCNNresnet50Cloudy(5,3);
e_v_Conv5TC = exp1matriz_parametrosCNNresnet50Cloudy(5,4);
t_m_Conv5TC = exp1matriz_parametrosCNNresnet50Cloudy(5,5);
t_v_Conv5TC = exp1matriz_parametrosCNNresnet50Cloudy(5,6);
t_est_m_Conv5TC = exp1matriz_parametrosCNNresnet50Cloudy(5,7);
t_est_v_Conv5TC = exp1matriz_parametrosCNNresnet50Cloudy(5,8);

% Para los siguientes cambios de iluminación únicamente obtendremos los resultados para el mejor
% canal de cada capa convolucional, ya que supondremos que el mejor canal para un tiempo cloudy
% también será el mejor canal para la iluminación night / sunny.

% Cálculo de los parámetros tiempo y error para N
fila = 1; columnas = 8;
exp1matriz_parametrosCNNresnet50Night = zeros(fila,columnas);

for capa = 1:5
        canal = best_channel(capa);
        descriptor_tr_resnet50 = descriptor_training_resnet50(layer_name{capa},canal);
        for i = 1:size(todas_imagesNight,1)
            descriptor_N = [];
            image = imread(sprintf('%s%s',directorio_Night,todas_imagesNight(i).name));
            image = imresize(image,[224 224]);
            image = image(:,:,[1 1 1]);
            
            tic
            d_ConvN = activations(net,image,layer_name{capa});
            d_ConvN = d_ConvN(:,:,canal);
            for j = 1:size(d_ConvN,1)
                descriptor_N = [descriptor_N d_ConvN(j,:)];
            end
            
            tiempo_dConvTN(i) = toc;
            
            tic
            pdist2_dConvN = pdist2(descriptor_N,descriptor_tr_resnet50(:,:),'cosine');
            [~,posicion] = min(pdist2_dConvN);
            posicion_estimada_dConvN(i,:) = coordenadas_tr(posicion,:);
            tiempoestimado_dConvTN(i) = toc;
            
            posicion_real_dConvN(i,:) = coordenadas_N(i,:);
            error_posicion_dConvN(i) = pdist2(posicion_estimada_dConvN(i,:),posicion_real_dConvN(i,:),'euclidean');
        end
        e_m_dConvTN = mean(error_posicion_dConvN);
        e_v_dConvTN = var(error_posicion_dConvN);
        
        t_m_dConvTN = mean(tiempo_dConvTN);
        t_v_dConvTN = var(tiempo_dConvTN);

        t_est_m_dConvTN = mean(tiempoestimado_dConvTN);
        t_est_v_dConvTN = var(tiempoestimado_dConvTN);
        
        exp1matriz_parametrosCNNresnet50Night(fila,:) = [capa,canal,e_m_dConvTN,e_v_dConvTN,t_m_dConvTN,t_v_dConvTN,t_est_m_dConvTN,t_est_v_dConvTN];
        fila = fila + 1;
        save(sprintf('%sExp1MatrizResultadosCNNresnet50_dConvN.mat',directorio_Night),'exp1matriz_parametrosCNNresnet50Night');
end

% Obtención de los resultados mínimos en el mejor canal de la capa 'conv1_1'
canal_Conv1TN = exp1matriz_parametrosCNNresnet50Night(1,2);
e_m_Conv1TN = exp1matriz_parametrosCNNresnet50Night(1,3);
e_v_Conv1TN = exp1matriz_parametrosCNNresnet50Night(1,4);
t_m_Conv1TN = exp1matriz_parametrosCNNresnet50Night(1,5);
t_v_Conv1TN = exp1matriz_parametrosCNNresnet50Night(1,6);
t_est_m_Conv1TN = exp1matriz_parametrosCNNresnet50Night(1,7);
t_est_v_Conv1TN = exp1matriz_parametrosCNNresnet50Night(1,8);

% Obtención de los resultados mínimos en el mejor canal de la capa 'conv2_1'
canal_Conv2TN = exp1matriz_parametrosCNNresnet50Night(2,2);
e_m_Conv2TN = exp1matriz_parametrosCNNresnet50Night(2,3);
e_v_Conv2TN = exp1matriz_parametrosCNNresnet50Night(2,4);
t_m_Conv2TN = exp1matriz_parametrosCNNresnet50Night(2,5);
t_v_Conv2TN = exp1matriz_parametrosCNNresnet50Night(2,6);
t_est_m_Conv2TN = exp1matriz_parametrosCNNresnet50Night(2,7);
t_est_v_Conv2TN = exp1matriz_parametrosCNNresnet50Night(2,8);

% Obtención de los resultados mínimos en el mejor canal de la capa 'conv3_1'
canal_Conv3TN = exp1matriz_parametrosCNNresnet50Night(3,2);
e_m_Conv3TN = exp1matriz_parametrosCNNresnet50Night(3,3);
e_v_Conv3TN = exp1matriz_parametrosCNNresnet50Night(3,4);
t_m_Conv3TN = exp1matriz_parametrosCNNresnet50Night(3,5);
t_v_Conv3TN = exp1matriz_parametrosCNNresnet50Night(3,6);
t_est_m_Conv3TN = exp1matriz_parametrosCNNresnet50Night(3,7);
t_est_v_Conv3TN = exp1matriz_parametrosCNNresnet50Night(3,8);

% Obtención de los resultados mínimos en el mejor canal de la capa 'conv4_1'
canal_Conv4TN = exp1matriz_parametrosCNNresnet50Night(4,2);
e_m_Conv4TN = exp1matriz_parametrosCNNresnet50Night(4,3);
e_v_Conv4TN = exp1matriz_parametrosCNNresnet50Night(4,4);
t_m_Conv4TN = exp1matriz_parametrosCNNresnet50Night(4,5);
t_v_Conv4TN = exp1matriz_parametrosCNNresnet50Night(4,6);
t_est_m_Conv4TN = exp1matriz_parametrosCNNresnet50Night(4,7);
t_est_v_Conv4TN = exp1matriz_parametrosCNNresnet50Night(4,8);

% Obtención de los resultados mínimos en el mejor canal de la capa 'conv5_1'
canal_Conv5TN = exp1matriz_parametrosCNNresnet50Night(5,2);
e_m_Conv5TN = exp1matriz_parametrosCNNresnet50Night(5,3);
e_v_Conv5TN = exp1matriz_parametrosCNNresnet50Night(5,4);
t_m_Conv5TN = exp1matriz_parametrosCNNresnet50Night(5,5);
t_v_Conv5TN = exp1matriz_parametrosCNNresnet50Night(5,6);
t_est_m_Conv5TN = exp1matriz_parametrosCNNresnet50Night(5,7);
t_est_v_Conv5TN = exp1matriz_parametrosCNNresnet50Night(5,8);

% Cálculo de los parámetros tiempo y error para S
fila = 1; columnas = 8;
exp1matriz_parametrosCNNresnet50Sunny = zeros(fila,columnas);

for capa = 1:5
        canal = best_channel(capa);
        descriptor_tr_resnet50 = descriptor_training_resnet50(layer_name{capa},canal);
        for i = 1:size(todas_imagesSunny,1)
            descriptor_S = [];
            image = imread(sprintf('%s%s',directorio_Sunny,todas_imagesSunny(i).name));
            image = imresize(image,[224 224]);
            image = image(:,:,[1 1 1]);
            
            tic
            d_ConvS = activations(net,image,layer_name{capa});
            d_ConvS = d_ConvS(:,:,canal);
            for j = 1:size(d_ConvS,1)
                descriptor_S = [descriptor_S d_ConvS(j,:)];
            end
            
            tiempo_dConvTS(i) = toc;
            
            tic
            pdist2_dConvS = pdist2(descriptor_S,descriptor_tr_resnet50(:,:),'cosine');
            [~,posicion] = min(pdist2_dConvS);
            posicion_estimada_dConvS(i,:) = coordenadas_tr(posicion,:);
            tiempoestimado_dConvTS(i) = toc;
            
            posicion_real_dConvS(i,:) = coordenadas_S(i,:);
            error_posicion_dConvS(i) = pdist2(posicion_estimada_dConvS(i,:),posicion_real_dConvS(i,:),'euclidean');
        end
        e_m_dConvTS = mean(error_posicion_dConvS);
        e_v_dConvTS = var(error_posicion_dConvS);
        
        t_m_dConvTS = mean(tiempo_dConvTS);
        t_v_dConvTS = var(tiempo_dConvTS);

        t_est_m_dConvTS = mean(tiempoestimado_dConvTS);
        t_est_v_dConvTS = var(tiempoestimado_dConvTS);
        
        exp1matriz_parametrosCNNresnet50Sunny(fila,:) = [capa,canal,e_m_dConvTS,e_v_dConvTS,t_m_dConvTS,t_v_dConvTS,t_est_m_dConvTS,t_est_v_dConvTS];
        fila = fila + 1;
        save(sprintf('%sExp1MatrizResultadosCNNresnet50_dConvS.mat',directorio_Sunny),'exp1matriz_parametrosCNNresnet50Sunny');
end

% Obtención de los resultados mínimos en el mejor canal de la capa 'conv1'
canal_Conv1TS = exp1matriz_parametrosCNNresnet50Sunny(1,2);
e_m_Conv1TS = exp1matriz_parametrosCNNresnet50Sunny(1,3);
e_v_Conv1TS = exp1matriz_parametrosCNNresnet50Sunny(1,4);
t_m_Conv1TS = exp1matriz_parametrosCNNresnet50Sunny(1,5);
t_v_Conv1TS = exp1matriz_parametrosCNNresnet50Sunny(1,6);
t_est_m_Conv1TS = exp1matriz_parametrosCNNresnet50Sunny(1,7);
t_est_v_Conv1TS = exp1matriz_parametrosCNNresnet50Sunny(1,8);

% Obtención de los resultados mínimos en el mejor canal de la capa 'res2a_branch2a'
canal_Conv2TS = exp1matriz_parametrosCNNresnet50Sunny(2,2);
e_m_Conv2TS = exp1matriz_parametrosCNNresnet50Sunny(2,3);
e_v_Conv2TS = exp1matriz_parametrosCNNresnet50Sunny(2,4);
t_m_Conv2TS = exp1matriz_parametrosCNNresnet50Sunny(2,5);
t_v_Conv2TS = exp1matriz_parametrosCNNresnet50Sunny(2,6);
t_est_m_Conv2TS = exp1matriz_parametrosCNNresnet50Sunny(2,7);
t_est_v_Conv2TS = exp1matriz_parametrosCNNresnet50Sunny(2,8);

% Obtención de los resultados mínimos en el mejor canal de la capa 'res3a_branch2a'
canal_Conv3TS = exp1matriz_parametrosCNNresnet50Sunny(3,2);
e_m_Conv3TS = exp1matriz_parametrosCNNresnet50Sunny(3,3);
e_v_Conv3TS = exp1matriz_parametrosCNNresnet50Sunny(3,4);
t_m_Conv3TS = exp1matriz_parametrosCNNresnet50Sunny(3,5);
t_v_Conv3TS = exp1matriz_parametrosCNNresnet50Sunny(3,6);
t_est_m_Conv3TS = exp1matriz_parametrosCNNresnet50Sunny(3,7);
t_est_v_Conv3TS = exp1matriz_parametrosCNNresnet50Sunny(3,8);

% Obtención de los resultados mínimos en el mejor canal de la capa 'res4a_branch2a'
canal_Conv4TS = exp1matriz_parametrosCNNresnet50Sunny(4,2);
e_m_Conv4TS = exp1matriz_parametrosCNNresnet50Sunny(4,3);
e_v_Conv4TS = exp1matriz_parametrosCNNresnet50Sunny(4,4);
t_m_Conv4TS = exp1matriz_parametrosCNNresnet50Sunny(4,5);
t_v_Conv4TS = exp1matriz_parametrosCNNresnet50Sunny(4,6);
t_est_m_Conv4TS = exp1matriz_parametrosCNNresnet50Sunny(4,7);
t_est_v_Conv4TS = exp1matriz_parametrosCNNresnet50Sunny(4,8);

% Obtención de los resultados mínimos en el mejor canal de la capa 'res5a_branch2a'
canal_Conv5TS = exp1matriz_parametrosCNNresnet50Sunny(5,2);
e_m_Conv5TS = exp1matriz_parametrosCNNresnet50Sunny(5,3);
e_v_Conv5TS = exp1matriz_parametrosCNNresnet50Sunny(5,4);
t_m_Conv5TS = exp1matriz_parametrosCNNresnet50Sunny(5,5);
t_v_Conv5TS = exp1matriz_parametrosCNNresnet50Sunny(5,6);
t_est_m_Conv5TS = exp1matriz_parametrosCNNresnet50Sunny(5,7);
t_est_v_Conv5TS = exp1matriz_parametrosCNNresnet50Sunny(5,8);
