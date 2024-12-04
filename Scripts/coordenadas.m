function[x y] = coordenadas(image_coordenadas)

primera_x = find(image_coordenadas == 'x') + 1;
ultima_x = find(image_coordenadas == 'y') - 2;
pos_x = image_coordenadas(primera_x:ultima_x);
x = str2double(pos_x);

primera_y = find(image_coordenadas == 'y') + 1;
ultima_y = find(image_coordenadas == 'a') - 2;
pos_y = image_coordenadas(primera_y:ultima_y);
y = str2double(pos_y);

end




