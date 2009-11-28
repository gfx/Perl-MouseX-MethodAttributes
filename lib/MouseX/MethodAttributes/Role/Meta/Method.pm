package MouseX::MethodAttributes::Role::Meta::Method;

use Mouse::Role;
use namespace::clean -except => 'meta';

has attributes => (
    is  => 'ro',
    isa => 'ArrayRef',

    lazy_build => 1,
);

sub _build_attributes {
    my($self) = @_;

    return $self->associated_metaclass->get_method_attributes($self->name);
}

1;
__END__

=head1 NAME

MouseX::MethodAttributes::Role::Meta::Method - A meta method role for method attributes

=head1 VERSION

This document describes MouseX::MethodAttributes version 0.001.

=head1 SYNOPSIS

    # Don't use this module directly!

=head1 INTERFACE

=head2 ATTRIBUTES

=head3 attributes

Method attributes.

=head1 SEE ALSO

L<MouseX::MethodAttributes>

=cut
