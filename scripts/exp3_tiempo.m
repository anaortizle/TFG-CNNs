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
filas = 5; columnas = 2;
grafica_tiempo = zeros(filas,columnas);

grafica_tiempo(1,:) = [exp1matriz_parametrosCNNVGG19Cloudy(4,5),exp1matriz_parametrosCNNVGG19Cloudy(4,7)]; 

grafica_tiempo(2,:) = [exp1matriz_parametrosCNNresnet50Cloudy(3,5),exp1matriz_parametrosCNNresnet50Cloudy(3,7)]; 

grafica_tiempo(3,:) = [0.0741698,0.0035136]; 

grafica_tiempo(4,:) = [0.1411516,0.0012974]; 

grafica_tiempo(5,:) = [0.4155480,0.0037861]; 

grafica_tiempo = grafica_tiempo*1000;
figure
bar(grafica_tiempo,'stacked')

%Poner luego en Command Window
%title('Experimento 3: Tiempo medio (Cálculo descriptor + Estimación pose) - Comparativa entre CNNs')
%xlabel('Mejor capa de cada CNN')
%ylabel('Tiempo (ms)')
%legend('Cálculo descriptor','Estimación pose')
%xticklabels({'conv4-1 (CNN VGGNet-19)','res3a-branch2a (CNN ResNet-50)','conv2 (CNN Places)','conv4 (CNN Alexnet)','inception 3b-1x1 (CNN Googlenet)'})
