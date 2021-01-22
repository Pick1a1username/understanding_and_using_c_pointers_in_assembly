typedef struct _node {
    void *data;
    struct _node *next;
} Node;

typedef struct _linked_list {
    Node *head;
    Node *tail;
    Node *current;
} LinkedList;

extern void initialize_list(LinkedList*);

extern void add_head(LinkedList*, void*);
