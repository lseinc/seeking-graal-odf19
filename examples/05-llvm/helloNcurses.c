#include <unistd.h>
#include <ncurses.h>

int main(int argc, const char* argv[] ) {
    return displayMessage(10, 33, "Hello, OHDevFest from LLVM !!!", 3);
}


int displayMessage(int line, int column, const char* message, int delay) {
    int firstDelay = 1;
    int secondDelay = delay - 1;
    if (secondDelay < 1) {
	    secondDelay=1;
    }
    initscr();
    start_color();
    init_pair(1, COLOR_MAGENTA, COLOR_BLACK);
    init_pair(2, COLOR_CYAN, COLOR_BLACK);
    attron(COLOR_PAIR(1));
    mvaddstr(line, column, message);
    refresh();
    sleep(firstDelay);
    attroff(COLOR_PAIR(1));
    attron(COLOR_PAIR(2));
    mvaddstr(line, column, message);
    refresh();
    sleep(secondDelay);
    attroff(COLOR_PAIR(2));
    refresh();
    endwin();
    return 0;
}

