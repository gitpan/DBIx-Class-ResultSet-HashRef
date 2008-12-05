package DBIx::Class::ResultSet::HashRef;

use warnings;
use strict;
use base qw( DBIx::Class::ResultSet );
use DBIx::Class::ResultClass::HashRefInflator;

our $VERSION = '1.001';

=head1 NAME

DBIx::Class::ResultSet::HashRef - Adds syntactic sugar to skip the fancy objects

=head1 SYNOPSIS

    # in your resultsource class
    __PACKAGE__->resultset_class( 'DBIx::Class::ResultSet::HashRef' );
    
    # in your calling code
    my $rs = $schema->resultset('User')->search( { } )->hashref_rs;
    while (my $row = $rs->next) {
        print Dumper $row;
    }
    
    You can chain up every L<DBIx::Class::ResultSet> method to ->hashref_rs:
    
    * ->hashref_rs->all (same as ->hashref_array)

    * ->hashref_rs->first (same as ->hashref_first)
    
=head1 DESCRIPTION

This is a simple way to allow you to set result_class to L<DBIx::Class::ResultClass::HashRefInflator> to
skip the fancy objects.

=head1 INSTALLATION

    perl Makefile.PL
    make
    make test
    make install

=head1 METHODS

=head2 hashref_rs( )

Sets result_class to L<DBIx::Class::ResultClass::HashRefInflator> and returns the resultset.

=cut

sub hashref_rs {
    my ($self) = @_;
    $self->result_class('DBIx::Class::ResultClass::HashRefInflator');
    return $self;
}

=head2 hashref_array( )

Calls ->hashref_rs->all and returns depending on the calling context an array or an reference to an array. 

    my $rs = $schema->resultset('User')->search( { } )->hashref_array;
    print Dumper $rs;

    my @rs = $schema->resultset('User')->search( { } )->hashref_array;
    print Dumper @rs;

=cut

sub hashref_array {
    return wantarray ? shift->hashref_rs->all : [ shift->hashref_rs->all ];
}

=head2 hashref_first( )

Returns the first row of the resultset inflated by L<DBIx::Class::ResultClass::HashRefInflator>.

    my $first_row = $schema->resultset('User')->search( { } )->hashref_first;
    print Dumper $first_row

=cut

sub hashref_first {
    return shift->hashref_rs->first;
}

=head1 AUTHOR

Johannes Plunien E<lt>plu@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2008 by Johannes Plunien

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

Thanks to mst for his patience.

=head1 SEE ALSO

=over 4 

=item * L<DBIx::Class>

=item * L<DBIx::Class::ResultClass::HashRefInflator>

=back

=cut

1;
