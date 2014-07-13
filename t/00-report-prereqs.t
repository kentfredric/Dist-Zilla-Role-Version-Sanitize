#!perl

use strict;
use warnings;

# This test was generated by Dist::Zilla::Plugin::Test::ReportPrereqs 0.013

use Test::More tests => 1;

use ExtUtils::MakeMaker;
use File::Spec::Functions;
use List::Util qw/max/;
use version;

# hide optional CPAN::Meta modules from prereq scanner
# and check if they are available
my $cpan_meta = "CPAN::Meta";
my $cpan_meta_req = "CPAN::Meta::Requirements";
my $HAS_CPAN_META = eval "require $cpan_meta"; ## no critic
my $HAS_CPAN_META_REQ = eval "require $cpan_meta_req; $cpan_meta_req->VERSION('2.120900')";

# Verify requirements?
my $DO_VERIFY_PREREQS = 1;

sub _merge_requires {
    my ($collector, $prereqs) = @_;
    for my $phase ( qw/configure build test runtime develop/ ) {
        next unless exists $prereqs->{$phase};
        if ( my $req = $prereqs->{$phase}{'requires'} ) {
            my $cmr = CPAN::Meta::Requirements->from_string_hash( $req );
            $collector->add_requirements( $cmr );
        }
    }
}

my %include = map {; $_ => 1 } qw(

);

my %exclude = map {; $_ => 1 } qw(

);

# Add static prereqs to the included modules list
my $static_prereqs = do { my $x = {
       'build' => {
                    'requires' => {
                                    'Module::Build' => '0.4205'
                                  }
                  },
       'configure' => {
                        'requires' => {
                                        'Module::Build' => '0.4205'
                                      }
                      },
       'develop' => {
                      'requires' => {
                                      'Dist::Zilla::Plugin::Authority' => '1.006',
                                      'Dist::Zilla::Plugin::AutoPrereqs' => '0',
                                      'Dist::Zilla::Plugin::ConfirmRelease' => '0',
                                      'Dist::Zilla::Plugin::EOLTests' => '0',
                                      'Dist::Zilla::Plugin::Git::Check' => '0',
                                      'Dist::Zilla::Plugin::Git::Commit' => '0',
                                      'Dist::Zilla::Plugin::Git::CommitBuild' => '0',
                                      'Dist::Zilla::Plugin::Git::GatherDir' => '0',
                                      'Dist::Zilla::Plugin::Git::NextRelease' => '0',
                                      'Dist::Zilla::Plugin::Git::NextVersion::Sanitized' => '0',
                                      'Dist::Zilla::Plugin::Git::Tag' => '0',
                                      'Dist::Zilla::Plugin::GithubMeta' => '0',
                                      'Dist::Zilla::Plugin::License' => '0',
                                      'Dist::Zilla::Plugin::Manifest' => '0',
                                      'Dist::Zilla::Plugin::ManifestSkip' => '0',
                                      'Dist::Zilla::Plugin::MetaConfig' => '0',
                                      'Dist::Zilla::Plugin::MetaData::BuiltWith' => '0',
                                      'Dist::Zilla::Plugin::MetaJSON' => '0',
                                      'Dist::Zilla::Plugin::MetaProvides::Package' => '1.14000001',
                                      'Dist::Zilla::Plugin::MetaTests' => '0',
                                      'Dist::Zilla::Plugin::MetaYAML' => '0',
                                      'Dist::Zilla::Plugin::MinimumPerl' => '0',
                                      'Dist::Zilla::Plugin::ModuleBuild' => '0',
                                      'Dist::Zilla::Plugin::PkgVersion' => '0',
                                      'Dist::Zilla::Plugin::PodCoverageTests' => '0',
                                      'Dist::Zilla::Plugin::PodSyntaxTests' => '0',
                                      'Dist::Zilla::Plugin::PodWeaver' => '0',
                                      'Dist::Zilla::Plugin::Prereqs' => '0',
                                      'Dist::Zilla::Plugin::Prereqs::MatchInstalled' => '0',
                                      'Dist::Zilla::Plugin::Prereqs::Recommend::MatchInstalled' => '0',
                                      'Dist::Zilla::Plugin::ReadmeAnyFromPod' => '0',
                                      'Dist::Zilla::Plugin::ReadmeFromPod' => '0',
                                      'Dist::Zilla::Plugin::RunExtraTests' => '0',
                                      'Dist::Zilla::Plugin::Test::CPAN::Changes' => '0',
                                      'Dist::Zilla::Plugin::Test::Compile::PerFile' => '0',
                                      'Dist::Zilla::Plugin::Test::Kwalitee' => '0',
                                      'Dist::Zilla::Plugin::Test::MinimumVersion' => '0',
                                      'Dist::Zilla::Plugin::Test::Perl::Critic' => '0',
                                      'Dist::Zilla::Plugin::Test::ReportPrereqs' => '0',
                                      'Dist::Zilla::Plugin::TestRelease' => '0',
                                      'Dist::Zilla::Plugin::Twitter' => '0',
                                      'Dist::Zilla::Plugin::UploadToCPAN' => '0',
                                      'Pod::Coverage::TrustPod' => '0',
                                      'Test::CPAN::Changes' => '0.19',
                                      'Test::CPAN::Meta' => '0',
                                      'Test::Kwalitee' => '1.12',
                                      'Test::Pod' => '1.41',
                                      'Test::Pod::Coverage' => '1.08'
                                    },
                      'suggests' => {
                                      'Dist::Zilla::App::Command::bakeini' => '0.001001',
                                      'Dist::Zilla::PluginBundle::Author::KENTNL' => '2.016002'
                                    }
                    },
       'runtime' => {
                      'requires' => {
                                      'Carp' => '0',
                                      'Moose::Role' => '0',
                                      'Moose::Util::TypeConstraints' => '0',
                                      'perl' => '5.006',
                                      'strict' => '0',
                                      'version' => '0',
                                      'warnings' => '0'
                                    }
                    },
       'test' => {
                   'recommends' => {
                                     'CPAN::Meta' => '0',
                                     'CPAN::Meta::Requirements' => '2.120900'
                                   },
                   'requires' => {
                                   'Dist::Zilla::Plugin::Bootstrap::lib' => '0.04000000',
                                   'ExtUtils::MakeMaker' => '0',
                                   'File::Copy::Recursive' => '0',
                                   'File::ShareDir' => '0',
                                   'File::Spec::Functions' => '0',
                                   'List::Util' => '0',
                                   'Path::Tiny' => '0',
                                   'Test::DZil' => '0',
                                   'Test::Fatal' => '0',
                                   'Test::More' => '1.001003'
                                 }
                 }
     };
  $x;
 };

delete $static_prereqs->{develop} if not $ENV{AUTHOR_TESTING};
$include{$_} = 1 for map { keys %$_ } map { values %$_ } values %$static_prereqs;

# Merge requirements for major phases (if we can)
my $all_requires;
if ( $DO_VERIFY_PREREQS && $HAS_CPAN_META_REQ ) {
    $all_requires = $cpan_meta_req->new;
    _merge_requires($all_requires, $static_prereqs);
}


# Add dynamic prereqs to the included modules list (if we can)
my ($source) = grep { -f } 'MYMETA.json', 'MYMETA.yml';
if ( $source && $HAS_CPAN_META ) {
  if ( my $meta = eval { CPAN::Meta->load_file($source) } ) {
    my $dynamic_prereqs = $meta->prereqs;
    delete $dynamic_prereqs->{develop} if not $ENV{AUTHOR_TESTING};
    $include{$_} = 1 for map { keys %$_ } map { values %$_ } values %$dynamic_prereqs;

    if ( $DO_VERIFY_PREREQS && $HAS_CPAN_META_REQ ) {
        _merge_requires($all_requires, $dynamic_prereqs);
    }
  }
}
else {
  $source = 'static metadata';
}

my @modules = sort grep { ! $exclude{$_} } keys %include;
my @reports = [qw/Version Module/];
my @dep_errors;
my $req_hash = defined($all_requires) ? $all_requires->as_string_hash : {};

for my $mod ( @modules ) {
  next if $mod eq 'perl';
  my $file = $mod;
  $file =~ s{::}{/}g;
  $file .= ".pm";
  my ($prefix) = grep { -e catfile($_, $file) } @INC;
  if ( $prefix ) {
    my $ver = MM->parse_version( catfile($prefix, $file) );
    $ver = "undef" unless defined $ver; # Newer MM should do this anyway
    push @reports, [$ver, $mod];

    if ( $DO_VERIFY_PREREQS && $all_requires ) {
      my $req = $req_hash->{$mod};
      if ( defined $req && length $req ) {
        if ( ! defined eval { version->parse($ver) } ) {
          push @dep_errors, "$mod version '$ver' cannot be parsed (version '$req' required)";
        }
        elsif ( ! $all_requires->accepts_module( $mod => $ver ) ) {
          push @dep_errors, "$mod version '$ver' is not in required range '$req'";
        }
      }
    }

  }
  else {
    push @reports, ["missing", $mod];

    if ( $DO_VERIFY_PREREQS && $all_requires ) {
      my $req = $req_hash->{$mod};
      if ( defined $req && length $req ) {
        push @dep_errors, "$mod is not installed (version '$req' required)";
      }
    }
  }
}

if ( @reports ) {
  my $vl = max map { length $_->[0] } @reports;
  my $ml = max map { length $_->[1] } @reports;
  splice @reports, 1, 0, ["-" x $vl, "-" x $ml];
  diag "\nVersions for all modules listed in $source (including optional ones):\n",
    map {sprintf("  %*s %*s\n",$vl,$_->[0],-$ml,$_->[1])} @reports;
}

if ( @dep_errors ) {
  diag join("\n",
    "\n*** WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING ***\n",
    "The following REQUIRED prerequisites were not satisfied:\n",
    @dep_errors,
    "\n"
  );
}

pass;

# vim: ts=4 sts=4 sw=4 et:
