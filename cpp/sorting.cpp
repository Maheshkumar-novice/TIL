#include <bits/stdc++.h>

using namespace std;

bool comp(string a, string b)
{
    if (a.size() != b.size())
    {
        return a.size() < b.size();
    }
    return a < b;
}

int main()
{
    vector<int> v = {4, 24, 3};
    sort(v.begin(), v.end());
    cout << *(v.begin() + 1) << "\n";
    cout << *(v.end() - 1) << "\n";
    cout << *v.rbegin() << "\n";
    cout << *(v.rend() - 1) << "\n";

    for (int i : v)
    {
        cout << i << "\n";
    }

    sort(v.rbegin(), v.rend());

    for (int i : v)
    {
        cout << i << "\n";
    }

    int n = 3;
    int a[] = {1, 4, -1};
    sort(a, a + n);
    cout << a << "\n";
    cout << a + n << "\n";
    cout << *(a + 2) << "\n";
    cout << sizeof(a) << " " << sizeof(a[0]) << " " << "\n";
    for (int i = 0; i < n; i++)
    {
        cout << a[i] << "\n";
    }

    string s = "moneky";
    cout << s << "\n";
    sort(s.begin(), s.end());
    cout << *(s.rbegin() + 1) << "\n";
    cout << s << "\n";

    vector<pair<int, int>> v1;
    v1.push_back({1, 5});
    v1.push_back({2, 3});
    v1.push_back({1, 2});
    for (const pair<int, int> &i : v1)
    {
        cout << i.first << " " << i.second << "\n";
    }

    sort(v1.begin(), v1.end());

    for (const pair<int, int> &i : v1)
    {
        cout << i.first << " " << i.second << "\n";
    }

    map<int, string> myMap;
    myMap.insert(make_pair(1, "One"));
    myMap.insert({2, "Two"});

    for (const auto &p : myMap)
    {
        cout << p.first << ": " << p.second << endl;
    }

    vector<tuple<int, int, int>> v2;
    v2.push_back({2, 1, 4});
    v2.push_back({1, 5, 3});
    v2.push_back({2, 1, 3});
    int j, k, l;
    for (const tuple<int, int, int> &i : v2)
    {
        tie(j, k, l) = i;
        cout << j << " " << k << " " << l << "\n";
    }
    sort(v2.begin(), v2.end());
    for (const tuple<int, int, int> &i : v2)
    {
        tie(j, k, l) = i;
        cout << j << " " << k << " " << l << "\n";
    }

    struct P
    {
        int x, y;
        P(int x, int y) : x(x), y(y) {}
        bool operator<(const P &p)
        {
            if (x != p.x)
                return x < p.x;
            else
                return y < p.y;
        }
    };
    vector<P> ps = {{4, 5}, {2, 3}};
    ps.emplace_back(1, 2);
    ps.push_back(P(2, 3));

    for (const P &i : ps)
    {
        cout << i.x << " " << i.y << endl;
    }

    sort(ps.begin(), ps.end());

    for (const P &i : ps)
    {
        cout << i.x << " " << i.y << endl;
    }

    vector<string> s2 = {"15", "2", "34"};

    for (const auto &i : s2)
    {
        cout << i << endl;
    }

    sort(s2.begin(), s2.end(), comp);

    for (const auto &i : s2)
    {
        cout << i << endl;
    }
}
