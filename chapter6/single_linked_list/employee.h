typedef struct _employee {
    char name[32];
    unsigned char age;
} Employee;

extern int compare_employee(Employee*, Employee*);

extern Employee* init_employee(char[], unsigned char);
