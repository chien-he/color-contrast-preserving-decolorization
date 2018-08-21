%%%L, a, b: input image. 
%%%Gamma_1: 3x3 matrix
%%%Gamma_2: 3x1 vector
function [Gamma_1, Gamma_2] = GGIF_Coefficients_First_Term(L, I, T_step)

[height,width, color]=size(L);

Gamma_1 = zeros(3, 3);
Gamma_2 = zeros(3,1);


%%%Coefficients associated with the first term in the cost function

for ii=1:T_step:height
    for jj=1:T_step:width
        for j = 1:3
            for i=1:3
                Gamma_1(i,j) = Gamma_1(i,j)+I(ii,jj,i)*I(ii,jj,j);
            end
            Gamma_2(j) = Gamma_2(j)+I(ii,jj,j)*L(ii,jj);
        end
    end
end

end