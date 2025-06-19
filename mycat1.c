#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc != 2) return 1;
    
    int fd = open(argv[1], O_RDONLY);
    if (fd == -1) return 1;
    
    char c;
    while (read(fd, &c, 1) > 0) {
        write(STDOUT_FILENO, &c, 1);
    }
    
    close(fd);
    return 0;
}