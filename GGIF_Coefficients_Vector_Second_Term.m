%%%Lab: input image. 
%%%Gamma_2: 9x1 vector
function [Gamma_2] = GGIF_Coefficients_Vector_Second_Term(EVFx, EVFy, I,  W,  T_step)

[height,width, hh]=size(I);


Gamma_2 = zeros(3,1);


%%%Coefficients associated with the first term in the cost function

for ii=1:T_step:height-1
    for jj=1:T_step:width
        tmp = W(1)*(I(ii+1,jj,1)-I(ii,jj,1));
        for i=2:3
            tmp = tmp+W(i)*(I(ii+1,jj,i)-I(ii,jj,i));
        end
        if tmp<0
            Gamma = -1;
        else
            Gamma = 1;
        end

        for j=1:3
            Gamma_2(j) = Gamma_2(j)+Gamma*EVFy(ii,jj,j);
        end
    end
end
for ii=1:T_step:height
    for jj=1:T_step:width-1
        tmp = W(1)*(I(ii,jj+1,1)-I(ii,jj,1));
        for i=2:3
            tmp = tmp+W(i)*(I(ii,jj+1,i)-I(ii,jj,i));
        end            
        if tmp<0
            Gamma = -1;
        else
            Gamma = 1;
        end

        for j=1:3
            Gamma_2(j) = Gamma_2(j)+Gamma*EVFx(ii,jj,j);
        end        
    end
end    


end