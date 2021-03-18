#!/usr/bin/perl

use strict;
use warnings;
use 5.010;
use local::lib; # for Set::CrossProduct

use Set::CrossProduct;
use Benchmark;

my @row_a = (1, 2, 6, 33, 10);
my @row_b = (45, 31, 23);
my @row_c = (1, 2, 7, 5);

# Constraints
	# A > B
	# B != C
	# A != C

# find_solution();
	
my $cross_product = Set::CrossProduct->new( {
		A => [1, 2, 6, 33, 10],
		B => [45, 31, 23],
		C => [1, 2, 7, 5],
	} );
	
# find_solution_cross_product();

# let's benchmark the two codes
# timethese(0, {
	# loops => \&find_solution,
	# cross_product => \&find_solution_cross_product,
# });

timethese(0, {
	cross_product => sub {
				# my $cross_product = Set::CrossProduct->new( {
						# A => [1, 2, 6, 33, 10],
						# B => [45, 31, 23],
						# C => [1, 2, 7, 5],
					# } );
				while ( my $tuple = $cross_product->get ) {
					my @array = $tuple->@{ qw(A B C) };
					# say "@array", " - ";
					if ($array[0] > $array[1] 
						and $array[1] != $array[2] 
						and $array[0] != $array[2]) {
						# printf "Solution found: (%s,%s,%s)\n", @array;
						last;
					}
				}
			},
	loops => sub {
				# my @row_a = (1, 2, 6, 33, 10);
				# my @row_b = (45, 31, 23);
				# my @row_c = (1, 2, 7, 5);
				A:for my $A (@row_a) {
					B:for my $B (@row_b) {
						next B if $A <= $B;
						C:for my $C (@row_c) {
							# say "($A,$B,$C)";
							if ( ($B != $C) and ($A != $C) ) {
								# say "Solution found: ($A,$B,$C)";
								last A;
							}
						}
					}
				}
			},
});

# When considering the module (don't do that, the while loop is faster)
# We are interested in the checking part, not the module part
# Benchmark: running cross_product, loops for at least 3 CPU seconds...
# cross_product:  3 wallclock secs ( 3.14 usr +  0.00 sys =  3.14 CPU) @ 415.31/s(n=1302)
#         loops:  3 wallclock secs ( 3.12 usr +  0.00 sys =  3.12 CPU) @ 108876.56/s(n=339586)



# besiyata d'shmaya


