#include <bits/stdc++.h>

using namespace std;
using namespace std::chrono;

int main() {
    // Here you don't see "hi" immediately.
    ios::sync_with_stdio(0);
    // cin.tie(0);
    cout << "hi" << "\n";
    this_thread::sleep_for(chrono::seconds(2));
    cout << "hello" << "\n";
}
