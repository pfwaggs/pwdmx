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

my $seed = srand($$);

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

# get_Block #AAA
sub get_Block {
    my $pattern = shift;
    my @list;
    for my $key (split //, $pattern) {
        my $length = 0;
        given ($key) {
            when (/c/) {$key = 'char';    $length = @{$chars{$key}}; }
            when (/a/) {$key = 'alnum';   $length = @{$chars{$key}}; }
            when (/A/) {$key = 'Alnum';   $length = @{$chars{$key}}; }
            when (/u/) {$key = 'upper';   $length = @{$chars{$key}}; }
            when (/l/) {$key = 'lower';   $length = @{$chars{$key}}; }
            when (/d/) {$key = 'digit';   $length = @{$chars{$key}}; }
            when (/s/) {$key = 'special'; $length = @{$chars{$key}}; }
        }
        push @list, $chars{$key}[int rand($length)];
    }
    return join('',@list);
}
#ZZZ

my $pattern = 'udls';
my $rows = 10;
my $cols = 10;
my $space = 3;
GetOptions( 'pattern|p=s'=>\$pattern, 'rows|r=i'=>\$rows, 'cols|c=i'=>\$cols, 'space|s=i'=>\$space ) or die 'something goes here';
$space = ' 'x$space;
printf "%2s %s%s\n", '\\', $space, join($space,map {sprintf "%*d",length $pattern,$_} (1..$rows));
for my $row (1..$rows) {
    my @line = ();
    for my $col (1..$cols) {
        push @line, get_Block($pattern);
    }
    printf "%2d:%s%s\n", $row, $space, join($space,@line);
}
