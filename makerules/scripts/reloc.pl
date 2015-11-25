#!/usr/bin/env perl
###############################################################################
# Auto dependency relocator
#
#    Parameter 1: absolute path of new PWD
#    Parameter 2: absolute path of old PWD
#    Parameter 3: file to process
#
# This script will parse a .d file generated by gcc and convert all paths
# found (targets and dependencies) first to absolute paths using the
# old PWD and then back to a relative path using the new PWD.
#
# The files that it reads I believe need to exist or an error will be
# thrown.  This should probably be fixed.
use File::Spec;
use Cwd 'abs_path';
# Get command line parameters
my $new_root = shift;
my $old_root = shift;
my $file     = shift;
# Open the .d file that we will process
open f, $file or die $!;
# Loop over the lines in the file
while (<f>) {
    # If we have a blank line then just echo it and skip to next line
    if (/^$/) {
        print "\n";
        next;
    }
    my $line = "";
    /^/;
    # First check for a target (note we only allow for one target per line)
    if ($' =~ m/^([^ ]+):/) {
        $line = "$line" . fix_path($1) . ":";
    }
    # Next check for one or more dependencies.  It seems that even when
    # gcc puts a dependency on its own line it will always precede it with
    # a space.
    if ($' =~ m/((?: +[^\\ ]+)+)/) {
        $dep = $&;
        while ($dep =~ m/ +([^ ]+)/g) {
            $line = "$line " . fix_path($1);
        }
    }
    # Now check for the backslash at the end
    if ($' =~ m/ \\$/) {
        $line = "$line \\";
    }
    # Print the final processed line
    print "$line\n";
}

# This function takes a single path as parameter which is interpreted
# as a path relative to old_root.  It then transforms this into a path
# relative to new_root.
sub fix_path {
    $path = shift;
    # If it starts with a forward slash then it is an absolute path
    # and we should not touch it.
    if ($path =~ /^\//) {
        return $path;
    }
    my $abs = abs_path($old_root . "/" . $path);
    return File::Spec->abs2rel($abs, $new_root);
}

