function [out]=KurtosisPP(X)
[idx,~,~,~,~,~] = kur_main(X);
out=find(idx==1);