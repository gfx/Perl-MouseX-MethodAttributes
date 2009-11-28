use strict;
use warnings;

package BaseClass::Meta::Role;
our $VERSION = '0.18';

use Mouse::Role;

package BaseClass;
our $VERSION = '0.18';


use Mouse;
use Mouse::Util::MetaRole;
BEGIN {
    Mouse::Util::MetaRole::apply_metaclass_roles(
        for_class => __PACKAGE__,
        metaclass_roles => [qw/ BaseClass::Meta::Role /],
    );

    extends qw/MouseX::MethodAttributes::Inheritable/;
}

sub moo : Moo {}

{
    my $affe_was_run = 0;

    sub affe : Birne { $affe_was_run++; }

    sub no_calls_to_affe { $affe_was_run }

}

sub foo : Foo {}

sub bar : Baz {}

{
    no warnings 'redefine';
    sub moo : Moo {}
}

1;
