use strict;
use warnings;

package Dist::Zilla::Role::Version::Sanitize;

# ABSTRACT: Sanitize a version from a plugin

use Moose::Role;
use Moose::Util::TypeConstraints qw(enum);

sub _normalize_normal {
  my ( $self, $orig ) = @_;
  require version;
  return version->parse($orig)->normal;
}

sub _normalize_normal_3 {
  my ( $self, $orig ) = @_;
  require version;
  my $v = version->parse($orig)->normal;
  $v =~ s/^v//;
  if ( $v !~ /^\d+[.]\d+[.]\d+/ ) {
    die "Normalised string $v does not have a minimum of 3 parts";
  }
  return $v;
}

sub _normalize_numify {
  my ( $self, $orig ) = @_;
  require version;
  my $version = version->parse($orig)->numify;
  if ( $version =~ /(^\d+)[.](.*$)/ ) {
    my ( $sig, $mantissa ) = ( $1, $2 );
    my $got  = length $mantissa;
    my $want = $self->mantissa;
    if ( $got == $want ) {
      return $version;
    }
    $self->log( [ 'MANTISSA LENGTH != EXPECTED: WANTED %s, GOT %s, CORRECTING', $want, $got ] );
    if ( $want < $got ) {
      my $newman = substr( $mantissa, 0, $want );
      return $sig . q[.] . $newman;
    }
    if ( $want > $got ) {
      my $need = $want - $got;
      return $sig . q[.] . $mantissa . ( q[0] x $need );
    }
  }
  else {
    die "Could not parse mantissa from numified version";
  }
}

my %normal_forms = (
  normal   => '_normalize_normal',
  normal_3 => '_normalize_normal_3',
  numify   => '_normalize_numify',
);

has normal_form => ( is => ro =>, isa => enum( [ keys %normal_forms ] ), is => 'ro', lazy => 1, default => sub { 'numify' } );
has mantissa => ( is => ro =>, isa => 'Int', is => 'ro', lazy => 1, default => sub { 6 } );

around provide_version => sub {
  my ( $orig, $self, @args ) = @_;
  my $v      = $orig->( $self, @args );
  my $method = $normal_forms{ $self->normal_form };
  my $fixed  = $self->$method($v);
  $self->log("Version normalised from $v to $fixed");
  return $fixed;
};

around dump_config => sub {
  my ( $orig, $self, @args ) = @_;
  my $config = $orig->( $self, @args );
  my $own_config = {
    normal_form => $self->normal_form,
    mantissa    => $self->mantissa,
  };
  $config->{ '' . __PACKAGE__ } = $own_config;
  return $config;
};

no Moose::Role;

1;
