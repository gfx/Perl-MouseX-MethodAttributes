package MouseX::MethodAttributes::Role::AttrContainer;

use Mouse::Role;
use MouseX::MethodAttributes ();

use namespace::clean -except => [qw(meta MODIFY_CODE_ATTRIBUTES)];

sub MODIFY_CODE_ATTRIBUTES; # in XS

1;
__END__

=head1 NAME

MouseX::MethodAttributes::Role::AttrContainer - The method attribute container role

=head1 VERSION

This document describes MouseX::MethodAttributes version 0.001.

=head1 SYNOPSIS

	use Mouse;

	BEGIN{ extends qw(MouseX::MethodAttributes::Inheritable) }

=head1 DESCRIPTION

MouseX::MethodAttributes::Inheritable provides C<MODIFY_CODE_ATTRIBUTES> method.

=head1 INTERFACE

=head2 METHODS

=head3 C<MODIFY_CODE_ATTRIBUTES>

=head1 SEE ALSO

L<MouseX::MethodAttributes>

L<attributes>

=cut
