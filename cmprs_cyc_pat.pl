#!/usr/local/bin/perl -w

use strict;
use Term::ANSIColor;
use Spreadsheet::XLSX;
#use HTML::Entities;
use List::Util qw[min max];
use Cwd;

sub showUsage {	print colored("Usage:   perl $0 <PAT_FILE>\n", 'green'),
			                  "Example: perl $0 CP_i3c.pat\n"};

#========================================================================================================
# Main Process
#========================================================================================================

if ($#ARGV < 0) {
   showUsage();
   exit 0;
}

my $creattime = localtime();
my $currentpath = getcwd();

printf("Time:       %s\n", $creattime);
printf("Path:       %s\n", $currentpath);
printf("Script:     %s\n", $0);
printf("Input file: %s\n", $ARGV[0]);

my $parse_file = $ARGV[0];
my $prev_line;
my $line;
my $line_cnt;
my $OUT_FILE;
my $head;

$line = "";
$line_cnt = 1;
$OUT_FILE = "";
open my $fh, "<", $parse_file or die "Can't read file: $parse_file";
while (<$fh>) {
    $prev_line = $line;
    $line = $_;
    # different line -> output to $parse_file.cmprs, same line -> accumulate line_cnt
    if($line eq $prev_line) {
        $line_cnt += 1;
    }
    else { 
        $_ = $prev_line;
        if($line_cnt == 1) {
            $OUT_FILE .= $_;
            #print "$_";
        }
        else {
            $head = sprintf "repeat %-6d", $line_cnt;
            $_ = $prev_line;
            s/             //g; #remove head space
            $_ = $head . $_;
            $OUT_FILE .= $_;
            #print "$_";
        }
        $line_cnt = 1;
    }
}
close $fh;

open $fh, ">", $parse_file.".cmprs" or die "Can't create $parse_file.cmprs";
#print $OUT_FILE;
print $fh $OUT_FILE;
close $fh;

print colored("Output file: $parse_file.cmprs\n", 'yellow');
