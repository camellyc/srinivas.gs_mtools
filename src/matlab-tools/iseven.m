% iseven.m
% is the number even or not?
% 
% created by Srinivas Gorur-Shandilya at 2:51 , 08 July 2015. Contact me at http://srinivas.gs/contact/
% 
% This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. 
% To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/.
function [b] = iseven(a)
if round(a/2)*2 == a
	b = 1;
else
	b=0 ;
end
b = logical(b);