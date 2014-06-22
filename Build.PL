use 5.006;
use strict;
use warnings;
use Alien::Base::ModuleBuild;

use Config;

my $perlbin = $Config{perlpath};


my $builder = Alien::Base::ModuleBuild->new(
    module_name         => 'Alien::AntTweakBar',
    license             => 'perl',
    dist_author         => q{basiliscos <dmol@gmx.com>},
    dist_version_from   => 'lib/Alien/AntTweakBar.pm',
    configure_requires => {
        'Alien::Base' => 0,
        'Module::Build' => 0.38,
    },
    build_requires => {
        'Test::More' => 0,
        'Alien::Base' => 0,
    },
    requires => {
        'perl' => 5.006,
        'Alien::Base' => 0,
    },
    add_to_cleanup      => [ 'Alien-AntTweakBar-*' ],

    alien_name => 'anttweakbar',
    alien_repository => {
        protocol => 'http',
        host => 'downloads.sourceforge.net',
        location => '/project/anttweakbar/',
        exact_filename => 'AntTweakBar_116.zip',
    },

    ## For development, to save the download time,
    ## download the package once and put it in an 'inc' directory.
    # alien_repository => {
    #     protocol => 'local',
    #     location => 'inc',
    #     exact_filename => 'AntTweakBar_116.zip',
    # },
    alien_build_commands => [
        'make -C "%p/src"',
    ],
    alien_install_commands => [
        'cp %p/lib/libAntTweakBar.so %s',
        $perlbin.' -e "use Alien::AntTweakBar; print Alien::AntTweakBar::VERSION"',
    ],
);

$builder->create_build_script;
