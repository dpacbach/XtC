my $new_root = shift;
my $old_root = shift;
my $file = shift;
open f, $file or die $!;
while (<f>) {
    print;
}
