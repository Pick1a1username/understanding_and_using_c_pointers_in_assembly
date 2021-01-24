#include <stdlib.h>
#include <unity/unity.h>
#include "single_linked_list.h"
#include "employee.h"

typedef struct _test_data {
    int num;
} TestData;

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

    free(linked_list);
}

void test_add_head_no_head(void) {
    TestData *data = (TestData*) malloc(sizeof(TestData));
    LinkedList *linked_list = (LinkedList*) malloc(sizeof(LinkedList));

    initialize_list(linked_list);
    add_head(linked_list, data);

    TEST_ASSERT_EQUAL_PTR(data, linked_list->head->data);
    TEST_ASSERT_EQUAL_PTR(NULL, linked_list->head->next);
    TEST_ASSERT_EQUAL_PTR(data, linked_list->tail->data);

    free(data);
    free(linked_list);
}

void test_add_head_yes_head(void) {
    TestData *data_one = (TestData*) malloc(sizeof(TestData));
    TestData *data_two = (TestData*) malloc(sizeof(TestData));
    TestData *data_three = (TestData*) malloc(sizeof(TestData));
    LinkedList *linked_list = (LinkedList*) malloc(sizeof(LinkedList));

    initialize_list(linked_list);
    add_head(linked_list, data_one);
    add_head(linked_list, data_two);
    add_head(linked_list, data_three);

    TEST_ASSERT_EQUAL_PTR(data_three, linked_list->head->data);
    TEST_ASSERT_EQUAL_PTR(data_two, linked_list->head->next->data);
    TEST_ASSERT_EQUAL_PTR(data_one, linked_list->tail->data);

    free(data_one);
    free(data_two);
    free(data_three);
    free(linked_list);
}

void test_add_tail_no_head(void) {
    TestData *data = (TestData*) malloc(sizeof(TestData));
    LinkedList *linked_list = (LinkedList*) malloc(sizeof(LinkedList));

    initialize_list(linked_list);
    add_tail(linked_list, data);

    TEST_ASSERT_EQUAL_PTR(data, linked_list->head->data);
    TEST_ASSERT_EQUAL_PTR(NULL, linked_list->head->next);
    TEST_ASSERT_EQUAL_PTR(data, linked_list->tail->data);

    free(data);
    free(linked_list);
}

void test_add_tail_yes_head(void) {
    TestData *data_one = (TestData*) malloc(sizeof(TestData));
    TestData *data_two = (TestData*) malloc(sizeof(TestData));
    LinkedList *linked_list = (LinkedList*) malloc(sizeof(LinkedList));

    initialize_list(linked_list);
    add_head(linked_list, data_one);
    add_tail(linked_list, data_two);

    TEST_ASSERT_EQUAL_PTR(data_one, linked_list->head->data);
    TEST_ASSERT_EQUAL_PTR(data_two, linked_list->head->next->data);
    TEST_ASSERT_EQUAL_PTR(data_two, linked_list->tail->data);

    free(data_one);
    free(data_two);
    free(linked_list);
}


void test_init_employee(void) {
    Employee *marx = init_employee("Marx", 64);

    TEST_ASSERT_EQUAL_STRING("Marx", marx->name);
    TEST_ASSERT_EQUAL_CHAR(64, marx->age);

    free(marx);
}

void test_compare_employee_not_greater(void) {
    Employee *marx = init_employee("Marx", 64);
    Employee *engels = init_employee("Engels", 74);

    int result = compare_employee(engels, marx);

    TEST_ASSERT(result < 0);

    free(marx);
    free(engels);
}

void test_compare_employee_greater(void) {
    Employee *marx = init_employee("Marx", 64);
    Employee *engels = init_employee("Engels", 74);

    int result = compare_employee(marx, engels);

    TEST_ASSERT(result > 0);

    free(marx);
    free(engels);
}

void test_compare_employee_equal(void) {
    Employee *marx = init_employee("Marx", 64);

    int result = compare_employee(marx, marx);

    TEST_ASSERT(result == 0);

    free(marx);
}

void test_get_node_found_1(void) {
    Employee *engels = init_employee("Engels", 74);
    Employee *marx = init_employee("Marx", 64);

    LinkedList *linked_list = (LinkedList*) malloc(sizeof(LinkedList));

    initialize_list(linked_list);
    add_head(linked_list, engels);
    add_head(linked_list, marx);

    Node *result = get_node(linked_list, (int (*)(void*, void*))compare_employee, marx);

    TEST_ASSERT_NOT_NULL(result);
    TEST_ASSERT_EQUAL_PTR(marx, result->data);

    free(engels);
    free(marx);
    free(linked_list);
    free(result);
}

void test_get_node_found_2(void) {
    Employee *engels = init_employee("Engels", 74);
    Employee *marx = init_employee("Marx", 64);

    LinkedList *linked_list = (LinkedList*) malloc(sizeof(LinkedList));

    initialize_list(linked_list);
    add_head(linked_list, marx);
    add_head(linked_list, engels);

    Node *result = get_node(linked_list, (int (*)(void*, void*))compare_employee, marx);

    TEST_ASSERT_NOT_NULL(result);
    TEST_ASSERT_EQUAL_PTR(marx, result->data);

    free(engels);
    free(marx);
    free(linked_list);
    free(result);
}

void test_get_node_not_found(void) {
    Employee *engels = init_employee("Engels", 74);
    Employee *marx = init_employee("Marx", 64);
    Employee *smith = init_employee("Smith", 67);

    LinkedList *linked_list = (LinkedList*) malloc(sizeof(LinkedList));

    initialize_list(linked_list);
    add_head(linked_list, marx);
    add_head(linked_list, engels);

    Node *result = get_node(linked_list, (int (*)(void*, void*))compare_employee, smith);

    TEST_ASSERT_NULL(result);
    
    free(engels);
    free(marx);
    free(smith);
    free(linked_list);
    free(result);
}

void test_delete_head_1(void) {
    Employee *engels = init_employee("Engels", 74);

    LinkedList *linked_list = (LinkedList*) malloc(sizeof(LinkedList));

    initialize_list(linked_list);
    add_head(linked_list, engels);

    Node *engels_node = get_node(linked_list, (int (*)(void*, void*))compare_employee, engels);

    delete(linked_list, engels_node);

    TEST_ASSERT_NULL(linked_list->head);
    TEST_ASSERT_NULL(linked_list->tail);

    free(engels);
    free(linked_list);
}


void test_delete_head_2(void) {
    Employee *engels = init_employee("Engels", 74);
    Employee *marx = init_employee("Marx", 64);

    LinkedList *linked_list = (LinkedList*) malloc(sizeof(LinkedList));

    initialize_list(linked_list);
    add_head(linked_list, marx);
    add_head(linked_list, engels);

    Node *engels_node = get_node(linked_list, (int (*)(void*, void*))compare_employee, engels);

    delete(linked_list, engels_node);

    TEST_ASSERT_EQUAL_PTR(linked_list->head->data, marx);

    free(engels);
    free(marx);
    free(linked_list);
}

void test_delete_not_head_1(void) {
    Employee *smith = init_employee("Smith", 67);
    Employee *marx = init_employee("Marx", 64);
    Employee *engels = init_employee("Engels", 74);

    LinkedList *linked_list = (LinkedList*) malloc(sizeof(LinkedList));

    initialize_list(linked_list);
    add_head(linked_list, smith);
    add_head(linked_list, marx);
    add_head(linked_list, engels);

    Node *smith_node = get_node(linked_list, (int (*)(void*, void*))compare_employee, smith);
    Node *marx_node = get_node(linked_list, (int (*)(void*, void*))compare_employee, marx);
    Node *engels_node = get_node(linked_list, (int (*)(void*, void*))compare_employee, engels);

    delete(linked_list, marx_node);

    TEST_ASSERT_EQUAL_PTR(engels_node->next, smith_node);

    free(engels);
    free(marx);
    free(smith);
    free(linked_list);
    free(engels_node);
    free(smith_node);
}

void test_delete_not_head_2(void) {
    Employee *smith = init_employee("Smith", 67);
    Employee *marx = init_employee("Marx", 64);
    Employee *engels = init_employee("Engels", 74);

    LinkedList *linked_list = (LinkedList*) malloc(sizeof(LinkedList));

    initialize_list(linked_list);
    add_head(linked_list, smith);
    add_head(linked_list, marx);
    add_head(linked_list, engels);

    Node *smith_node = get_node(linked_list, (int (*)(void*, void*))compare_employee, smith);
    Node *marx_node = get_node(linked_list, (int (*)(void*, void*))compare_employee, marx);
    Node *engels_node = get_node(linked_list, (int (*)(void*, void*))compare_employee, engels);


    delete(linked_list, smith_node);

    TEST_ASSERT_EQUAL_PTR(engels_node->next, marx_node);
    TEST_ASSERT_NULL(marx_node->next);

    free(smith);
    free(marx);
    free(engels);
    free(linked_list);
    free(marx_node);
    free(engels_node);
}

void test_delete_not_found(void) {
    Employee *smith = init_employee("Smith", 67);
    Employee *marx = init_employee("Marx", 64);
    Employee *engels = init_employee("Engels", 74);

    LinkedList *linked_list = (LinkedList*) malloc(sizeof(LinkedList));

    initialize_list(linked_list);
    add_head(linked_list, marx);
    add_head(linked_list, engels);

    Node *smith_node = (Node*) malloc(sizeof(Node));
    smith_node->data = smith;
    Node *marx_node = get_node(linked_list, (int (*)(void*, void*))compare_employee, marx);
    Node *engels_node = get_node(linked_list, (int (*)(void*, void*))compare_employee, engels);


    delete(linked_list, smith_node);

    TEST_ASSERT_EQUAL_PTR(engels_node->next, marx_node);
    TEST_ASSERT_NULL(marx_node->next);

    free(smith);
    free(marx);
    free(engels);
    free(linked_list);
    free(marx_node);
    free(engels_node);
}



int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_initialize_list);
    RUN_TEST(test_add_head_no_head);
    RUN_TEST(test_add_head_yes_head);
    RUN_TEST(test_add_tail_no_head);
    RUN_TEST(test_add_tail_yes_head);
    RUN_TEST(test_init_employee);
    RUN_TEST(test_compare_employee_not_greater);
    RUN_TEST(test_compare_employee_greater);
    RUN_TEST(test_compare_employee_equal);
    RUN_TEST(test_get_node_found_1);
    RUN_TEST(test_get_node_found_2);
    RUN_TEST(test_get_node_not_found);
    RUN_TEST(test_delete_head_1);
    RUN_TEST(test_delete_head_2);
    RUN_TEST(test_delete_not_head_1);
    RUN_TEST(test_delete_not_head_2);
    RUN_TEST(test_delete_not_found);
    return UNITY_END();
}
