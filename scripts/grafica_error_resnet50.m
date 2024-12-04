%Cargar matrices para C, N y S con parámetros
directorio_Cloudy = 'Saarbrücken_Pano_Test_Cloudy/';
directorio_Night = 'Saarbrücken_Pano_Test_Night/';
directorio_Sunny = 'Saarbrücken_Pano_Test_Sunny/';

load(sprintf('%sExp1MatrizResultadosCNNresnet50_dConvC',directorio_Cloudy));
load(sprintf('%sExp1MatrizResultadosCNNresnet50_dConvN',directorio_Night));
load(sprintf('%sExp1MatrizResultadosCNNresnet50_dConvS',directorio_Sunny));

% Gráfica error localización
filas = 5; columnas = 3;
grafica_error_medio = zeros(filas,columnas);

for fila = 1:5
        grafica_error_medio(fila,:) = [exp1matriz_parametrosCNNresnet50Cloudy(fila,3),exp1matriz_parametrosCNNresnet50Night(fila,3),exp1matriz_parametrosCNNresnet50Sunny(fila,3)]; 
end

grafica_error_medio = grafica_error_medio*100;
figure
bar(grafica_error_medio)

%Poner luego en Command Window
title('Experimento 1: Error localización medio - CNN ResNet-50')
xlabel('Descriptores CNN ResNet-50')
ylabel('Error (cm)')
legend('Cloudy','Night','Sunny')
xticklabels({'conv1','res2a-branch2a','res3a-branch2a','res4a-branch2a','res5a-branch2a'})
