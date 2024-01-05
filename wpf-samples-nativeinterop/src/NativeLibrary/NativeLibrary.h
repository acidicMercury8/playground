#ifdef NATIVELIBRARY_EXPORTS
#define NATIVELIBRARY_API __declspec(dllexport)
#else
#define NATIVELIBRARY_API __declspec(dllimport)
#endif

extern "C" {
    NATIVELIBRARY_API HWND fnNativeLibrary(HWND parent);
}
