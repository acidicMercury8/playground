#include <locale.h>
#include <conio.h>
#include <stdio.h>

int main(void) {
    setlocale(LC_ALL, "Rus");

    printf("Привет, мир!");

    printf("\nДля продолжения нажмите любую клавишу . . . ");
    char result = _getch();
    return 0;
}
