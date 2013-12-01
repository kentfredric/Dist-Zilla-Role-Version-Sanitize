use strict;
use warnings;

package Dist::Zilla::Role::Version::Sanitize;
BEGIN {
  $Dist::Zilla::Role::Version::Sanitize::AUTHORITY = 'cpan:KENTNL';
}
{
  $Dist::Zilla::Role::Version::Sanitize::VERSION = '0.001000';
}

# ABSTRACT: Sanitize a version from a plugin

use Moose::Role;
use Moose::Util::TypeConstraints qw(enum);

sub _normalize_normal {
  my ( $self, $orig ) = @_;
  require version;
  return version->parse($orig)->normal;
}

sub _normalize_numify {
  my ( $self, $orig ) = @_;
  require version;
  my $num = version->parse($orig)->numify;
  if ( $version =~ /(^\d+)[.](.*$)/ ) {
    my ( $sig, $mantissa ) = ( $1, $2 );
    my $got  = length $mantissa;
    my $want = $self->mantissa;
    if ( $got == $want ) {
      return $version;
    }
    $self->log( [ 'MANTISSA LENGTH != EXPECTED: WANTED %s, GOT %s, CORRECTING', $want, length $got ] );
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
  normal => '_normalize_normal',
  numify => '_normalize_numify',
);

has normal_form => ( is => ro =>, isa => enum( [ keys %normal_forms ] ), is => 'ro', lazy => 1, default => sub { 'numify' } );
has mantissa => ( is => ro =>, isa => 'Int', is => 'ro', lazy => 1, default => sub { 6 } );

around provide_version => sub {
  my ( $orig, $self, @args ) = @_;
  my $v      = $orig->( $self, @args );
  my $method = $normal_forms{ $self->normal_form };
  my $fixed  = $self->$method($v);
  $self->log("Version normalised to $v");
};

no Moose::Role;

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::Role::Version::Sanitize - Sanitize a version from a plugin

=head1 VERSION

version 0.001000

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
