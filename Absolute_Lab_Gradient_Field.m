%%%Lab: input image. 

function [VFx, VFy] = Absolute_Lab_Gradient_Field(Lab, T_step)

[height,width, color]=size(Lab);

VFx = zeros(height, width);
VFy = zeros(height, width);

for ii=1:T_step:height-1
    for jj=1:T_step:width
        VFy(ii,jj) = ((Lab(ii+1,jj,1)-Lab(ii,jj,1))^2+(Lab(ii+1,jj,2)-Lab(ii,jj,2))^2+(Lab(ii+1,jj,3)-Lab(ii,jj,3))^2)^0.5;
    end
end
for ii=1:T_step:height
    for jj=1:T_step:width-1         
        VFx(ii,jj) = ((Lab(ii,jj+1,1)-Lab(ii,jj,1))^2+(Lab(ii,jj+1,2)-Lab(ii,jj,2))^2+(Lab(ii,jj+1,3)-Lab(ii,jj,3))^2)^0.5;      
    end
end

end