% hill2.m
% 2-parameter Hill function
% usage: r = hill2(x,xdata)
% where 
% x(1) specifies the location of the inflection point
% x(2) specifies the steepness 
% the maximum (scaling) is automatically set to the maximum of the input
% created by Srinivas Gorur-Shandilya at 10:20 , 09 April 2014. Contact me at http://srinivas.gs/contact/

% where A is the maximum
% This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. 
% To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/.
function r = hill2(xdata,K_D,n,x_offset)
switch nargin
case 0
	help hill2
	return
case 1
	help hill2
	error('Not enough inputs')
end

xdata = xdata - x_offset;
r = (xdata.^n)./(xdata.^n + K_D^n);
r(xdata<eps) = 0;
	