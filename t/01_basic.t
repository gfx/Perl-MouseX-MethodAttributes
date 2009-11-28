#!perl -w

use strict;
use Test::More;

{
    package Class;
    use Mouse;
    BEGIN{ extends qw(MouseX::MethodAttributes::Inheritable) }

    sub foo :BAR BAZ(42) {}

    sub method_without_attributes {}
}

my $m = Class->meta->get_method('foo');

ok $m;
can_ok $m, 'attributes';
is_deeply($m->attributes, [qw(BAR BAZ(42))]);

my @methods = Class->meta->get_method_with_attributes_list();
is scalar(@methods), 1;
is $methods[0]->fully_qualified_name, 'Class::foo';

@methods = Class->meta->get_all_methods_with_attributes();
is scalar(@methods), 1;
is $methods[0]->fully_qualified_name, 'Class::foo';


@methods = Class->meta->get_nearest_methods_with_attributes();
is scalar(@methods), 1;
is $methods[0]->fully_qualified_name, 'Class::foo';

done_testing;
