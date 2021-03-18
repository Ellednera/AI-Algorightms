#!/usr/bin/perl

use strict;
use warnings;
use 5.010;

# Video
# https://www.youtube.com/watch?v=_e64FiDWvqs

# Implementing the codes
# 思路： 遍历一堆数组，然后在遍历每个数组
	# 遍历第一个数组， 然后用每一项来检查下一个数组，如果constraint破功，
	# 那么用最深一层的数组的下一个元素做检查，如果没有破功，再对更深一层的数组多比较，以此类推
	# 答案找到就收工 :)
	# 这个是 backtracking
	
# 暂时用硬编码的方式
# my @row_a = (1, 2, 3);
# my @row_b = (1, 2, 3);
# my @row_c = (1, 2, 3);

# my @row_a = (3, 10);
# my @row_b = (4, 5, 7);
# my @row_c = (2, 1, 3);

# my @row_a = (10);
# my @row_b = (4);
# my @row_c = (1, 2);

my @row_a = (1, 2, 6, 33, 10);
my @row_b = (45, 31, 23);
my @row_c = (1, 2, 7, 5);

# constraints (条件，一定要符合， 不然就不是答案)
	# A > B
	# B != C
	# A != C
# Step 1: A=1(check constraints, ok, move on to B), 
	# A=1,B=1 (broken)
# Step 2: A=1, B=2 broken
# Step 3： A=1, B=3 broken
# (A against all B, but all broken)
# new set
# Step 1: A=2, B=1(no problem, move on with C, right now C has nothing)
# Step 1-2: A=2, B=1, C=1 broken
# Step 2: A=2, B=1, C=2 broken
# Step 3: A=2, B=1, C=3 :)
# OI! This is a depth-first search with constraints, more like an A* search

find_solution();

# this is just a cross profuct checking :)
# check out these modules
	# Set::CrossProduct by brian
	# Math::Cartesian::Product by Philip R Brenan
sub find_solution {
	A:for my $A (@row_a) {
		B:for my $B (@row_b) {
			next B if $A <= $B;
			C:for my $C (@row_c) {
				# say "($A,$B,$C)";
				if ( ($B != $C) and ($A != $C) ) {
					say "Solution found: a=$A,b=$B,c=$C";
					last A;
				}
			}
		}
	}
}

# use Benchmark;

# timethis(-1, \&find_solution);


# besiyata d'shmaya


