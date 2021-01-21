#include "unity"

typedef struct _node {
    void *data;
    struct _node *next;
} Node;

typedef struct _linked_list {
    Node *head;
    Node *tail;
    Node *current;
} LinkedList;

extern void initialize_list(LinkedList);

void setUp(void) {
    // set stuff up here
}

void tearDown(void) {
    // clean stuff up here
}

void test_initialize_list(void) {
    LinkedList *linked_list = (LinkedList*) malloc(sizeof(LinkedList));

    initialize_list(linked_list);

    TEST_ASSERT_NULL(linked_list.head);
    TEST_ASSERT_NULL(linked_list.tail);
    TEST_ASSERT_NULL(linked_list.current);
}


int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_initialize_list);
    return UNITY_END();
}
