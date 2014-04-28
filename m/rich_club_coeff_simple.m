function phi_K = rich_club_coeff_simple(edgeL, directed, K)
%RICH_CLUB_COEFF Calculate the rich club coefficient on degree K of a
%simple graph(unweighted with no multiple edges or loops) defined by edge 
%list and direction.
%   phi_K = RICH_CLUB_COEFF(edgeL, directed, K) caculate the rich club
%   coefficient on degree K.
%
%   Algorithm:
%   The rich club coefficient is the fraction between the actual and the
%   potential number of edges among the set of nodes with degree larger
%   than K. This measure clearly reflects how densely connected the
%   nodes with degree larger than K.
%
%   V>K: the set of nodes with degree larger than K
%   N>K: the number of nodes in V>K
%   E>K: the number of edges among nodes in V>K
%   phi_K = E>K / N>K(N>K-1)/2 (phi_k in [0, 1])
%
%   Note:
%   1. Each line in edgeL is expressed as [src dst weight] or [src dst], 
%      where 'src', 'dst' and 'weight' stand for nodes index at the ends of 
%      an edge and its weight respectively. The node index starts at zero.
%
%   Example:
%       edgeL    = [0 1; 0 3; 0 4; 1 2; 1 3; 2 4];
%       directed = false;
%       K        = 2;
%
%       RICH_CLUB_COEFF(edgeL, directed, K)
%   returns:
%       1
%
%   Ref:
%   1. McAuley J J, da Fontoura Costa L, Caetano T S. Rich-club phenomenon 
%      across complex network hierarchies[J]. Applied Physics Letters,2007,
%      91(8): 084103.

%   See also: 

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2014/04/28 21:20$
%

%--------------------------------------------------------------------------

assert(size(edgeL, 2) >= 2, 'The edgeL must contain 2 columns at least.');
assert(directed == false, 'Only undirected graph is supported.');

if size(edgeL, 2) == 2
    edgeL(:, 3) = 1;
end

[~, edgeL] = iscontinuous(edgeL, directed);

deg = degrees(edgeL, directed, 'edgeL');

VgtK = deg(deg(:,2) > K, 1);
NgtK = length(VgtK);

phi_K = 0;

edges_max = NgtK * (NgtK - 1) / 2;
if edges_max > 0
   ind1 = ismember(edgeL(:, 1), VgtK);
   ind2 = ismember(edgeL(:, 2), VgtK);
   
   edges_real = sum(bitand(ind1, ind2));
   phi_K = edges_real / edges_max;
end

%--------------------------------------------------------------------------
end