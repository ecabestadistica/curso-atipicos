function [cn]=AdjustedQuantile(X,d2,pcrit)
[n,p]=size(X);
deltan = chi2inv(0.975,p);
[d2ord,~] = sort(d2');
%Empiric dist
pchisq = chi2cdf(d2ord,p);
dif = pchisq - (0.5:n)/n;
i1 = (d2ord >= deltan);
i1 = i1;
i2 = (dif > 0);
i3 = i1+i2;
where=i3==2;
   
if sum(where) == 0 
    alphan = 0;
else
    alphan=max(dif(where));
end
    
if alphan <= pcrit
    alphan = 0;
    cn = Inf;
else
    cn = max(d2ord(n - ceil(n * alphan)), deltan);
end

end
