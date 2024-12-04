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

% Gráfica tiempo
filas = 2; columnas = 2;
grafica_tiempo = zeros(filas,columnas);

grafica_tiempo(1,:) = [exp1matriz_parametrosCNNVGG19Cloudy(4,5),exp1matriz_parametrosCNNVGG19Cloudy(4,7)]; 

grafica_tiempo(2,:) = [exp1matriz_parametrosCNNresnet50Cloudy(3,5),exp1matriz_parametrosCNNresnet50Cloudy(3,7)]; 

grafica_tiempo = grafica_tiempo*1000;
figure
bar(grafica_tiempo,'stacked')

%Poner luego en Command Window
title('Experimento 2: Tiempo medio (Cálculo descriptor + Estimación pose) - Variación de CNN')
xlabel('Mejor capa de cada CNN')
ylabel('Tiempo (ms)')
legend('Cálculo descriptor','Estimación pose')
xticklabels({'conv4-1 (CNN VGGNet-19)','res3a-branch2a (CNN ResNet-50)'})
