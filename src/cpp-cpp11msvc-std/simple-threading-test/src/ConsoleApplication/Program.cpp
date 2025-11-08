#include <iostream>
#include <thread>
#include <utility>

int main()
{
    auto i = 42;
    auto thread = std::thread(
        [](int arg1)
        {
            std::cout << arg1 << std::endl;
        },
        std::ref(i)
    );
    i = 13;
    thread.join();
}
