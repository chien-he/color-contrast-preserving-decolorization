% extract detals from the vector field
function [gvf_x, gvf_y] = Signed_Vector_Field_Generation(L, VFx, VFy)
[height,width, color]=size(L);
gvf_x = zeros(height, width);
gvf_y = zeros(height, width);
for ii = 1: height-1
    for jj = 1: width
        DeltaV = L(ii+1, jj)-L(ii,jj);
        if DeltaV<0
            gvf_y(ii,jj) = - VFy(ii,jj);
        else
            gvf_y(ii,jj) = VFy(ii,jj);
        end
    end
end
for ii = 1: height
    for jj = 1: width-1
        DeltaV = L(ii, jj+1)-L(ii,jj);
        if DeltaV<0
            gvf_x(ii,jj) = - VFx(ii,jj);
        else
            gvf_x(ii,jj) = VFx(ii,jj);
        end
    end
end
end
