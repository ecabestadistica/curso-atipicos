
function[dist,out]=AdjustedMCD(data,dmcd)
[n,m]=size(data); 
if m <= 10
    pcrit = (0.24 - 0.003 * m)/sqrt(n);
end

if m > 10
    pcrit = (0.252 - 0.0018 * m)/sqrt(n);
end

%Calculate robust mahalanobis distance based on MCD
dist=(dmcd).^2;

[qchisq]=AdjustedQuantile(data,dist,pcrit);

out=find(dist>qchisq);

   
    