#define WIN32_PACKAGE_MODLIST_VER 0.71

#define MAX_PATH 260
#define MAX_MODULE_NAME32 255

typedef unsigned long ULONG_PTR;

typedef struct tagMODULEENTRY32
{
    DWORD dwSize;
    DWORD th32ModuleID;
    DWORD th32ProcessID;
    DWORD GlblcntUsage;
    DWORD ProccntUsage;
    BYTE* modBaseAddr;
    DWORD modBaseSize;
    HMODULE hModule;
    CHAR szModule[MAX_MODULE_NAME32 + 1];
    CHAR szExePath[MAX_PATH];
} MODULEENTRY32;

HANDLE GetFirstModule(DWORD pid, MODULEENTRY32* me32);
HANDLE GetNextModule(HANDLE h, MODULEENTRY32* me32);
