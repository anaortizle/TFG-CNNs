%Cargar matrices para C, N y S con parámetros
directorio_Cloudy = 'Saarbrücken_Pano_Test_Cloudy/';
directorio_Night = 'Saarbrücken_Pano_Test_Night/';
directorio_Sunny = 'Saarbrücken_Pano_Test_Sunny/';

load(sprintf('%sExp1MatrizResultadosCNNVGG19_dConvC',directorio_Cloudy));
load(sprintf('%sExp1MatrizResultadosCNNVGG19_dConvN',directorio_Night));
load(sprintf('%sExp1MatrizResultadosCNNVGG19_dConvS',directorio_Sunny));

% Gráfica error localización
filas = 5; columnas = 3;
grafica_error_medio = zeros(filas,columnas);

for fila = 1:5
        grafica_error_medio(fila,:) = [exp1matriz_parametrosCNNVGG19Cloudy(fila,3),exp1matriz_parametrosCNNVGG19Night(fila,3),exp1matriz_parametrosCNNVGG19Sunny(fila,3)]; 
end

grafica_error_medio = grafica_error_medio*100;
figure
bar(grafica_error_medio)

%Poner luego en Command Window
title('Experimento 1: Error localización medio - CNN VGGNet-19')
xlabel('Descriptores: CNN VGGNet-19')
ylabel('Error (cm)')
legend('Cloudy','Night','Sunny')
xticklabels({'conv1-1','conv2-1','conv3-1','conv4-1','conv5-1'})

