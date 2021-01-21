#include "unity.h"
#include "single_linked_list.h"
#include <stdlib.h>

typedef _test_data {
    int num;
} TestData

void setUp(void) {
    // set stuff up here
}

void tearDown(void) {
    // clean stuff up here
}

void test_initialize_list(void) {
    LinkedList *linked_list = (LinkedList*) malloc(sizeof(LinkedList));

    initialize_list(linked_list);

    TEST_ASSERT_NULL(linked_list->head);
    TEST_ASSERT_NULL(linked_list->tail);
    TEST_ASSERT_NULL(linked_list->current);
}


int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_initialize_list);
    return UNITY_END();
}
