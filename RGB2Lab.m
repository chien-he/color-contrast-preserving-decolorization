%%%I: input image. RGB
%%%L,a,b: L ,a ,b components
function [Lab] = RGB2Lab(I)

[height,width,color]=size(I);

Lab = zeros(height,width, color);

beta1 = 5; %%6; %%%control the contribution of a and b components
beta2 = 2;

Y = zeros(3,1);
for ii=1:height
    for jj=1:width
        for hh = 1:3
%%convert RGB to linear RGB            
            if I(ii,jj,hh)>0.04045
                Y(hh) = ((I(ii,jj,hh)+0.055)/(1+0.055))^2.4;
            else
                Y(hh) = I(ii,jj,hh)/12.92;
            end
        end
%%%convert linear RGB to XYZ and then to Lab        
        Lab(ii,jj,1) = (0.4124*Y(1)+0.3576*Y(2)+0.1805*Y(3));
        Lab(ii,jj,2) = (0.2126*Y(1)+0.7152*Y(2)+0.0722*Y(3));
        Lab(ii,jj,3) = (0.0193*Y(1)+0.1192*Y(2)+0.9505*Y(3));
    end
end
figure('Name','Y_final'); imshow(Lab(:,:,2));
U = zeros(3,1);
U(1) = 0.9505;
U(2) = 1;
U(3) = 1.089;

delta = 6/29;


for ii=1:height
    for jj=1:width
        for ll=1:3
            Y(ll) = Lab(ii,jj,ll)/U(ll); 
            if Y(ll)>delta^3
                Y(ll) = Y(ll)^(1/3);
            else
                Y(ll) = Y(ll)/(3*delta^2)+4/29;
            end
        end
        Lab(ii,jj,1) = (116*Y(2)-16)/100;   
        Lab(ii,jj,2) = beta1*(Y(1)-Y(2));
        Lab(ii,jj,3) = beta2*(Y(2)-Y(3));
    end
end
clear Y;
figure('Name','L_final'); imshow(Lab(:,:,1));
end