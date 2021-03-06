% computeOnsOffs.m
% given a logical vector x, this function returns the on and off times of the logical vector
% usage:
%  [ons,offs] = computeOnsOffs(x)
% created by Srinivas Gorur-Shandilya at 10:20 , 09 April 2014. Contact me at http://srinivas.gs/contact/
% 
% This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. 
% To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/.
function [ons,offs] = computeOnsOffs(x)
if ~nargin
	help computeOnsOffs
	return
else
	x = x(:);
	x = double(x);
end

x= x/max(x);
x(x<.5) = 0;
x(x>0) = 1;

ons = find(diff(x)==1);
offs = find(diff(x)==-1);

% check that the order is good
if isempty(ons)
    return
end
if isempty(offs)
    return
end
if ons(1) > offs(1)
    % the first pulse is lost. ignore it
    offs(1) = [];
end
ons = ons+1; % correct for derivative shift
if length(ons) > length(offs)
	offs = [offs; length(x)];
elseif length(offs) > length(ons)
	error('fatal: for unknown reasons, the length of offs and ons are not the same')
else
	% all OK
end