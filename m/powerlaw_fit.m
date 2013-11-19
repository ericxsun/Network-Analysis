function [alpha, xmin, D] = powerlaw_fit(X, varargin)
%POWERLAW_FIT Fit a power law distributional model the data X.
%   [alpha, xmin, D] = POWERLAW_FIT(X) estimates xmin and alpha according
%   to the goodness-of-fit based method described in Ref[1]. X is a vector
%   of observations of some quantity to which we wish to fit the power law
%   distribution p(x) ~ x^-alpha for x >= xmin.
%
%   Algorithm:
%   Step 1. For each possible choice of xmin, we estimate alpha via the
%           method of maximum likelihood, and calculate the Kolmogorov-
%           Semirnov goodness-of-fit statistic D.
%   Step 2. We then select as our estimation of xmin, the value that gives
%           the minimum value D over all values of xmin.
%
%   Note:
%   1. For discrete data, if min(x) > 1000, POWERLAW_FIT uses the
%      continuous approximation, which is a reliable in this regime.
%   2. This procedure gives no estimation of the uncertainty of the fitted
%      parameters, nor of the validity of the fit.
%
%   3. In order to implement the integer-based methods in Matlab, the 
%      numeric maximization of the log-likelihood function was used. This 
%      requires that we specify the range of scaling parameters considered.
%      We set this range to be [1.50 : 0.01 : 3.50] by default. This vector
%      can be set by the user like so,
%    
%       alpha = POWERLAW_FIT(X, 'range', [1.001 : 0.001 : 5.001]);
%    
%   4. POWERLAW_FIT can be told to limit the range of values considered as 
%      estimates for xmin in two ways. First, it can be instructed to 
%      sample these possible values like so,
%    
%       alpha = POWERLAW_FIT(X, 'sample', 100);
%    
%      which uses 100 uniformly distributed values on the sorted list of
%      unique values in the data set. Alternatively, it can simply omit all
%      candidates below a hard limit, like so,
%    
%       alpha = POWERLAW_FIT(X, 'limit', 3.4);
%    
%      In the case of discrete data, it rounds the limit to the nearest
%      integer.
% 
%   5. When the input sample size is small (e.g., < 100), the continuous 
%      estimator is slightly biased (toward larger values of alpha). To
%      explicitly use an experimental finite-size correction, call PLFIT 
%      like so,
%    
%       alpha = POWERLAW_FIT(X, 'smallsize');
%    
%      which does a small-size correction to alpha.
%
%   Example:
%
%   Ref:
%   1. Clauset A, Shalizi C R, Newman M E J. Power-law distributions in 
%      empirical data[J]. SIAM review, 2009, 51(4): 661-703.
%   2. http://tuvalu.santafe.edu/~aaronc/powerlaws/
%
%   See also:
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/12/19 09:00$
%

%--------------------------------------------------------------------------

vec    = [];
sample = [];
limit  = [];
finite = false;
nowarn = false;

% parse command-line parameters; trap for bad input
i = 1; 
while i <= length(varargin)
  argok = 1; 
  
  if ischar(varargin{i})
    switch varargin{i}
        case 'range',   vec    = varargin{i+1}; i = i + 1;
        case 'sample',  sample = varargin{i+1}; i = i + 1;
        case 'limit',   limit  = varargin{i+1}; i = i + 1;
        case 'finite',  finite = true;          i = i + 1;
        case 'nowarn',  nowarn = true;          i = i + 1;
        otherwise,      argok  = 0; 
    end
  end
  
  if ~argok
    disp(['Ignoring invalid argument #' num2str(i+1)]); 
  end
  
  i = i + 1; 
end

if ~isempty(vec) && (~isvector(vec) || min(vec)<=1)
	fprintf('Error: ''range'' argument must contain a vector;');
    fprintf('using default.\n');
    vec = [];
end

if ~isempty(sample) && (~isscalar(sample) || sample<2)
	fprintf('Error: ''sample'' argument must be a positive integer > 1;');
    fprintf('using default.\n');
    sample = [];
end

if ~isempty(limit) && (~isscalar(limit) || limit<1)
	fprintf('Error: ''limit'' argument must be a positive value >= 1;');
    fprintf('using default.\n');
    limit = [];
end

% reshape input vector
X = reshape(X, numel(X), 1);

% select method (discrete or continuous) for fitting
if isempty(setdiff(X,floor(X)))
    f_dattype = 'INTS';
elseif isreal(X)
    f_dattype = 'REAL';
else
    f_dattype = 'UNKN';
end

if strcmp(f_dattype,'INTS') && min(X) > 1000 && length(X)>100
    f_dattype = 'REAL';
end

% estimate xmin and alpha, accordingly
switch f_dattype
    case 'REAL'
        xmins = unique(X);
        xmins = xmins(1 : end-1);
        
        if ~isempty(limit)
            xmins(xmins>limit) = [];
        end
        
        if ~isempty(sample)
            xmins = xmins(unique(round(linspace(1,length(xmins),sample))));
        end
        
        dat = zeros(size(xmins));
        z   = sort(X);
        
        for xm = 1 : length(xmins)
            xmin = xmins(xm);
            z    = z(z>=xmin); 
            n    = length(z);
            
            % estimate alpha using direct MLE
            alpha = n ./ sum(log(z./xmin));
            
            % compute KS statistic
            cx      = (0:n-1)'./ n;
            cf      = 1-(xmin./z).^alpha;
            dat(xm) = max( abs(cf-cx) );
        end
        
        D     = min(dat);
        xmin  = xmins(find(dat<=D,1,'first'));
        z     = X(X>=xmin);
        n     = length(z); 
        alpha = 1 + n ./ sum( log(z./xmin) );
        
        if finite
            alpha = alpha*(n-1)/n+1/n; 
        end; % finite-size correction
        
        if n < 50 && ~finite && ~nowarn
            fprintf('Warning: finite-size bias may be present.\n');
        end

    case 'INTS',
        
        if isempty(vec)
            vec  = (1.50 : 0.01 : 3.50); % covers range of most practical 
        end                              % scaling parameters
        
        zvec = zeta(vec);

        xmins = unique(X);
        xmins = xmins(1:end-1);
        if ~isempty(limit)
            limit = round(limit);
            xmins(xmins>limit) = [];
        end
        
        if ~isempty(sample)
            xmins = xmins(unique(round(linspace(1,length(xmins),sample))));
        end
        
        if isempty(xmins)
            fprintf('Error: x must contain at least two unique values.\n');
            alpha = NaN; xmin = X(1); D = NaN;
            return;
        end
        
        xmax = max(X);
        dat  = zeros(length(xmins),2);
        z    = X;

        for xm = 1 : length(xmins)
            xmin = xmins(xm);
            z    = z(z>=xmin);
            n    = length(z);
            
            % estimate alpha via direct maximization of likelihood function
            try
                % vectorized version of numerical calculation
                zdiff = sum( repmat((1:xmin-1)',1,length(vec)).^-repmat(vec,xmin-1,1) ,1);
                L = -vec.*sum(log(z)) - n.*log(zvec - zdiff);
            catch ME
                disp(ME.identifier);
                
                % iterative version (more memory efficient, but slower)
                L       = -Inf*ones(size(vec));
                slogz   = sum(log(z));
                xminvec = (1:xmin-1);
                
                for k=1:length(vec)
                    L(k) = -vec(k)*slogz - n*log(zvec(k) - sum(xminvec.^-vec(k)));
                end
            end
            
            [~, I] = max(L);
            
            % compute KS statistic
            fit = cumsum((((xmin:xmax).^-vec(I)))./ (zvec(I) - sum((1:xmin-1).^-vec(I))));
            cdi = cumsum(hist(z,xmin:xmax)./n);
            dat(xm,:) = [max(abs( fit - cdi )) vec(I)];
        end
        
        %select the index for the minimum value of D
        [D, I] = min(dat(:, 1));
        xmin   = xmins(I);
        n      = sum(X>=xmin);
        alpha  = dat(I, 2);
        
        if finite
            alpha = alpha*(n-1)/n+1/n; 
        end % finite-size correction
        
        if n < 50 && ~finite && ~nowarn,
            fprintf('Warning: finite-size bias may be present.\n');
        end;

    otherwise,
        fprintf('Error: x must contain only reals or only integers.\n');
        alpha = [];
        xmin  = [];
        D     = [];
        return;
end

%--------------------------------------------------------------------------
end