%%%Lab: input image. 
%%%Gamma_2: 9x1 vector
function [EVFx, EVFy] = GGIF_Coefficients_Second_Term_Extended_Vector(VFx, VFy, I,  T_step)

[height,width]=size(VFx);

EVFx = zeros(height, width, 3);
EVFy = zeros(height, width, 3);



%%%Coefficients associated with the first term in the cost function

for ii=1:T_step:height-1
    for jj=1:T_step:width
        for j=1:3
            EVFy(ii,jj,j) = (I(ii+1,jj,j)-I(ii,jj,j))*VFy(ii,jj);
        end
    end
end
for ii=1:T_step:height
    for jj=1:T_step:width-1
        for j=1:3
            EVFx(ii,jj,j) = (I(ii,jj+1,j)-I(ii,jj,j))*VFx(ii,jj);
        end        
    end
end    


end