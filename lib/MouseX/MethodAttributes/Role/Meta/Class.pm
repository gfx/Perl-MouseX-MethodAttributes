package MouseX::MethodAttributes::Role::Meta::Class;

use Mouse::Role;
use MouseX::MethodAttributes ();

use namespace::clean -except => 'mata';

has _method_attribute_map => (
    is  => 'ro',
    isa => 'HashRef[ArrayRef]',

    lazy    => 1,
    default => sub { {} }
);

sub get_method_attributes {
    my($self, $method) = @_;

    return $self->_method_attribute_map->{$method} || [];
}

sub register_method_attributes {
    my($self, $method, @attrs) = @_;

    $self->_method_attribute_map->{$method} = \@attrs;
    return;
}

sub get_method_with_attributes_list {
    my ($self) = @_;

    return map { $self->get_method($_) }
           keys %{ $self->_method_attribute_map };
}

sub get_all_methods_with_attributes {
    my ($self) = @_;
    my %methods;

    foreach my $class($self->linearized_isa){
        my $meta = Mouse::Util::get_metaclass_by_name($class);

        next if !( $meta && $meta->can('get_method_with_attributes_list') );

        foreach my $method( $meta->get_method_with_attributes_list ){
            $methods{$method->name} ||= $method;
        }
    }

    return values %methods;
}

sub get_nearest_methods_with_attributes {
    my ($self) = @_;
    return map{ $self->find_method_by_name($_->name) }
        grep { scalar @{ $_->attributes } }
        $self->get_all_methods_with_attributes;
}

1;
__END__

=head1 NAME

MouseX::MethodAttributes::Role::Meta::Class - A meta class role for method attributes

=head1 VERSION

This document describes MouseX::MethodAttributes version 0.001.

=head1 SYNOPSIS

    # Don't use this module directly!

=head1 INTERFACE

=head2 METHODS

=head3 get_method_attributes

=head3 register_method_attributes

=head3 get_method_with_attributes_list

=head3 get_all_methods_with_attributes

=head3 get_nearest_methods_with_attributes

=head1 SEE ALSO

L<MouseX::MethodAttributes>

=cut
