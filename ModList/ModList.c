#include <windows.h>
#include <tlhelp32.h>

HANDLE GetFirstModule(DWORD pid, MODULEENTRY32* me32)
{
	HANDLE h;

	if (me32 == 0)
		return INVALID_HANDLE_VALUE;

	ZeroMemory(me32, sizeof(*me32));
	me32->dwSize = sizeof(*me32);

	h = CreateToolhelp32Snapshot(TH32CS_SNAPMODULE, pid);
	if (h == INVALID_HANDLE_VALUE)
		return INVALID_HANDLE_VALUE;

	if (!Module32First(h, me32))
	{
		CloseHandle(h);
		return INVALID_HANDLE_VALUE;
	}

	return h;
}


HANDLE GetNextModule(HANDLE h, MODULEENTRY32* me32)
{
	if (h == INVALID_HANDLE_VALUE)
		return INVALID_HANDLE_VALUE;
	if (me32 == 0)
		return INVALID_HANDLE_VALUE;

	ZeroMemory(me32, sizeof(*me32));
	me32->dwSize = sizeof(*me32);

	if (!Module32Next(h, me32))
	{
		CloseHandle(h);
		return INVALID_HANDLE_VALUE;
	}

	return h;
}
