function [ cmap ] = colorramp_new( color1,color2,nColors )
%COLORRAMP Returns a colormap that interpolates between two colors
%   Input colors have to be named in accordance to xkcd
%

 % the default number of colors is thirty
 if ~exist('nColors','var')
      nColors = 30;
 end

load xkcd_rgb_data.mat

cmap=zeros(nColors,3);

% if the input colour is not a colour name but an RGB value than use it.
if ischar(color1) == 0
    RGB1 = color1;
else
    RGB1 = rgb(color1);
end
if ischar(color2) == 0
    RGB2 = color2;
else
    RGB2 = rgb(color2);
end

deltaRGB = (RGB2 - RGB1)/(nColors-1);

% linear interpolation between the colors
cmap(1,:) = RGB1; % first color
for i=2:nColors % now iterative
    cmap(i,:) = cmap(i-1,:) + deltaRGB;
end

cmap(cmap<0)=0;
cmap(cmap>1)=1;

end
