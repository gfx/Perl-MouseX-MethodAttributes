use strict;
use warnings;
{
    package Catalyst::Controller;
    use Mouse;
    use namespace::clean -except => 'meta';
    use MouseX::MethodAttributes;
    BEGIN { extends 'MouseX::MethodAttributes::Inheritable'; }
}
{
    package TestApp::Controller::Mouse;
    use Mouse;
    use namespace::clean -except => 'meta';
    BEGIN { extends qw/Catalyst::Controller/; }

    our $GET_ATTRIBUTE_CALLED = 0;
    sub get_attribute : Local { $GET_ATTRIBUTE_CALLED++ }

    our $GET_FOO_CALLED = 0;
    our $BEFORE_GET_FOO_CALLED = 0;
    sub get_foo : Local { $GET_FOO_CALLED++ }
    # Exactly the same as last test except for modifier here
    before 'get_foo' => sub { $BEFORE_GET_FOO_CALLED++ };

    sub other : Local {}
}
{
    package TestApp::Controller::Mouse::MethodModifiers;
    use Mouse;
    use namespace::clean -except => 'meta';
    BEGIN { extends qw/TestApp::Controller::Mouse/; }

    our $GET_ATTRIBUTE_CALLED = 0;
    after get_attribute => sub { $GET_ATTRIBUTE_CALLED++; }; # Wrapped only, should show up

    sub other : Local {}
    after other => sub {}; # Wrapped, wrapped should show up.
}

use Test::More tests => 13;
use Test::Exception;

my @methods;
lives_ok {
    @methods = TestApp::Controller::Mouse::MethodModifiers->meta->get_nearest_methods_with_attributes;
} 'Can get nearest methods';

is @methods, 3;

my $method = (grep { $_->name eq 'get_attribute' } @methods)[0];
ok $method;
is $method->body, \&TestApp::Controller::Mouse::MethodModifiers::get_attribute;
is $TestApp::Controller::Mouse::GET_ATTRIBUTE_CALLED, 0;
is $TestApp::Controller::Mouse::MethodModifiers::GET_ATTRIBUTE_CALLED, 0;
is $TestApp::Controller::Mouse::GET_FOO_CALLED, 0;
is $TestApp::Controller::Mouse::BEFORE_GET_FOO_CALLED, 0;
$method->body->();
(grep { $_->name eq 'get_foo' } @methods)[0]->body->();
is $TestApp::Controller::Mouse::GET_ATTRIBUTE_CALLED, 1;
is $TestApp::Controller::Mouse::MethodModifiers::GET_ATTRIBUTE_CALLED, 1;
is $TestApp::Controller::Mouse::GET_FOO_CALLED, 1;
is $TestApp::Controller::Mouse::BEFORE_GET_FOO_CALLED, 1;

my $other = (grep { $_->name eq 'other' } @methods)[0];
ok $other;

