#include "string_stack.h"
// I have linker issues, so i put did the definitions in the h file.

// typedef struct _Stack {
//     char** elements;
//     int top;
//     int capacity;
// } _Stack;

// stack_response create(){
//     stack s = malloc(sizeof(struct _Stack));
//     if (s == NULL) {
//         return (stack_response){.code = out_of_memory, .stack = NULL};
//     }

//     s->capacity = INITIAL_CAPACITY;
//     s->elements = malloc(INITIAL_CAPACITY * sizeof(char*));
//     if (s->elements == NULL) {
//         free(s);
//         return (stack_response){.code = out_of_memory, .stack = NULL};
//     }

//     s->top = 0;
//     return (stack_response){.code = success, .stack = s};
// }

// int size(const stack s) {
//     return s ? s->top : 0;
// }

// bool is_empty(const stack s) {
//     return s ? s->top == 0 : true;
// }

// bool is_full(const stack s) {
//     return s ? s->top >= MAX_CAPACITY : false;
// }

// response_code push(stack s, char* item) {
//     if (is_full(s)) {
//         return stack_full;
//     }

//     if (strlen(item) >= MAX_ELEMENT_BYTE_SIZE) {
//         return stack_element_too_large;
//     }

//     if (s->top == s->capacity) {
//         int new_capacity = s->capacity * 2;
//         if (new_capacity > MAX_CAPACITY) {
//             new_capacity = MAX_CAPACITY;
//         }

//         char** new_elements = realloc(s->elements, new_capacity * sizeof(char*));
//         if (new_elements == NULL) {
//             return out_of_memory;
//         }

//         s->elements = new_elements;
//         s->capacity = new_capacity;
//     }

//     s->elements[s->top] = strdup(item);
//     if (s->elements[s->top] == NULL) {
//             return out_of_memory;
//     }

//     s->top++;
//     return success;
//     }

// string_response pop(stack s) {
//     if (!s || is_empty(s)) {
//         return (string_response){.code = stack_empty, .string = NULL};
//     }

//     s->top--;
//     char* item = s->elements[s->top];
//     s->elements[s->top] = NULL;

//     return (string_response){.code = success, .string = item};
// }

// // Destroy the stack and free all memory
// void destroy(stack* s) {
//     if (!s || !*s) return;

//     for (size_t i = 0; i < (*s)->top; i++) {
//         free((*s)->elements[i]);
//     }

//     free((*s)->elements);
//     free(*s);
//     *s = NULL;
// }