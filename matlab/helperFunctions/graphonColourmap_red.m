function [ cmap ] = graphonColourmap_red(nColors)
%graphonColourmap A nice colourmap for
%

 % the default number of colors is 180
 if ~exist('nColors','var')
      nColors = 180;
 end

load xkcd_rgb_data.mat

%cmap = [colorramp_new( 'dark blue',rgb('dark blue')*2,nColors*45/180);colorramp_new( rgb('dark blue')*2,'white',nColors*15/180) ;colorramp_new( 'white',redBetween,nColors*10/180);colorramp_new( redBetween,'dark red',nColors*110/nColors)];
cmap = colorramp_new( 'white','dark red',nColors);

end
