directorio_Cloudy = 'Saarbrücken_Pano_Test_Cloudy/';

load(sprintf('%sMatrizResultadosCNNVGG19_dConvC_1as_capas',directorio_Cloudy));


filas = 512;
columnas = 8;
matriz_parametrosCNNVGG19Cloudy_capa5 = zeros(filas,columnas);
j = 1;

for i = 961:1134
   
      matriz_parametrosCNNVGG19Cloudy_capa5(j,:) = [matriz_parametrosCNNVGG19Cloudy(i,1),matriz_parametrosCNNVGG19Cloudy(i,2),matriz_parametrosCNNVGG19Cloudy(i,3),matriz_parametrosCNNVGG19Cloudy(i,4),matriz_parametrosCNNVGG19Cloudy(i,5),matriz_parametrosCNNVGG19Cloudy(i,6),matriz_parametrosCNNVGG19Cloudy(i,7),matriz_parametrosCNNVGG19Cloudy(i,8)];
    
  j = j + 1;
   
end

load(sprintf('%sMatrizResultadosCNNVGG19_dConvC',directorio_Cloudy));

j = 175;

for i = 6:343
            
      matriz_parametrosCNNVGG19Cloudy_capa5(j,:) = [matriz_parametrosCNNVGG19Cloudy(i,1),matriz_parametrosCNNVGG19Cloudy(i,2),matriz_parametrosCNNVGG19Cloudy(i,3),matriz_parametrosCNNVGG19Cloudy(i,4),matriz_parametrosCNNVGG19Cloudy(i,5),matriz_parametrosCNNVGG19Cloudy(i,6),matriz_parametrosCNNVGG19Cloudy(i,7),matriz_parametrosCNNVGG19Cloudy(i,8)];
    
   j = j + 1;
   
end

save(sprintf('%sMatrizResultadosCNNVGG19_dConvC_capa5.mat',directorio_Cloudy),'matriz_parametrosCNNVGG19Cloudy_capa5');

% Obtención de los resultados mínimos entre todos los canales de la capa 'conv5_1'
[e_m_Conv5TC,pos_min_emConv5TC] = min(matriz_parametrosCNNVGG19Cloudy_capa5(1:512,3));

canal_Conv5TC = matriz_parametrosCNNVGG19Cloudy_capa5(pos_min_emConv5TC,2);
e_v_Conv5TC = matriz_parametrosCNNVGG19Cloudy_capa5(pos_min_emConv5TC,4);
t_m_Conv5TC = matriz_parametrosCNNVGG19Cloudy_capa5(pos_min_emConv5TC,5);
t_v_Conv5TC = matriz_parametrosCNNVGG19Cloudy_capa5(pos_min_emConv5TC,6);
t_est_m_Conv5TC = matriz_parametrosCNNVGG19Cloudy_capa5(pos_min_emConv5TC,7);
t_est_v_Conv5TC = matriz_parametrosCNNVGG19Cloudy_capa5(pos_min_emConv5TC,8);




