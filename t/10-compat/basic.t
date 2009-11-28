use strict;
use warnings;
use Test::More tests => 2;

use FindBin;
use lib "$FindBin::Bin/lib";

use TestClass;

is_deeply(
    TestClass->meta->get_method('foo')->attributes,
    [q{SomeAttribute}, q{AnotherAttribute('with argument')}],
);

is_deeply(
    SubClass->meta->get_method('foo')->attributes,
    [(q{Attributes}) x 3],
);
