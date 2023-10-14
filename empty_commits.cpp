#include <cstdlib>
#include <string>

int main() {
    for(int i = 0; i < 1000000; ++i) {
        std::string command = "git commit --allow-empty -m 'commit number " + std::to_string(i) + "'";
        system(command.c_str());
    }
    return 0;
}
