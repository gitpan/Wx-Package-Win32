package Wx::Package::Win32::ProcMods;

use 5.008;
use warnings;
use strict;
use Carp;

require Exporter;
require DynaLoader;

our @ISA = qw(Exporter DynaLoader);

our @EXPORT = qw();
our $VERSION = '0.03';

bootstrap Wx::Package::Win32::ProcMods $VERSION;


=head1 NAME

Wx::Package::Win32::ProcMods

=head1 VERSION

Version 0.03

=cut

=head1 SYNOPSIS

    see Wx::Package::Win32

=cut

=head1 DESCRIPTION

    A module to assist packaging Wx based applications with PAR, ActiveState PerlApp / PDK and Perl2Exe.
    All that is needed is that you include a 'use' statement as the first item in your BEGIN blocks.
    

=cut



=head1 AUTHOR

Mark Dootson, C<< <mdootson at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-wx-package-win32 at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Wx-Package-Win32>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 DOCUMENTATION

You can find documentation for this module with the perldoc command.

    perldoc Wx::Package::Win32

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Wx-Package-Win32>

=item * Search CPAN

L<http://search.cpan.org/dist/Wx-Package-Win32>

=back

=head1 ACKNOWLEDGEMENTS

Mattia Barbon for wxPerl.

Ferdinand Prantl <prantl@host.sk> for Win32::ToolHelp module from which loaded module
enumeration method was learned.

=head1 COPYRIGHT & LICENSE

Copyright 2006 Mark Dootson, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of Wx::Package::Win32::ProcMods

__END__

