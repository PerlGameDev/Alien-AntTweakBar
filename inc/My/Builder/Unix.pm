package My::Builder::Unix;

use strict;
use warnings;

use Config;
use File::chdir;
use File::Basename;
use File::Copy qw/move cp/;
use File::Path qw/make_path/;
use File::Spec::Functions qw(catdir catfile rel2abs);

use base 'My::Builder';

sub build_binaries {
	my $self = shift;
    print STDERR "Running make ...\n";
    {
        local $CWD = rel2abs( $self->notes('src_dir') );
        $self->do_system('make') or die "###ERROR### [$?] during make ... ";
    }
    return 1;
}

sub preinstall_binaries {
    my ($self, $out) = @_;
    print STDERR "doing local installation ...\n";
    make_path("$out/lib", "$out/include");
    my $src_dir = rel2abs( $self->notes('src_dir') );
    my %intalled_files = (
        "$src_dir/../include/AntTweakBar.h"   => "$out/include/",
        "$src_dir/../lib/libAntTweakBar.a"    => "$out/lib/",
    );
    while (my ($from, $to_dir) = each %intalled_files) {
        my $to = $to_dir . basename($from);
        move($from, $to) or die("can't move $from -> $to: $!");
    }
	return 1;
}

1;
