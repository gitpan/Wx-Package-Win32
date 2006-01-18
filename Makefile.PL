use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Wx::Package::Win32',
    AUTHOR              => 'Mark Dootson <mdootson@cpan.org>',
    VERSION_FROM        => 'lib/Wx/Package/Win32.pm',
    PL_FILES            => {},
    PREREQ_PM           => { Wx => 0.27,},
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Wx-Package-Win32-*' },

);

