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
    'LIBS'          => [''],            # e.g., '-lm'
    'DEFINE'        => '',              # e.g., '-DHAVE_SOMETHING'
    'INC'           => '',      # e.g., '-I/usr/include/other'
     #'OBJECT'       => '$(O_FILES)',        # link all the C files too
    'MYEXTLIB'      => 'ModList/ModList$(LIB_EXT)',
);

sub MY::postamble {
'
$(MYEXTLIB): ModList/Makefile
    cd ModList && $(MAKE) $(PASSTHRU)
';
}
