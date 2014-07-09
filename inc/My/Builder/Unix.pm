package My::Builder::Unix;

use strict;
use warnings;

use File::Copy qw/move cp/;

use base 'My::Builder';

sub prebuild {
    my $self = shift;
    my $dst = $self->notes('src_dir') . '/Makefile';
    my $src = $self->base_dir . '/inc/Makefile';
    cp($src, $dst) or die("Can't cp $src $dst: $!");
    print STDERR "Original Makefile has been overwritten.\n";
    my $malloc_h_patch = $self->base_dir . '/inc/malloc_stdlib_h.patch';
    $self->apply_patch($self->notes('src_dir'), $malloc_h_patch);
}

1;
