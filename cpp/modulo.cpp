#include <bits/stdc++.h>

using namespace std;

int main()
{
    /*
        CPP style directly computes the modulo
        Whereas Python makes the value to be in the range 0,..m-1
        As far as I read, it is common in Number Theory.
        CPP style is old it seems but it is easy to convert to other type.
        It only affects the negative modulo, positive works fine.
    */

    int a, m;

    a = 7;
    m = 3;
    cout << "CPP style " << a % m << "\n";
    cout << "Python style " << ((a % m) + m) % m << "\n";

    a = 7;
    m = -3;
    cout << "CPP style " << a % m << "\n";
    cout << "Python style " << ((a % m) + m) % m << "\n";

    a = -7;
    m = 3;
    cout << "CPP style " << a % m << "\n";
    cout << "Python style " << ((a % m) + m) % m << "\n";
}
