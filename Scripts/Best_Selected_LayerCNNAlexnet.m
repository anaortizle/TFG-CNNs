% Cálculo del mejor canal de cada capa de la CNN - Alexnet (conv1/conv2/conv3/conv4/conv5) por el
% cual se obtiene un mejor resultado en la localización

directorio_Pano_TestC = 'Saarbrücken_Pano_Test_Cloudy/';
directorio_Pano_TestN = 'Saarbrücken_Pano_Test_Night/';
directorio_Pano_TestS = 'Saarbrücken_Pano_Test_Sunny/';
directorio_Pano_TrainC = 'Saarbrücken_Pano_Training_Cloudy/';

todas_imagesTC = dir(strcat(directorio_Pano_TestC,'*.jpeg'));
todas_imagesTN = dir(strcat(directorio_Pano_TestN,'*.jpeg'));
todas_imagesTS = dir(strcat(directorio_Pano_TestS,'*.jpeg'));
todas_imagesTrC = dir(strcat(directorio_Pano_TrainC,'*.jpeg'));

% A continuación se creará la red con la que estaremos trabajando
net = alexnet;
% Para ver las características de la red --> net.Layers

% Cargamos los resultados de las coordenadas de posición de TrC y TC,TN,TS
load(sprintf('%sCoordenadasTrC',directorio_Pano_TrainC));
load(sprintf('%sCoordenadasTC',directorio_Pano_TestC));
load(sprintf('%sCoordenadasTN',directorio_Pano_TestN));
load(sprintf('%sCoordenadasTS',directorio_Pano_TestS));

layer_name = {'conv1','conv2','conv3','conv4','conv5'};

% Cálculo de los parámetros tiempo y error para TC
num_canales = [96 256 384 384 256];
fila = 1; columnas = 8;
matriz_parametrosCNNAlexnetTC = zeros(fila,columnas);

for capa = 1:5
    for canal = 1:num_canales(capa)
        descriptor_ConvTrC = Training_Descriptor_CalculationCNNAlexnet(layer_name{capa},canal);
        m = 0;
        for i = 1:2:size(todas_imagesTC,1)
            m = m + 1;
            descriptor_ConvTC = [];
            image = imread(sprintf('%s%s',directorio_Pano_TestC,todas_imagesTC(i).name));
            image = imresize(image,[227 227]);
            image = image(:,:,[1 1 1]);
            
            tic
            d_ConvTC = activations(net,image,layer_name{capa});
            d_ConvTC = d_ConvTC(:,:,canal);
            for j = 1:size(d_ConvTC,1)
                descriptor_ConvTC = [descriptor_ConvTC d_ConvTC(j,:)];
            end
            tiempo_dConvTC(m) = toc;
            
            tic
            pdist2_dConvTC = pdist2(descriptor_ConvTC,descriptor_ConvTrC(:,:),'cosine');
            [~,posicion] = min(pdist2_dConvTC);
            posicion_estimada_dConvTC(m,:) = coorTestGlobalTrC(posicion,:);
            tiempoestimado_dConvTC(m) = toc;
            
            posicion_real_dConvTC(m,:) = coorTestGlobalTC(i,:);
            error_posicion_dConvTC(m) = pdist2(posicion_estimada_dConvTC(m,:),posicion_real_dConvTC(m,:),'euclidean');
        end
        e_m_dConvTC = mean(error_posicion_dConvTC);
        e_v_dConvTC = var(error_posicion_dConvTC);
        
        t_m_dConvTC = mean(tiempo_dConvTC);
        t_v_dConvTC = var(tiempo_dConvTC);

        t_est_m_dConvTC = mean(tiempoestimado_dConvTC);
        t_est_v_dConvTC = var(tiempoestimado_dConvTC);
        
        matriz_parametrosCNNAlexnetTC(fila,:) = [capa,canal,e_m_dConvTC,e_v_dConvTC,t_m_dConvTC,t_v_dConvTC,t_est_m_dConvTC,t_est_v_dConvTC];
        fila = fila + 1;
        save(sprintf('%sMatrizResultadosCNNAlexnet_dConvTC.mat',directorio_Pano_TestC),'matriz_parametrosCNNAlexnetTC');
    end
end

% Obtención de los resultados mínimos entre todos los canales de la capa 'conv1'
[e_m_Conv1TC,pos_min_emConv1TC] = min(matriz_parametrosCNNAlexnetTC(1:96,3));

canal_Conv1TC = matriz_parametrosCNNAlexnetTC(pos_min_emConv1TC,2);
e_v_Conv1TC = matriz_parametrosCNNAlexnetTC(pos_min_emConv1TC,4);
t_m_Conv1TC = matriz_parametrosCNNAlexnetTC(pos_min_emConv1TC,5);
t_v_Conv1TC = matriz_parametrosCNNAlexnetTC(pos_min_emConv1TC,6);
t_est_m_Conv1TC = matriz_parametrosCNNAlexnetTC(pos_min_emConv1TC,7);
t_est_v_Conv1TC = matriz_parametrosCNNAlexnetTC(pos_min_emConv1TC,8);

% Obtención de los resultados mínimos entre todos los canales de la capa 'conv2'
[e_m_Conv2TC,pos_min_emConv2TC] = min(matriz_parametrosCNNAlexnetTC(97:352,3));
pos_min_emConv2TC = pos_min_emConv2TC + 96;

canal_Conv2TC = matriz_parametrosCNNAlexnetTC(pos_min_emConv2TC,2);
e_v_Conv2TC = matriz_parametrosCNNAlexnetTC(pos_min_emConv2TC,4);
t_m_Conv2TC = matriz_parametrosCNNAlexnetTC(pos_min_emConv2TC,5);
t_v_Conv2TC = matriz_parametrosCNNAlexnetTC(pos_min_emConv2TC,6);
t_est_m_Conv2TC = matriz_parametrosCNNAlexnetTC(pos_min_emConv2TC,7);
t_est_v_Conv2TC = matriz_parametrosCNNAlexnetTC(pos_min_emConv2TC,8);

% Obtención de los resultados mínimos entre todos los canales de la capa 'conv3'
[e_m_Conv3TC,pos_min_emConv3TC] = min(matriz_parametrosCNNAlexnetTC(353:736,3));
pos_min_emConv3TC = pos_min_emConv3TC + 352;

canal_Conv3TC = matriz_parametrosCNNAlexnetTC(pos_min_emConv3TC,2);
e_v_Conv3TC = matriz_parametrosCNNAlexnetTC(pos_min_emConv3TC,4);
t_m_Conv3TC = matriz_parametrosCNNAlexnetTC(pos_min_emConv3TC,5);
t_v_Conv3TC = matriz_parametrosCNNAlexnetTC(pos_min_emConv3TC,6);
t_est_m_Conv3TC = matriz_parametrosCNNAlexnetTC(pos_min_emConv3TC,7);
t_est_v_Conv3TC = matriz_parametrosCNNAlexnetTC(pos_min_emConv3TC,8);

% Obtención de los resultados mínimos entre todos los canales de la capa 'conv4'
[e_m_Conv4TC,pos_min_emConv4TC] = min(matriz_parametrosCNNAlexnetTC(737:1120,3));
pos_min_emConv4TC = pos_min_emConv4TC + 736;

canal_Conv4TC = matriz_parametrosCNNAlexnetTC(pos_min_emConv4TC,2);
e_v_Conv4TC = matriz_parametrosCNNAlexnetTC(pos_min_emConv4TC,4);
t_m_Conv4TC = matriz_parametrosCNNAlexnetTC(pos_min_emConv4TC,5);
t_v_Conv4TC = matriz_parametrosCNNAlexnetTC(pos_min_emConv4TC,6);
t_est_m_Conv4TC = matriz_parametrosCNNAlexnetTC(pos_min_emConv4TC,7);
t_est_v_Conv4TC = matriz_parametrosCNNAlexnetTC(pos_min_emConv4TC,8);

% Obtención de los resultados mínimos entre todos los canales de la capa 'conv5'
[e_m_Conv5TC,pos_min_emConv5TC] = min(matriz_parametrosCNNAlexnetTC(1121:1376,3));
pos_min_emConv5TC = pos_min_emConv5TC + 1120;

canal_Conv5TC = matriz_parametrosCNNAlexnetTC(pos_min_emConv5TC,2);
e_v_Conv5TC = matriz_parametrosCNNAlexnetTC(pos_min_emConv5TC,4);
t_m_Conv5TC = matriz_parametrosCNNAlexnetTC(pos_min_emConv5TC,5);
t_v_Conv5TC = matriz_parametrosCNNAlexnetTC(pos_min_emConv5TC,6);
t_est_m_Conv5TC = matriz_parametrosCNNAlexnetTC(pos_min_emConv5TC,7);
t_est_v_Conv5TC = matriz_parametrosCNNAlexnetTC(pos_min_emConv5TC,8);

% Para los siguientes cambios de iluminación únicamente obtendremos los resultados para el mejor
% canal de cada capa convolucional, ya que supondremos que el mejor canal para un tiempo cloudy
% también será el mejor canal para la iluminación night / sunny.

% Cálculo de los parámetros tiempo y error para TN
num_canales = [54 134 220 79 223];
fila = 1; columnas = 8;
matriz_parametrosCNNAlexnetTN = zeros(fila,columnas);

for capa = 1:5
    canal = num_canales(capa);
    descriptor_ConvTrC = Training_Descriptor_CalculationCNNAlexnet(layer_name{capa},canal);
    m = 0;
    for i = 1:2:size(todas_imagesTN,1)
        m = m + 1;
        descriptor_ConvTN = [];
        image = imread(sprintf('%s%s',directorio_Pano_TestN,todas_imagesTN(i).name));
        image = imresize(image,[227 227]);
        image = image(:,:,[1 1 1]);
           
        tic
        d_ConvTN = activations(net,image,layer_name{capa});
        d_ConvTN = d_ConvTN(:,:,canal);
        for j = 1:size(d_ConvTN,1)
            descriptor_ConvTN = [descriptor_ConvTN d_ConvTN(j,:)];
        end
        tiempo_dConvTN(m) = toc;
           
        tic
        pdist2_dConvTN = pdist2(descriptor_ConvTN,descriptor_ConvTrC(:,:),'cosine');
        [~,posicion] = min(pdist2_dConvTN);
        posicion_estimada_dConvTN(m,:) = coorTestGlobalTrC(posicion,:);
        tiempoestimado_dConvTN(m) = toc;
            
        posicion_real_dConvTN(m,:) = coorTestGlobalTN(i,:);
        error_posicion_dConvTN(m) = pdist2(posicion_estimada_dConvTN(m,:),posicion_real_dConvTN(m,:),'euclidean');
    end
    e_m_dConvTN = mean(error_posicion_dConvTN);
    e_v_dConvTN = var(error_posicion_dConvTN);
       
    t_m_dConvTN = mean(tiempo_dConvTN);
    t_v_dConvTN = var(tiempo_dConvTN);

    t_est_m_dConvTN = mean(tiempoestimado_dConvTN);
    t_est_v_dConvTN = var(tiempoestimado_dConvTN);
        
    matriz_parametrosCNNAlexnetTN(fila,:) = [capa,canal,e_m_dConvTN,e_v_dConvTN,t_m_dConvTN,t_v_dConvTN,t_est_m_dConvTN,t_est_v_dConvTN];
    fila = fila + 1;
    save(sprintf('%sMatrizResultadosCNNAlexnet_dConvTN.mat',directorio_Pano_TestN),'matriz_parametrosCNNAlexnetTN');
end

% Obtención de los resultados mínimos en el mejor canal de la capa 'conv1'
canal_Conv1TN = matriz_parametrosCNNAlexnetTN(1,2);
e_m_Conv1TN = matriz_parametrosCNNAlexnetTN(1,3);
e_v_Conv1TN = matriz_parametrosCNNAlexnetTN(1,4);
t_m_Conv1TN = matriz_parametrosCNNAlexnetTN(1,5);
t_v_Conv1TN = matriz_parametrosCNNAlexnetTN(1,6);
t_est_m_Conv1TN = matriz_parametrosCNNAlexnetTN(1,7);
t_est_v_Conv1TN = matriz_parametrosCNNAlexnetTN(1,8);

% Obtención de los resultados mínimos en el mejor canal de la capa 'conv2'
canal_Conv2TN = matriz_parametrosCNNAlexnetTN(2,2);
e_m_Conv2TN = matriz_parametrosCNNAlexnetTN(2,3);
e_v_Conv2TN = matriz_parametrosCNNAlexnetTN(2,4);
t_m_Conv2TN = matriz_parametrosCNNAlexnetTN(2,5);
t_v_Conv2TN = matriz_parametrosCNNAlexnetTN(2,6);
t_est_m_Conv2TN = matriz_parametrosCNNAlexnetTN(2,7);
t_est_v_Conv2TN = matriz_parametrosCNNAlexnetTN(2,8);

% Obtención de los resultados mínimos en el mejor canal de la capa 'conv3'
canal_Conv3TN = matriz_parametrosCNNAlexnetTN(3,2);
e_m_Conv3TN = matriz_parametrosCNNAlexnetTN(3,3);
e_v_Conv3TN = matriz_parametrosCNNAlexnetTN(3,4);
t_m_Conv3TN = matriz_parametrosCNNAlexnetTN(3,5);
t_v_Conv3TN = matriz_parametrosCNNAlexnetTN(3,6);
t_est_m_Conv3TN = matriz_parametrosCNNAlexnetTN(3,7);
t_est_v_Conv3TN = matriz_parametrosCNNAlexnetTN(3,8);

% Obtención de los resultados mínimos en el mejor canal de la capa 'conv4'
canal_Conv4TN = matriz_parametrosCNNAlexnetTN(4,2);
e_m_Conv4TN = matriz_parametrosCNNAlexnetTN(4,3);
e_v_Conv4TN = matriz_parametrosCNNAlexnetTN(4,4);
t_m_Conv4TN = matriz_parametrosCNNAlexnetTN(4,5);
t_v_Conv4TN = matriz_parametrosCNNAlexnetTN(4,6);
t_est_m_Conv4TN = matriz_parametrosCNNAlexnetTN(4,7);
t_est_v_Conv4TN = matriz_parametrosCNNAlexnetTN(4,8);

% Obtención de los resultados mínimos en el mejor canal de la capa 'conv5'
canal_Conv5TN = matriz_parametrosCNNAlexnetTN(5,2);
e_m_Conv5TN = matriz_parametrosCNNAlexnetTN(5,3);
e_v_Conv5TN = matriz_parametrosCNNAlexnetTN(5,4);
t_m_Conv5TN = matriz_parametrosCNNAlexnetTN(5,5);
t_v_Conv5TN = matriz_parametrosCNNAlexnetTN(5,6);
t_est_m_Conv5TN = matriz_parametrosCNNAlexnetTN(5,7);
t_est_v_Conv5TN = matriz_parametrosCNNAlexnetTN(5,8);

% Cálculo de los parámetros tiempo y error para TS
num_canales = [54 134 220 79 223];
fila = 1; columnas = 8;
matriz_parametrosCNNAlexnetTS = zeros(fila,columnas);

for capa = 1:5
    canal = num_canales(capa);
    descriptor_ConvTrC = Training_Descriptor_CalculationCNNAlexnet(layer_name{capa},canal);
    m = 0;
    for i = 1:2:size(todas_imagesTS,1)
        m = m + 1;
        descriptor_ConvTS = [];
        image = imread(sprintf('%s%s',directorio_Pano_TestS,todas_imagesTS(i).name));
        image = imresize(image,[227 227]);
        image = image(:,:,[1 1 1]);
           
        tic
        d_ConvTS = activations(net,image,layer_name{capa});
        d_ConvTS = d_ConvTS(:,:,canal);
        for j = 1:size(d_ConvTS,1)
            descriptor_ConvTS = [descriptor_ConvTS d_ConvTS(j,:)];
        end
        tiempo_dConvTS(m) = toc;
           
        tic
        pdist2_dConvTS = pdist2(descriptor_ConvTS,descriptor_ConvTrC(:,:),'cosine');
        [~,posicion] = min(pdist2_dConvTS);
        posicion_estimada_dConvTS(m,:) = coorTestGlobalTrC(posicion,:);
        tiempoestimado_dConvTS(m) = toc;
            
        posicion_real_dConvTS(m,:) = coorTestGlobalTS(i,:);
        error_posicion_dConvTS(m) = pdist2(posicion_estimada_dConvTS(m,:),posicion_real_dConvTS(m,:),'euclidean');
    end
    e_m_dConvTS = mean(error_posicion_dConvTS);
    e_v_dConvTS = var(error_posicion_dConvTS);
       
    t_m_dConvTS = mean(tiempo_dConvTS);
    t_v_dConvTS = var(tiempo_dConvTS);

    t_est_m_dConvTS = mean(tiempoestimado_dConvTS);
    t_est_v_dConvTS = var(tiempoestimado_dConvTS);
        
    matriz_parametrosCNNAlexnetTS(fila,:) = [capa,canal,e_m_dConvTS,e_v_dConvTS,t_m_dConvTS,t_v_dConvTS,t_est_m_dConvTS,t_est_v_dConvTS];
    fila = fila + 1;
    save(sprintf('%sMatrizResultadosCNNAlexnet_dConvTS.mat',directorio_Pano_TestS),'matriz_parametrosCNNAlexnetTS');
end

% Obtención de los resultados mínimos en el mejor canal de la capa 'conv1'
canal_Conv1TS = matriz_parametrosCNNAlexnetTS(1,2);
e_m_Conv1TS = matriz_parametrosCNNAlexnetTS(1,3);
e_v_Conv1TS = matriz_parametrosCNNAlexnetTS(1,4);
t_m_Conv1TS = matriz_parametrosCNNAlexnetTS(1,5);
t_v_Conv1TS = matriz_parametrosCNNAlexnetTS(1,6);
t_est_m_Conv1TS = matriz_parametrosCNNAlexnetTS(1,7);
t_est_v_Conv1TS = matriz_parametrosCNNAlexnetTS(1,8);

% Obtención de los resultados mínimos en el mejor canal de la capa 'conv2'
canal_Conv2TS = matriz_parametrosCNNAlexnetTS(2,2);
e_m_Conv2TS = matriz_parametrosCNNAlexnetTS(2,3);
e_v_Conv2TS = matriz_parametrosCNNAlexnetTS(2,4);
t_m_Conv2TS = matriz_parametrosCNNAlexnetTS(2,5);
t_v_Conv2TS = matriz_parametrosCNNAlexnetTS(2,6);
t_est_m_Conv2TS = matriz_parametrosCNNAlexnetTS(2,7);
t_est_v_Conv2TS = matriz_parametrosCNNAlexnetTS(2,8);

% Obtención de los resultados mínimos en el mejor canal de la capa 'conv3'
canal_Conv3TS = matriz_parametrosCNNAlexnetTS(3,2);
e_m_Conv3TS = matriz_parametrosCNNAlexnetTS(3,3);
e_v_Conv3TS = matriz_parametrosCNNAlexnetTS(3,4);
t_m_Conv3TS = matriz_parametrosCNNAlexnetTS(3,5);
t_v_Conv3TS = matriz_parametrosCNNAlexnetTS(3,6);
t_est_m_Conv3TS = matriz_parametrosCNNAlexnetTS(3,7);
t_est_v_Conv3TS = matriz_parametrosCNNAlexnetTS(3,8);

% Obtención de los resultados mínimos en el mejor canal de la capa 'conv4'
canal_Conv4TS = matriz_parametrosCNNAlexnetTS(4,2);
e_m_Conv4TS = matriz_parametrosCNNAlexnetTS(4,3);
e_v_Conv4TS = matriz_parametrosCNNAlexnetTS(4,4);
t_m_Conv4TS = matriz_parametrosCNNAlexnetTS(4,5);
t_v_Conv4TS = matriz_parametrosCNNAlexnetTS(4,6);
t_est_m_Conv4TS = matriz_parametrosCNNAlexnetTS(4,7);
t_est_v_Conv4TS = matriz_parametrosCNNAlexnetTS(4,8);

% Obtención de los resultados mínimos en el mejor canal de la capa 'conv5'
canal_Conv5TS = matriz_parametrosCNNAlexnetTS(5,2);
e_m_Conv5TS = matriz_parametrosCNNAlexnetTS(5,3);
e_v_Conv5TS = matriz_parametrosCNNAlexnetTS(5,4);
t_m_Conv5TS = matriz_parametrosCNNAlexnetTS(5,5);
t_v_Conv5TS = matriz_parametrosCNNAlexnetTS(5,6);
t_est_m_Conv5TS = matriz_parametrosCNNAlexnetTS(5,7);
t_est_v_Conv5TS = matriz_parametrosCNNAlexnetTS(5,8);