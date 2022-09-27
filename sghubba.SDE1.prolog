%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ECE3520/CpSc3520 SDE1: Prolog Declarative and Logic Programming

% Use the following Prolog relations as a database of familial
% relationships for 4 generations of people.  If you find obvious
% minor errors (typos) you may correct them.  You may add additional
% data if you like but you do not have to.

% Then write Prolog rules to encode the relations listed at the bottom.
% You may create additional predicates as needed to accomplish this,
% including relations for debugging or extra relations as you desire.
% All should be included when you turn this in.  Your rules must be able
% to work on any data and across as many generations as the data specifies.
% They may not be specific to this data.

% Using SWI-Prolog, run your code, demonstrating that it works in all modes.
% Log this session and turn it in with your code in this (modified) file.
% You examples should demonstrate working across 4 generations where
% applicable.

% Fact recording Predicates:

% list of two parents, father first, then list of all children
% parent_list(?Parent_list, ?Child_list).

% Data:

parent_list([fred_smith, mary_jones],
            [tom_smith, lisa_smith, jane_smith, john_smith]).

parent_list([tom_smith, evelyn_harris],
            [mark_smith, freddy_smith, joe_smith, francis_smith]).

parent_list([mark_smith, pam_wilson],
            [martha_smith, frederick_smith]).

parent_list([freddy_smith, connie_warrick],
            [jill_smith, marcus_smith, tim_smith]).

parent_list([john_smith, layla_morris],
            [julie_smith, leslie_smith, heather_smith, zach_smith]).

parent_list([edward_thompson, susan_holt],
            [leonard_thompson, mary_thompson]).

parent_list([leonard_thompson, lisa_smith],
            [joe_thompson, catherine_thompson, john_thompson, carrie_thompson]).

parent_list([joe_thompson, lisa_houser],
            [lilly_thompson, richard_thompson, marcus_thompson]).

parent_list([john_thompson, mary_snyder],
            []).

parent_list([jeremiah_leech, sally_swithers],
            [arthur_leech]).

parent_list([arthur_leech, jane_smith],
            [timothy_leech, jack_leech, heather_leech]).

parent_list([robert_harris, julia_swift],
            [evelyn_harris, albert_harris]).

parent_list([albert_harris, margaret_little],
            [june_harris, jackie_harris, leonard_harris]).

parent_list([leonard_harris, constance_may],
            [jennifer_harris, karen_harris, kenneth_harris]).

parent_list([beau_morris, jennifer_willis],
            [layla_morris]).

parent_list([willard_louis, missy_deas],
            [jonathan_louis]).

parent_list([jonathan_louis, marsha_lang],
            [tom_louis]).

parent_list([tom_louis, catherine_thompson],
            [mary_louis, jane_louis, katie_louis]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/*
MY FAMILY INFORMATION
The following is my family info, designed to help me properly understand
cousin types and test out both types of cousin removals.
*/
parent_list([joseph_hubbarth, amy_rothert],
            [zach_hubbarth, quinn_hubbarth, skylar_hubbarth]).

parent_list([frank_lepera, jennifer_hubbarth],
            [maddie_lepera, mike_lepera]).

parent_list([jason_hubbarth, meg_hubbarth],
            [jack_hubbarth]).

parent_list([jason_hubbarth, geena_idk],
            [cayman_hubbarth, colin_hubbarth]).

parent_list([oldjack_hubbarth, gini_reuter],
            [joseph_hubbarth, jennifer_hubbarth, jason_hubbarth]).

parent_list([cayman_hubbarth, some_girl],
            [first_once_removed_basic]).

parent_list([first_once_removed_basic, someone_else],
            [first_twice_removed_basic]).

parent_list([first_twice_removed_basic, someone_else],
            [first_thrice_removed_basic]).

parent_list([great_grandpa, great_grandma],
            [oldjack_hubbarth, great_uncle]).

parent_list([great_uncle, great_aunt],
            [first_once_removed_complicated]).

parent_list([great_great_grandpa, great_great_grandma],
            [great_grandpa, great_grand_uncle]).

parent_list([great_grand_uncle, great_grand_aunt],
            [first_twice_removed_complicated]).

parent_list([first_once_removed_complicated, someone_else],
            [second_cousin]).

parent_list([first_twice_removed_complicated, someone_else],
            [second_once_removed_complicated]).

parent_list([second_cousin, someone_else],
            [second_once_removed_basic]).

parent_list([second_once_removed_basic, someone_else],
            [second_twice_removed]).

parent_list([second_twice_removed, someone_else],
            [second_thrice_removed]).

parent_list([second_once_removed_complicated, someone],
            [third_cousin]).

parent_list([third_cousin, somebody],
            [third_once_removed]).

parent_list([third_once_removed, someone],
            [third_twice_removed]).

parent_list([third_twice_removed, someone],
            [third_thrice_removed]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/* Facts for gender rules */

male(joe_smith).
male(frederick_smith).
male(marcus_smith).
male(tim_smith).
male(zach_smith).
male(richard_thompson).
male(marcus_thompson).
male(timothy_leech).
male(jack_leech).
male(kenneth_harris).
male(P) :- parent_list([P|_],_).

female(francis_smith).
female(martha_smith).
female(jill_smith).
female(julie_smith).
female(leslie_smith).
female(heather_smith).
female(mary_thompson).
female(carrie_thompson).
female(lilly_thompson).
female(heather_leech).
female(june_harris).
female(jackie_harris).
female(jennifer_harris).
female(karen_harris).
female(mary_louis).
female(jane_louis).
female(katie_louis).
female(P) :- parent_list([_|[P|_]],_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SWE1 Assignment - Create rules for:

% parent(?Parent, ?Child).
parent(P,C) :- parent_list(PL,CL), member(P,PL), member(C,CL).

% married(?Husband, ?Wife).
married(H,W) :- parent_list(PL,_), member(H,PL), member(W,PL), H\=W.

% ancestor(?Ancestor, ?Person).
ancestor(A,P) :- parent(A,P).
ancestor(A,P) :- parent(A,X), ancestor(X,P).

% descendant(?Descendant, ?Person).
descendant(D,P) :- parent(P,D).
descendant(D,P) :- parent(X,D), parent(P,X).

% common_ancestor(?Person1, ?Person2, ?Ancestor).
common_ancestor(P1,P2,A) :- ancestor(A,P1), ancestor(A,P2).

% blood(?Person1, ?Person2). %% blood relative
blood(P1,P2) :- ancestor(X,P1), ancestor(X,P2), X\=P1, X\=P2.

% sibling(?Person1, ?Person2).
sibling(P1,P2) :- parent_list(_,CL), member(P1,CL), member(P2,CL), P1\=P2.

% father(?Father, ?Child).
father(F,C) :- parent(F,C), male(F).

% mother(?Mother, ?Child).
mother(M,C) :- parent(M,C), female(M).

% uncle(?Uncle, ?Person). %%
uncle(U,P) :- parent(X,P), sibling(X,U), male(U).
uncle(U,P) :- parent(X,P), sibling(X,S), married(U,S), male(U).

% aunt(?Aunt, ?Person). %%
aunt(A,P) :- parent(X,P), sibling(X,A), female(A).
aunt(A,P) :- parent(X,P), sibling(X,S), married(S,A), female(A).

% grandparent(?Grandparent, ?Person).
grandparent(GP,P) :- parent(X,P), parent(GP,X).

/* Ancestor count helper to keep track of the recursion depth */
% ancestor_count(?Ancestor, ?Person, ?Number).
ancestor_count(A,P,N) :- parent(A,P), N is 1;
    parent_list(PL,CL), member(A,PL), member(C,CL),
      ancestor_count(C,P,N2), N is N2+1.

/* Helper to find the least common ancestor */
% lca(?Person1, ?Person2, ?Ancestor).
lca(P1,P2,A) :- father(A,P1), father(A,P2), P1 \== P2.
lca(P1,P2,A) :- father(A,P1), father(A,P4), P1 \== P4, ancestor(P4, P2).
lca(P1,P2,A) :- father(A,P3), ancestor(P3,P1), father(A,P2), P3\== P2.
lca(P1,P2,A) :- father(A,P3), ancestor(P3, P1), father(A,P4), P3 \== P4,
  ancestor(P4, P2).

% cousin(?Cousin, ?Person).
cousin(C,P) :- lca(C,P,A), ancestor_count(A,C,X),
  ancestor_count(A,P,Y), X > 1, Y > 1.

%% 1st cousin, 2nd cousin, 3rd once removed, etc.
% cousin_type(+Person1, +Person2, -CousinType, -Removed).
cousin_type(P1,P2,T,R) :- ancestor_count(A,P1,C1),
  ancestor_count(A,P2,C2), C1>1, C2>1, T is (min(C1,C2)-1), R is abs(C1-C2).
