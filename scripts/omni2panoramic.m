function [C] = omni2panoramic(imagen,x,y)

%x y son los centros de la imagen omnidireccional

    %tienes que tener la imagen cargada en la variable "imagen"          
    A = imagen;
    
    A = double(A);
            
    panoramica = [];
    i = 1;
    j = 1;
    %for r=124:-1:30
    r1 = 220;%radio exterior
    r2 = 20; %radio interior
    w = floor((r1+r2)*pi);
    for r = r1:-1:r2 %estos son los radios exterior e interior de la imagen omni
        for var = w:-1:0

            coorx1 = floor(r*sin(var*2*pi/w)+(x));
            valorx1 = (r*sin(var*2*pi/w)+(x)) - floor(r*sin(var*2*pi/w)+(x));

            coory1 = floor(r*cos(var*2*pi/w)+(y));
            valory1 = (r*cos(var*2*pi/w)+(y)) - floor(r*cos(var*2*pi/w)+(y));

            panoramica(i,j,:) = (((2-valorx1-valory1)*A(coorx1,coory1,:)) + ((1-valorx1+valory1)*A(coorx1,coory1+1,:)) + ((1+valorx1-valory1)*A(coorx1+1,coory1,:)) + ((valorx1+valory1)*A(coorx1+1,coory1+1,:)))./4;

            j = j+1;                   
%                     if j==500
%                         disp('Aqui');
%                     end
        end
        j = 1;
        i = i+1;
    end

%    toc
    C = uint8(imresize(panoramica, [128 512],'bicubic'));
    %imshow(uint8(C))
    %imwrite(C,sprintf('panoramica512x128/%s',a(z).name));

end