#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ModList/ModList.h"

#undef XS_VERSION
#define XS_VERSION "0.07"

MODULE=Wx::Package::Win32::ProcMods    PACKAGE=Wx::Package::Win32::ProcMods	

void
GetProcessModules(pid)
		unsigned long pid
	INIT:
		AV* a;
		SV* s;
		HANDLE h;
		MODULEENTRY32 m;
	PPCODE:
		for (h = GetFirstModule(pid, &m);
			 h != INVALID_HANDLE_VALUE;
			 h = GetNextModule(h, &m))
		{
			a = (AV*) sv_2mortal((SV*) newAV());
			av_push(a, newSViv(m.th32ModuleID));
			av_push(a, newSViv(m.th32ProcessID));
			av_push(a, newSViv(m.GlblcntUsage));
			av_push(a, newSViv(m.ProccntUsage));
			av_push(a, newSViv((IV) m.modBaseAddr));
			av_push(a, newSViv(m.modBaseSize));
			av_push(a, newSViv((IV) m.hModule));
			av_push(a, newSVpv(m.szModule, strlen(m.szModule)));
			av_push(a, newSVpv(m.szExePath, strlen(m.szExePath)));
			XPUSHs(sv_2mortal(newRV((SV*) a)));
		}
