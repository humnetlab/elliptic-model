M = csvread("../sampledata.csv",1,1);
t= elliptic_model(M(:,1),M(:,2),M(:,3));

T = csvread("../sample_output_ellip.csv",1,1);

if(corr(T(:),t(:))>0.99)
	disp("OK")
end

t2= elliptic_model(M(:,1),M(:,2),M(:,3),0,"union",1);


T2 = csvread("../sample_output_union.csv",1,1);

if(corr(T2(:),t2(:))>0.99)
	disp("OK")
end
