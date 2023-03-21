function [ vec ] = vector( T,M )
vec=zeros(1,M);
for i=1:M
    vec(i)=T(i);
end

