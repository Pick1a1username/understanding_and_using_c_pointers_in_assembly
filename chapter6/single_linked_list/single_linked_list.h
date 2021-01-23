typedef struct _node {
    void *data;
    struct _node *next;
} Node;

typedef struct _linked_list {
    Node *head;
    Node *tail;
    Node *current;
} LinkedList;

typedef int (*COMPARE)(void*, void*);

extern void initialize_list(LinkedList*);

extern void add_head(LinkedList*, void*);

extern void add_tail(LinkedList*, void*);

extern Node *get_node(LinkedList*, COMPARE compare, void*);

extern void delete(LinkedList*, Node*);
