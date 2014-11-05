struct siginfo {
    /* ... */
};

typedef int sigset_t;

/* START:callbacks */
typedef void (*handler_func)(int);
typedef void (*action_func)(int, struct siginfo*, void*);
/* END:callbacks */

/* START:data */
union sigaction_u {
    handler_func sa_handler;
    action_func  sa_action;
};

struct sigaction {
    union sigaction_u sa_action_u;
    sigset_t          sa_mask;
    int               sa_flags;
};
/* END:data */

/* START:functions */
unsigned int alarm(unsigned int);
int sigaction(int, struct siginfo*, struct siginfo*);
/* END:functions */

int main() {
    return 0;
}
