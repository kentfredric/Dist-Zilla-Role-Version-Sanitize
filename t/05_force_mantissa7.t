use strict;
use warnings;

use Test::More;
use Path::Tiny;
use File::Copy::Recursive qw( rcopy );

my $dist    = 'fake_dist_05';
my $source  = Path::Tiny->new('.')->child('corpus')->child($dist);
my $tempdir = Path::Tiny->tempdir;

rcopy( "$source", "$tempdir" );

my $dist_ini = $tempdir->child('dist.ini');
BAIL_OUT("test setup failed to copy to tempdir") if not -e $dist_ini and -f $dist_ini;

use Test::Fatal;
use Test::DZil;

my $builder;

is(
  exception {
    $builder = Builder->from_config( { dist_root => "$tempdir" } );
    $builder->build;
  },
  undef,
  "dzil build ran ok"
);
is( $builder->version, '1.0020030', 'Mantissa is forced to 7 decimals' );

done_testing;

