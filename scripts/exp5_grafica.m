directorio_Cloudy = 'Saarbrücken_Pano_Test_Cloudy/';
directorio_rotaciones = 'Saarbrücken_Rotaciones_Test_Cloudy/';

load(sprintf('%sExp1MatrizResultadosCNNVGG19_dConvC',directorio_Cloudy));
load(sprintf('%sExp1MatrizResultadosCNNresnet50_dConvC',directorio_Cloudy));
load(sprintf('%sExp5MatrizResultadosCNNVGG19_dConvC_Rotaciones',directorio_rotaciones));
load(sprintf('%sExp5MatrizResultadosCNNresnet50_dConvC_Rotaciones',directorio_rotaciones));

% Gráfica error localización
filas = 2; columnas = 2;
grafica_error_medio = zeros(filas,columnas);

grafica_error_medio(1,:) = [exp1matriz_parametrosCNNVGG19Cloudy(4,3),exp5matriz_parametrosCNNVGG19CloudyRotaciones(1,3)]; 
grafica_error_medio(2,:) = [exp1matriz_parametrosCNNresnet50Cloudy(3,3),exp5matriz_parametrosCNNresnet50CloudyRotaciones(1,3)]; 

grafica_error_medio = grafica_error_medio*100;
figure
bar(grafica_error_medio)

%Poner luego en Command Window
%title('Experimento 5: Error localización medio')
%xlabel('Descriptores')
%ylabel('Error (cm)')
%legend('Sin efectos','Rotación aleatoria')
%xticklabels({'conv4 (CNN VGGNet-19)','conv3 (CNN ResNet-50)'})

