%Cargar matrices para C, N y S con parámetros
directorio_Cloudy = 'Saarbrücken_Pano_Test_Cloudy/';
directorio_Night = 'Saarbrücken_Pano_Test_Night/';
directorio_Sunny = 'Saarbrücken_Pano_Test_Sunny/';

load(sprintf('%sExp1MatrizResultadosCNNVGG19_dConvC',directorio_Cloudy));
load(sprintf('%sExp1MatrizResultadosCNNVGG19_dConvN',directorio_Night));
load(sprintf('%sExp1MatrizResultadosCNNVGG19_dConvS',directorio_Sunny));

% Gráfica tiempo solo Cloudy
filas = 5; columnas = 2;
grafica_tiempo_medio = zeros(filas,columnas);

for fila = 1:5
        grafica_tiempo_medio(fila,:) = [exp1matriz_parametrosCNNVGG19Cloudy(fila,5),exp1matriz_parametrosCNNVGG19Cloudy(fila,7)]; 
end

grafica_tiempo_medio = grafica_tiempo_medio*1000;
figure
bar(grafica_tiempo_medio,'stacked')

%Poner luego en Command Window
title('Experimento 1: Tiempo medio (Cálculo descriptor + Estimación pose) - CNN VGGNet-19')
xlabel('Descriptores: CNN VGGNet-19')
ylabel('Tiempo (ms)')
legend('Cáculo descriptor','Estimación pose')
xticklabels({'conv1-1','conv2-1','conv3-1','conv4-1','conv5-1'})
