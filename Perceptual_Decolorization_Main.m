function Perceptual_Decolorization_Main
tic;
clear all;
close all;
temp = double(imread('2.png'))./255.0;

Lambda = 1/1024;%1/1024 
T_step = 1; %%%sub-sampling
[height,width, color]=size(temp);
[Lab] = RGB2Lab(temp);

%%%%Compute Ai,j%%%%%
[Gamma_1_0,Gamma_2_0] = GGIF_Coefficients_First_Term(Lab(:,:,1), temp, T_step);
Gamma_1 = Gamma_1_0*Lambda+GGIF_Coefficients_Matrix_Second_Term(temp,  T_step);
Gamma_1 = inv(Gamma_1);
clear Gamma_1_0;

[VFx, VFy] = Absolute_Lab_Gradient_Field(Lab, T_step);
[EVFx, EVFy] = GGIF_Coefficients_Second_Term_Extended_Vector(VFx, VFy, temp,  T_step);

%%%%Initialize weights to R/G/B
W = zeros(3,1);
for hh=1:3
    W(hh) = 85;
end

%%% Bj and loop for weights%%%%
for k=1:8 %8
    [Gamma_2] = Gamma_2_0*Lambda+GGIF_Coefficients_Vector_Second_Term(EVFx, EVFy, temp, W, T_step);
    W = floor(256.*Gamma_1*Gamma_2);
end

clear EVFx;
clear EVFy;

%%%generate the decolorized image
L = zeros(height, width);
for ii=1:height
    for jj=1:width
        for hh=1:3
            L(ii,jj) = L(ii,jj)+W(hh)*temp(ii,jj,hh)/256;
        end
    end
end

%%%normalization
AAA = max(max(L(:,:)));
aaa = min(min(L(:,:)));
L = (L-aaa)/(AAA-aaa);
imwrite(L, '2_Initial.png','png');

%%%Produce the final image using the structure transfer filter

%%%extract the locally fine detail
[gvf_x, gvf_y] = Signed_Vector_Field_Generation(L, VFx, VFy);
Lambda = 3/8;
L = Fast_Structure_Transfer_Filter(L, gvf_x, gvf_y,Lambda);
%%%normalization
AAA = max(max(L(:,:)));
aaa = min(min(L(:,:)));
L = (L-aaa)/(AAA-aaa);

figure('Name','L_final'); imshow(L); 
imwrite(L, '2_Final.png','png');
runtime = toc;
fprintf('the running time is %f\n', runtime);
end

