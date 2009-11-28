package MouseX::MethodAttributes::Inheritable;

use 5.008_001;
use Mouse -traits => qw(MouseX::MethodAttributes::Role::Meta::Class);

use namespace::clean -except => 'meta';

use MouseX::MethodAttributes::Role::AttrContainer; # required

with qw(MouseX::MethodAttributes::Role::AttrContainer);

__PACKAGE__->meta->make_immutable();
1;
__END__

=head1 NAME

MouseX::MethodAttributes::Inheritable - Inheritable method attribute introspection

=head1 VERSION

This document describes MouseX::MethodAttributes version 0.001.

=head1 SYNOPSIS

	use Mouse;

	BEGIN{ extends qw(MouseX::MethodAttributes::Inheritable) }

=head1 DESCRIPTION

MouseX::MethodAttributes::Inheritable provides blah blah blah.

=head1 SEE ALSO

L<MouseX::MethodAttributes>

=cut
