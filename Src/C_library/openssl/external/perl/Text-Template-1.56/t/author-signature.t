#!perl -w

BEGIN {
  unless ($ENV{AUTHOR_TESTING}) {
    print qq{1..0 # SKIP these tests are for testing by the author\n};
    exit
  }
}

# This file was automatically generated by Dist::Zilla::Plugin::AuthorSignatureTest

use strict;
use warnings;
use Test::More;

unless (eval { require Test::Signature; 1 }) {
    plan skip_all => 'Test::Signature is required for this test';
}

Test::Signature::signature_ok();
done_testing;
