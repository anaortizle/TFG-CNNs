directorio_Cloudy = 'Saarbrücken_Pano_Test_Cloudy/';
directorio_blur_Cloudy = 'Saarbrücken_Blur_Test_Cloudy/';
directorio_Training = 'Saarbrücken_Pano_Training_Cloudy/';

todas_imagesBlur = dir(strcat(directorio_blur_Cloudy,'*.jpeg'));
todas_imagesTraining = dir(strcat(directorio_Training,'*.jpeg'));

% A continuación se creará la red con la que estaremos trabajando junto con
net = resnet50();

% Cargamos los resultados de las coordenadas de posición de Tr y C (ruido)
load(sprintf('%sCoordenadas_Tr',directorio_Training));
load(sprintf('%sCoordenadas_C',directorio_Cloudy));

%Rellenar con el mejor canal de cada capa
layer_name = {'conv1','res2a_branch2a','res3a_branch2a','res4a_branch2a','res5a_branch2a'};
best_channel = [17,8,74,20,113];

% Cálculo de los parámetros tiempo y error para C
fila = 1; columnas = 8;
exp4matriz_parametrosCNNresnet50CloudyBlur = zeros(fila,columnas);
capa = 3;

canal = best_channel(capa);
descriptor_tr_resnet50 = descriptor_training_resnet50(layer_name{capa},canal);

for i = 1:size(todas_imagesBlur,1)
       descriptor_C = [];
       image = imread(sprintf('%s%s',directorio_blur_Cloudy,todas_imagesBlur(i).name));
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
        
exp4matriz_parametrosCNNresnet50CloudyBlur(fila,:) = [capa,canal,e_m_dConvTC,e_v_dConvTC,t_m_dConvTC,t_v_dConvTC,t_est_m_dConvTC,t_est_v_dConvTC];
save(sprintf('%sExp4MatrizResultadosCNNresnet50_dConvC.mat',directorio_blur_Cloudy),'exp4matriz_parametrosCNNresnet50CloudyBlur');


% Obtención de los resultados mínimos en el mejor canal de la capa 'conv4_1'
canal_Conv1TC = exp4matriz_parametrosCNNresnet50CloudyBlur(1,2);
e_m_Conv1TC = exp4matriz_parametrosCNNresnet50CloudyBlur(1,3);
e_v_Conv1TC = exp4matriz_parametrosCNNresnet50CloudyBlur(1,4);
t_m_Conv1TC = exp4matriz_parametrosCNNresnet50CloudyBlur(1,5);
t_v_Conv1TC = exp4matriz_parametrosCNNresnet50CloudyBlur(1,6);
t_est_m_Conv1TC = exp4matriz_parametrosCNNresnet50CloudyBlur(1,7);
t_est_v_Conv1TC = exp4matriz_parametrosCNNresnet50CloudyBlur(1,8);

