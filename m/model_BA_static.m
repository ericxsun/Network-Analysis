function edgeL = model_BA_static()
%MODEL_BA_STATIC Generate an undirected connected scale-free graph 
%according to the Barabasi-Albert model.
%   edgeL = MODEL_BA_STATIC(m0, m, N) generates a scale-free graph based
%   on the Barabasi-Albert model. m0, m, N are the number of nodes of an
%   initial graph, add nodes each iteration, final nodes respectively.
%
%   Algorithm:
%
%   Note:
%   1. Each line in edgeL is expressed as [src dst weight], where 'src',
%      'dst' and 'weight' stand for nodes index at the ends of an edge and 
%      its weight respectively. The node index starts at zero.
%
%   Example:
%
%   returns:
%
%   Ref:
%   1.Goh K I, Kahng B, Kim D. Universal behavior of load distribution in 
%     scale-free networks[J]. Physical Review Letters, 2001, 87(27): 278701.
%   
%   See also: MODEL_BA_GROWING, MODEL_ER, MODEL_REGULAR1DLATTICE_PBC, 
%             MODEL_REGULAR2DLATTICE_PBC, MODEL_WS
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2013/11/16 18:26$
%

%--------------------------------------------------------------------------

error('Not Implemented.');

%--------------------------------------------------------------------------
end