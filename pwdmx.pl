#!/usr/local/bin/perl

# vim: ai si sw=4 sts=4 et

# normal junk #AAA
use warnings;
use strict;
use v5.14;
use experimental qw(switch);

use Getopt::Long qw( :config no_ignore_case auto_help );
#my %opts;
#my @opts;
#my @commands;
#GetOptions( \%opts, @opts, @commands ) or die 'something goes here';
#use Pod::Usage;
#use File::Basename;
#use Cwd;

use Path::Tiny;
use JSON::PP;
use Data::Printer;

#BEGIN {
#    use experimental qw(smartmatch);
#    unshift @INC, grep {! ($_ ~~ @INC)} map {"$_"} grep {path($_)->is_dir} map {path("$_/lib")->realpath} '.', '..';
#}
#use Menu;

#ZZZ

my %chars = (
    upper => 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
    lower => 'abcdefghijklmnopqrstuvwxyz',
    digit => '0123456789',
    special => '~`!@#$%^&*-_=+\|;:,./?"()[]{}<>'."'",
);
$chars{alnum} = $chars{lower}.$chars{digit};
$chars{Alnum} = $chars{upper}.$chars{digit};
$chars{char} = $chars{upper}.$chars{lower}.$chars{digit}.$chars{special};
# remake chars as a hash of arrays.
$chars{$_} = [split //, $chars{$_}] for keys %chars;
p %chars;
die;

my $pattern = udls;
my $count = 100;
GetOptions( 'pattern|p=s'=>\$pattern, 'count|c=i'=>\$count ) or die 'something goes here';
my @base = split //, $pattern;
p @base;

my @list;
for (split //,$pattern) {
    when (/c/) {$key = 'char'}
    when (/a/) {$key = 'alnum'}
    when (/A/) {$key = 'Alnum'}
    when (/u/) {$key = 'upper'}
    when (/l/) {$key = 'lower'}
    when (/d/) {$key = 'digit'}
    when (/s/) {$key = 'special'}
    push @list, $chars{$key}[];
}
p @list;
