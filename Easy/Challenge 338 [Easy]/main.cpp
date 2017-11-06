#include <iostream>

using namespace std;

int main() {
    cout << "Hello, World!" << endl;

    int year;
    int month;
    int day;

    cout << "Enter Date: "  << endl;
    cin >> year >> month >> day;

    cout << year << endl << month;
    cout << endl << day << endl;

    // leap-year
    if((year % 4) == 0 && (year % 100) == 0 && (year % 400) == 0) {
        // leap year
        cout << "1 Leap year" << endl;

    } else if((year % 4) == 0 && (year % 100) == 0) {
        // non-leap year
        cout << "2 Non-leap year" << endl;

    } else if ((year % 4) == 0) {
        // leap year
        cout << "3 Leap year" << endl;
    } else {
        // non-leap year
        cout << "4 Non-Leap Year" << endl;
    }


    return 0;
}