%Cargar matrices para C, N y S con parámetros 
directorio_Cloudy = 'Saarbrücken_Pano_Test_Cloudy/';
directorio_Night = 'Saarbrücken_Pano_Test_Night/';
directorio_Sunny = 'Saarbrücken_Pano_Test_Sunny/';

%VGGNet19
load(sprintf('%sExp1MatrizResultadosCNNVGG19_dConvC',directorio_Cloudy));
load(sprintf('%sExp1MatrizResultadosCNNVGG19_dConvN',directorio_Night));
load(sprintf('%sExp1MatrizResultadosCNNVGG19_dConvS',directorio_Sunny));

%ResNet50
load(sprintf('%sExp1MatrizResultadosCNNresnet50_dConvC',directorio_Cloudy));
load(sprintf('%sExp1MatrizResultadosCNNresnet50_dConvN',directorio_Night));
load(sprintf('%sExp1MatrizResultadosCNNresnet50_dConvS',directorio_Sunny));

% Gráfica error localización
filas = 2; columnas = 3;
grafica_error_medio = zeros(filas,columnas);


grafica_error_medio(1,:) = [exp1matriz_parametrosCNNVGG19Cloudy(4,3),exp1matriz_parametrosCNNVGG19Night(4,3),exp1matriz_parametrosCNNVGG19Sunny(4,3)]; 

grafica_error_medio(2,:) = [exp1matriz_parametrosCNNresnet50Cloudy(3,3),exp1matriz_parametrosCNNresnet50Night(3,3),exp1matriz_parametrosCNNresnet50Sunny(3,3)]; 

grafica_error_medio = grafica_error_medio*100;
figure
bar(grafica_error_medio)

%Poner luego en Command Window
title('Experimento 2: Error localización medio - Variación de CNN')
xlabel('Mejor capa de cada CNN')
ylabel('Error (cm)')
legend('Cloudy','Night','Sunny')
xticklabels({'conv4-1 (CNN VGGNet-19)','res3a-branch2a (CNN ResNet-50)'})
