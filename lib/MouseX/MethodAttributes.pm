package MouseX::MethodAttributes;

use 5.008_001;
use Mouse ();
use Mouse::Exporter;
use Mouse::Util qw(find_meta does_role);

our $VERSION = '0.001';

use XSLoader;
XSLoader::load(__PACKAGE__, $VERSION);

use attributes (); # need to preload
use MouseX::MethodAttributes::Role::AttrContainer;

Mouse::Exporter->setup_import_methods();

sub init_meta {
    my(undef, %options) = @_;

    my $for_class = $options{for_class};

    my $meta = Mouse::Util::class_of($for_class);

    return $meta if $meta
            && does_role($meta, 'MouseX::MethodAttributes::Role::Meta::Class')
            && does_role($meta->method_metaclass, 'MouseX::MethodAttributes::Role::Meta::Method')
    ;

    $meta ||= Mouse::Meta::Class->initialize($for_class);

    require Mouse::Util::MetaRole;

    $meta = Mouse::Util::MetaRole::apply_metaclass_roles(
        for_class                      => $for_class,
        metaclass_roles                => ['MouseX::MethodAttributes::Role::Meta::Class'],
        method_metaclass_roles         => ['MouseX::MethodAttributes::Role::Meta::Method'],
    );

    Mouse::Util::MetaRole::apply_base_class_roles(
        for_class => $for_class,
        roles     => ['MouseX::MethodAttributes::Role::AttrContainer'],
    );

    return $meta;
}

1;
__END__

=head1 NAME

MouseX::MethodAttributes - Method attribute introspection

=head1 VERSION

This document describes MouseX::MethodAttributes version 0.001.

=head1 SYNOPSIS

    use Mouse;
	use MouseX::MethodAttributes;

=head1 DESCRIPTION

MouseX::MethodAttributes provides blah blah blah.

=head1 INTERFACE

=head2 METHODS

=head3 init_meta

=head1 DEPENDENCIES

Perl 5.8.1 or later, and a C compiler.

=head1 BUGS

No bugs have been reported.

Please report any bugs or feature requests to the author.

=head1 SEE ALSO

L<Mouse>

L<MooseX::MethodAttributes>

L<Moose>

L<attributes>

=head1 AUTHOR

Goro Fuji (gfx) E<lt>gfuji(at)cpan.orgE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2009, Goro Fuji (gfx). Some rights reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
