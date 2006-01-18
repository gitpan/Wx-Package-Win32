use ExtUtils::MakeMaker;

$Verbose = 1;

WriteMakefile(
    NAME    => 'Wx::Package::Win32::ModList',
    SKIP    => [qw(all static static_lib dynamic dynamic_lib)],
    clean   => {'FILES' => 'ModList$(LIBEEXT)'},
);

sub MY::top_targets {
'
all :: static
pure_all :: static
static :: ModList$(LIB_EXT)
ModList$(LIB_EXT): $(O_FILES)
    $(AR) /out:ModList$(LIB_EXT) $(O_FILES)
';
}
