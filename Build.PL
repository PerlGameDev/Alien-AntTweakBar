use 5.006;
use strict;
use warnings;

use Alien::Base::ModuleBuild;
use Cwd;
use Config;

my $perlbin = $Config{perlpath};
my $version = 0.01;

my $pkg_generator = getcwd . "/inc/" . "pkg-config-generate.pl";

my $builder = Alien::Base::ModuleBuild->new(
    module_name         => 'Alien::AntTweakBar',
    license             => 'perl',
    dist_author         => q{basiliscos <dmol@gmx.com>},
#    dist_version_from   => 'lib/Alien/AntTweakBar.pm',
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

    alien_name => 'libanttweakbar',
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
        $perlbin." $pkg_generator %p/libanttweakbar.pc %s $version",
        'make -C "%p/src"',
    ],
    alien_install_commands => [
        'install -D %p/lib/libAntTweakBar.so %s/lib/libAntTweakBar.so',
        'install -D %p/include/AntTweakBar.h %s/include/AntTweakBar.h',
        $perlbin.' -e "use Alien::AntTweakBar; print Alien::AntTweakBar::VERSION"',
    ],
);

$builder->config_data->{version} = $version;

$builder->create_build_script;
