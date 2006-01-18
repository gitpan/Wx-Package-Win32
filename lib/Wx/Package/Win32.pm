package Wx::Package::Win32;

use 5.008;
use strict;
use Wx 0.27;
use Wx::Package::Win32::ProcMods;

require Exporter;

our @ISA = qw(Exporter);

use vars qw($VERSION $WINDLLS @LOADEDWINDLLS $DLLPATTERN $PDKCOMPILE);

$VERSION = 0.04;

our @EXPORT = qw();



$WINDLLS = {};
        
@LOADEDWINDLLS = ();


=head1 NAME

Wx::Package::Win32

=head1 VERSION

Version 0.04

=cut

=head1 SYNOPSIS

    For PerlApp and PAR

    BEGIN { use Wx::Package::Win32; }

    
    For Perl2Exe
    
    BEGIN { use Wx::Package::Win32; }
    use Wx::Package::Win32;

    ...

=cut

=head1 DESCRIPTION

    A module to assist packaging Wx based applications with PAR, 
    ActiveState PerlApp / PDK and Perl2Exe. All that is needed is 
    that you include a 'use' statement as the first item in your 
    BEGIN blocks. For Perl2Exe, an additional 'use' statement 
    outside any BEGIN block ensures correct object cleanup. 
    

=cut

if($PerlApp::VERSION) {
    my $execname = PerlApp::exe();
    if($execname =~ /.*pdkcheck\.exe$/) { 
        $PDKCOMPILE = 1;
        foreach ( @INC ) {
            if( -f "$_/auto/Wx/Wx.dll" ) {
                my $pdkcompilepath = "$_/auto/Wx";
                $pdkcompilepath =~ s/\//\\/g ;
                $ENV{PATH} = $pdkcompilepath . ';' . $ENV{PATH};
            }
        }
    }
}    
                     
Wx::set_load_function( sub { my $dllkey = shift;
                return if $PDKCOMPILE;
                # don't load twice
                return if(exists( $WINDLLS->{$dllkey}));
                my $dllfile = Wx::Package::Win32::__get_module_path($dllkey);              
                Wx::_load_file( $dllfile );
                $WINDLLS->{$dllkey} = $dllfile;
                
                push(@LOADEDWINDLLS, $dllfile);
                1; } );
        
Wx::set_end_function( sub { 
                while( my $module = pop @LOADEDWINDLLS) {
                    Wx::_unload_plugin( $module );
                }
                            
                1; } );

sub __get_module_path {
    my $dllkey = shift;
    
    # get dll naming pattern if first call
    if(!defined($DLLPATTERN)) {
        my @modules = Wx::Package::Win32::ProcMods::GetProcessModules(0); # get modules for current process
        foreach my $module (@modules) {
            my $mname = $module->[7];
            
            if($mname =~ /^wxmsw(\d{2}\w*)_core_(gcc||vc)_(\w+)\.dll$/) {
                $DLLPATTERN = 'wxDLLPATTERNNAMEPREFIX' . $1 . '_DLLNAMESPECIFIEDKEY_' . $2 . '_' . $3 . '.dll';
                my $fullpath = $module->[8];
                $fullpath =~ s/\\/\//g;
                $fullpath =~ s/[^\/]+$//;
                $DLLPATTERN = $fullpath . $DLLPATTERN;
                last;
            }
        }
    }
    
    # name the dll
    my $prefix; 
    if( $dllkey =~ /^(net||xml)$/) {
        $prefix = 'base';
    } else {
        $prefix = 'msw';
    }
    my $dllfile = $DLLPATTERN;
    $dllfile =~ s/DLLPATTERNNAMEPREFIX/$prefix/;
    $dllfile =~ s/DLLNAMESPECIFIEDKEY/$dllkey/;
    return $dllfile;
}

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

1; # End of Wx::Package::Win32

__END__

