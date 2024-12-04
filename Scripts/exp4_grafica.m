%Cargar matrices para C, N y S con parámetros
directorio_Cloudy = 'Saarbrücken_Pano_Test_Cloudy/';
directorio_ruido = 'Saarbrücken_Ruido_Test_Cloudy/';
directorio_oclusiones = 'Saarbrücken_Oclusiones_Test_Cloudy/';
directorio_blur = 'Saarbrücken_Blur_Test_Cloudy/';

load(sprintf('%sExp1MatrizResultadosCNNVGG19_dConvC',directorio_Cloudy));
load(sprintf('%sExp1MatrizResultadosCNNresnet50_dConvC',directorio_Cloudy));
load(sprintf('%sExp4MatrizResultadosCNNVGG19_dConvC',directorio_ruido));
load(sprintf('%sExp4MatrizResultadosCNNresnet50_dConvC',directorio_ruido));
load(sprintf('%sExp4MatrizResultadosCNNVGG19_dConvC',directorio_oclusiones));
load(sprintf('%sExp4MatrizResultadosCNNresnet50_dConvC',directorio_oclusiones));
load(sprintf('%sExp4MatrizResultadosCNNVGG19_dConvC',directorio_blur));
load(sprintf('%sExp4MatrizResultadosCNNresnet50_dConvC',directorio_blur));

% Gráfica error localización
filas = 2; columnas = 4;
grafica_error_medio = zeros(filas,columnas);

grafica_error_medio(1,:) = [exp1matriz_parametrosCNNVGG19Cloudy(4,3),exp4matriz_parametrosCNNVGG19Cloudy(1,3),exp4matriz_parametrosCNNVGG19CloudyOclusiones(1,3),exp4matriz_parametrosCNNVGG19CloudyBlur(1,3)]; 
grafica_error_medio(2,:) = [exp1matriz_parametrosCNNresnet50Cloudy(3,3),exp4matriz_parametrosCNNresnet50Cloudy(1,3),exp4matriz_parametrosCNNresnet50CloudyOclusiones(1,3),exp4matriz_parametrosCNNresnet50CloudyBlur(1,3)]; 

grafica_error_medio = grafica_error_medio*100;
figure
bar(grafica_error_medio)

%Poner luego en Command Window
%title('Experimento 4: Error localización medio')
%xlabel('Descriptores')
%ylabel('Error (cm)')
%legend('Sin efectos','Ruido','Oclusiones','Efecto Blur')
%xticklabels({'conv4-1 (CNN VGGNet-19)','res3a-branch2a (CNN ResNet-50)'})

