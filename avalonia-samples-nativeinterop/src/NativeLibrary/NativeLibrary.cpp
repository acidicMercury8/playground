#include "pch.h"

#include "framework.h"
#include "NativeLibrary.h"

LRESULT CALLBACK WindowProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam) {
    switch (message) {
    case WM_COMMAND:
        break;
    case WM_PAINT:
        {
            PAINTSTRUCT ps;
            HDC hdc = BeginPaint(hWnd, &ps);
            EndPaint(hWnd, &ps);
        }
        break;
    case WM_DESTROY:
        PostQuitMessage(0);
        break;
    default:
        return DefWindowProc(hWnd, message, wParam, lParam);
    }
    return 0;
}

NATIVELIBRARY_API HWND fnNativeLibrary() {
    const wchar_t CLASS_NAME[] = L"WND";

    WNDCLASSEXW wc ={};
    wc.cbSize = sizeof(WNDCLASSEX);
    wc.style = CS_HREDRAW | CS_VREDRAW;
    wc.lpfnWndProc = WindowProc;
    wc.cbClsExtra = 0;
    wc.cbWndExtra = 0;
    wc.hInstance = 0;
    wc.hbrBackground = (HBRUSH) (COLOR_BACKGROUND);
    wc.lpszClassName = CLASS_NAME;

    RegisterClassExW(&wc);

    // Create the window.

    HWND hwnd = CreateWindowW(
        CLASS_NAME, // Window class
        L"123",     // Window text

        // Window style
        WS_POPUP | WS_VISIBLE | WS_SYSMENU,

        // Size and position
        CW_USEDEFAULT, 0, CW_USEDEFAULT, 0,

        nullptr, // Parent window
        nullptr, // Menu
        nullptr, // Instance handle
        nullptr  // Additional application data
    );

    if (hwnd == nullptr) {
        return 0;
    }

    ShowWindow(hwnd, SW_SHOWNORMAL);
    UpdateWindow(hwnd);

    return hwnd;
}
