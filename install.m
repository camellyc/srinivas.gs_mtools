% install.m
% install.m is a package manager for my MATLAB code
% usage:
% install [options] package_name 
% 
% list of options:
% -f 	force, ignore warnings, OVERWRITE old installations, update
% -h 	help
% 
% list of packages available:
% 
% kontroller 				The Kontroller System (http://github.com/sg-s/kontroller/)
% srinivas.gs_mtools 		My general-purpose MATLAB toolbox (http://github.com/sg-s/srinivas.gs_mtools/)
% spikesort					Spikesorting for Kontroller  (http://github.com/sg-s/spikesort/)
% 
% created by Srinivas Gorur-Shandilya at 10:20 , 09 April 2014. Contact me at http://srinivas.gs/contact/
% 
% This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. 
% To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/.

function [] = install(varargin)
if ~nargin
	help install
	return
end
% defaults
force = 0;
p = {};

% this allows install to translate the name of a package to a URL for a zipped executable
link_root = 'https://github.com/sg-s/';
link_cap = '/archive/master.zip';

% validate inputs
for i = 1:nargin
	if strfind(varargin{i},'-')
		% it's an option
		if strmatch(varargin{i},'-h')
			help install
			return
		elseif strmatch(varargin{i},'-f')
			force = 1;
		else
			error('Unknown option')
		end
			
	else
		p{length(p)+1} = varargin(i);
	end
end



for i = 1:length(p)
	install_this = 0;
	% check for this package on the path
	[s,full_path]=searchpath(char(p{i}));
	if s
		if ~force
			warning(strcat(char(p{i}),' is already installed. To update/overwrite the old installation, use "install -f [package_name]"'))
		else
			disp(strcat('Updating package:',char(p{i})))
			install_this = 1;
			full_path=fileparts(full_path);
			if ispc
				full_path = strcat(full_path,'\');
			else
				full_path = strcat(full_path,'/');
			end
		end
	else
		install_this=1;
		% figure out where to install this
		if ispc
			full_path = winqueryreg('HKEY_CURRENT_USER',['Software\Microsoft\Windows\CurrentVersion\','Explorer\Shell Folders'],'Personal');
			full_path = strcat(full_path,'\code\');
		else
			cd ~
			full_path = cd('~');
			full_path = strcat(full_path,'/code/');
		end

	end

	if install_this

		% check if userDir exists
		if ~exist(full_path)
			mkdir(full_path)
		end

		% download what you need
		disp('Downloading files...')
		try
			outfilename = websave(strcat(full_path,char(p{i})),strcat(link_root,char(p{i}),link_cap));
		catch
			error('probably no websave, old version of matlab?')
		end

	    % unzip to target
	    disp('Extracting files...')
	    cd(full_path)
	    unzip(outfilename)

	    % delete zip file
	    delete(outfilename)

	    % are we updating or overwriting?
	    if ~force
	    	% disp('fresh install. just rename the folder and add to path')
	    	movefile(strcat(full_path,char(p{i}),'-master'),strcat(full_path,char(p{i})));
	    else
	    	% updating. trash the older folder, rename the new folder
	    	rmdir(strcat(full_path,char(p{i})),'s');
	    	movefile(strcat(full_path,char(p{i}),'-master'),strcat(full_path,char(p{i})));

	    end

	    disp('Setting path...')
	    addpath(strcat(full_path,char(p{i})))

		
	end

end


