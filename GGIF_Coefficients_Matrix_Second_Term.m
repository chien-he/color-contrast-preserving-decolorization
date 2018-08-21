%%%L, a, b: input image. 
%%%Gamma_1: 9x9 matrix
%%%Gamma_2: 9x1 vector
function [Gamma_1] = GGIF_Coefficients_Matrix_Second_Term(I,  T_step)

[height,width, color]=size(I);

Gamma_1 = zeros(3,3);


%%Coefficients associated with the second term in the cost function

for ii=1:T_step:height-1
    for jj=1:T_step:width
        for j=1:3
            tmp1 = I(ii+1,jj,j)-I(ii,jj,j); 
            for i=1:3
                Gamma_1(i,j) = Gamma_1(i,j)+tmp1*(I(ii+1,jj,i)-I(ii,jj,i));
            end
        end
    end
end
for ii=1:T_step:height
    for jj=1:T_step:width-1
        for j=1:3
            tmp1 = I(ii,jj+1,j)-I(ii,jj,j);
            for i=1:3
                Gamma_1(i,j) = Gamma_1(i,j)+tmp1*(I(ii,jj+1,i)-I(ii,jj,i));
            end
        end        
    end
end

end