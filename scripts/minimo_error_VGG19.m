directorio_Cloudy = 'Saarbrücken_Pano_Test_Cloudy/';

load(sprintf('%sMatrizResultadosCNNVGG19_dConvC_1as_capas',directorio_Cloudy));

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
