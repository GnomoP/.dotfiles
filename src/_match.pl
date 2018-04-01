#!/usr/bin/env perl
my ($pattern, $filename) = @ARGV;
$filename =~ m/$pattern/ ? print 1 : print 0;
# vim: syntax=perl
# vim: set ts=2 sw=2 tw=80 et :
