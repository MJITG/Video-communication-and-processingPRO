function [vals,varargout] = minmax(data,varargin)
%MINMAX  find kth smallest or largest values and their indices.                        
%                                             
% USAGE:
%         vals = minmax(data) % find minimum
%         vals = minmax(data,k) % find kth smallest values
%         vals = minmax(data,k,flag)  % find kth largest values
%         [vals,loci] = minmax(:)  
%         [vals,loci,locj] = minmax(:)  % for 2 d array
%         [vals,loci,locj,...] = minmax(:)  % for multi dimensional array
%                                             
% INPUT:
%    data - two dimensional data                                   
%    k - number of smallest or largest values required
%    flag - whether min or max
%       
% OUTPUT:
%    vals - smallest or largest values                                     
%    loci -  index to the row
%    locj - index to the column
%        
% EXAMPLES:
%    data = 1:16;
%    data = reshape(data,4,4);  
%    [out,loci,locj] = minmax(data,5)  % find the 5 smallest vaues and
%                      their locations
%   [out,loci,locj] = minmax(data,5,'max)  % find the 5 largest vaues and
%                     their locations
% 
% Limitation: 
%             
% See also: 
% Author:Durga Lal Shrestha
% CSIRO Land & Water, Highett, Australia
% eMail: durgalal.shrestha@gmail.com
% Website: www.durgalal.co.cc
% Copyright 2012 Lal Shrestha
% $First created: 27-Jul-2012
% $Revision: 1.0.0 $ $Date: 27-Jul-2012 09:58:33 $
% ***********************************************************************
%% INPUT ARGUMENTS CHECK
error(nargchk(1,3,nargin))
% Default values
k=1;
flag = 'min';
%% Input argument check
if nargin>1
    k = varargin{1};
    if nargin>2
        flag = varargin{2};
    end
end
    
% Check if k is positive scalar interger
if ~isscalar(k) || k<=0 || ischar(k)
    error('minmax:k','Second argument "k" should be positive scalar') 
end
sizeData = size(data);
dim = numel(sizeData);
if k > numel(data)
    error('minmax:k','Second argument "k" should be less than number of elements in array')
end
if strcmpi(flag,'min')
    mode = 'ascend'; 
elseif strcmpi(flag,'max')
    mode = 'descend'; 
else
   error('minmax:flag','Does not understand the third argument, should be either "min" or "max"') 
end
if nargout > dim+1
    error('minmax:nargout','Number of output argument shuold be less than dimension of data + 1') 
end
%% Calculation
[svals,idx] = sort(data(:),mode);        % sort the array
vals = svals(1:k);                       % kth smallest or largest value
% If location is requested
if nargout >1
    loc = cell(dim,1);    
    [loc{:}] = ind2sub(sizeData,idx(1:k)); 
    varargout = loc;
end

