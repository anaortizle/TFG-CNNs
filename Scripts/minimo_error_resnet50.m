directorio_Cloudy = 'Saarbrücken_Pano_Test_Cloudy/';

load(sprintf('%sMatrizResultadosCNNresnet50_dConvC',directorio_Cloudy));

% Obtención de los resultados mínimos entre todos los canales de la capa 'conv1'
[e_m_Conv1TC,pos_min_emConv1TC] = min(matriz_parametrosCNNresnet50Cloudy(1:64,3));

canal_Conv1TC = matriz_parametrosCNNresnet50Cloudy(pos_min_emConv1TC,2);
e_v_Conv1TC = matriz_parametrosCNNresnet50Cloudy(pos_min_emConv1TC,4);
t_m_Conv1TC = matriz_parametrosCNNresnet50Cloudy(pos_min_emConv1TC,5);
t_v_Conv1TC = matriz_parametrosCNNresnet50Cloudy(pos_min_emConv1TC,6);
t_est_m_Conv1TC = matriz_parametrosCNNresnet50Cloudy(pos_min_emConv1TC,7);
t_est_v_Conv1TC = matriz_parametrosCNNresnet50Cloudy(pos_min_emConv1TC,8);

% Obtención de los resultados mínimos entre todos los canales de la capa 'res2a_branch2a'
[e_m_Conv2TC,pos_min_emConv2TC] = min(matriz_parametrosCNNresnet50Cloudy(65:128,3));
pos_min_emConv2TC = pos_min_emConv2TC + 64;

canal_Conv2TC = matriz_parametrosCNNresnet50Cloudy(pos_min_emConv2TC,2);
e_v_Conv2TC = matriz_parametrosCNNresnet50Cloudy(pos_min_emConv2TC,4);
t_m_Conv2TC = matriz_parametrosCNNresnet50Cloudy(pos_min_emConv2TC,5);
t_v_Conv2TC = matriz_parametrosCNNresnet50Cloudy(pos_min_emConv2TC,6);
t_est_m_Conv2TC = matriz_parametrosCNNresnet50Cloudy(pos_min_emConv2TC,7);
t_est_v_Conv2TC = matriz_parametrosCNNresnet50Cloudy(pos_min_emConv2TC,8);

% Obtención de los resultados mínimos entre todos los canales de la capa 'res3a_branch2a'
[e_m_Conv3TC,pos_min_emConv3TC] = min(matriz_parametrosCNNresnet50Cloudy(129:256,3));
pos_min_emConv3TC = pos_min_emConv3TC + 128;

canal_Conv3TC = matriz_parametrosCNNresnet50Cloudy(pos_min_emConv3TC,2);
e_v_Conv3TC = matriz_parametrosCNNresnet50Cloudy(pos_min_emConv3TC,4);
t_m_Conv3TC = matriz_parametrosCNNresnet50Cloudy(pos_min_emConv3TC,5);
t_v_Conv3TC = matriz_parametrosCNNresnet50Cloudy(pos_min_emConv3TC,6);
t_est_m_Conv3TC = matriz_parametrosCNNresnet50Cloudy(pos_min_emConv3TC,7);
t_est_v_Conv3TC = matriz_parametrosCNNresnet50Cloudy(pos_min_emConv3TC,8);

% Obtención de los resultados mínimos entre todos los canales de la capa 'res4a_branch2a'
[e_m_Conv4TC,pos_min_emConv4TC] = min(matriz_parametrosCNNresnet50Cloudy(257:512,3));
pos_min_emConv4TC = pos_min_emConv4TC + 256;

canal_Conv4TC = matriz_parametrosCNNresnet50Cloudy(pos_min_emConv4TC,2);
e_v_Conv4TC = matriz_parametrosCNNresnet50Cloudy(pos_min_emConv4TC,4);
t_m_Conv4TC = matriz_parametrosCNNresnet50Cloudy(pos_min_emConv4TC,5);
t_v_Conv4TC = matriz_parametrosCNNresnet50Cloudy(pos_min_emConv4TC,6);
t_est_m_Conv4TC = matriz_parametrosCNNresnet50Cloudy(pos_min_emConv4TC,7);
t_est_v_Conv4TC = matriz_parametrosCNNresnet50Cloudy(pos_min_emConv4TC,8);

% Obtención de los resultados mínimos entre todos los canales de la capa 'res5a_branch2a'
[e_m_Conv5TC,pos_min_emConv5TC] = min(matriz_parametrosCNNresnet50Cloudy(513:1024,3));
pos_min_emConv5TC = pos_min_emConv5TC + 512;

canal_Conv5TC = matriz_parametrosCNNresnet50Cloudy(pos_min_emConv5TC,2);
e_v_Conv5TC = matriz_parametrosCNNresnet50Cloudy(pos_min_emConv5TC,4);
t_m_Conv5TC = matriz_parametrosCNNresnet50Cloudy(pos_min_emConv5TC,5);
t_v_Conv5TC = matriz_parametrosCNNresnet50Cloudy(pos_min_emConv5TC,6);
t_est_m_Conv5TC = matriz_parametrosCNNresnet50Cloudy(pos_min_emConv5TC,7);
t_est_v_Conv5TC = matriz_parametrosCNNresnet50Cloudy(pos_min_emConv5TC,8);
