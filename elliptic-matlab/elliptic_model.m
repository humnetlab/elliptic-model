function t=elliptic_model(lat,lng,pop,varargin)
     numvarargs = length(varargin);
     if numvarargs > 3
        error('myfuns:somefun2Alt:TooManyInputs', ...
	'requires at most 3 optional inputs');
    end

    optargs = {0 "ellipse" 1};
    optargs(1:numvarargs) = varargin;
    [FLEX, option, totalSum] = optargs{:};
    r=r_distance(lat,lng);
    d=zeros(size(r));
    r(eye(size(r))==1)=inf;
    for i=1:size(r,2)
      m = r(i,:);
      mf = r(i,:) + FLEX;
      a = repmat(m,size(r,2),1);
      b = r;
      if strcmp("ellipse",option)
      	l = (a+b) < (3.*m+2*FLEX)'; 
      	d(i,:)=l*pop;
      else 
      	mf = mf';
      	d(i,:)=(a<mf|b<mf)*pop;
      end
    end
    d(eye(size(d))==1)=0;
    prodpop = pop * pop';%'
    sumpop = repmat(pop,size(pop,2),1) + repmat(pop,size(pop,2),1)';%'
    t = prodpop./(sumpop+d);
    t(eye(size(t))==1)=0;
    t = t./sum(sum(t)).*totalSum;
end

function rad = radians(degree) 
% degrees to radians
    rad = degree * pi / 180;
end; 

function d=spDistN1(ptlat,ptlng,lat,lng)
   EARTH_RADIUS=6372.8;
   dlon = radians(lng) - radians(ptlng);
   dlat = radians(lat) - radians(ptlat);
   a = sin(dlat/2.0).^2 + cos(radians(ptlat)) .* cos(radians(lat)) .* sin(dlon/2.0).^2;
   great_circle_distance = 2 * asin(sqrt(a));
   d = EARTH_RADIUS * great_circle_distance;
end



function r=r_distance(lat,lng)
   si = size(lat,1);
   r=zeros(si);
   for i=1:si;
      r(i,:)= spDistN1(lat(i),lng(i),lat,lng);
   end 
end










