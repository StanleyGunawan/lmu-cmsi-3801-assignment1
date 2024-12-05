// A module for an expandable array-based stack of strings, built from
// scratch. This module is hyper-focused on software security, so you
// will see defensive copying, strict bounds-checking, input validation,
// and error objects prominently featured. Although the stack will grow
// and shrink as necessary, it will never exceed a really big maximum
// capacity. This is to prevent a malicious user from causing the stack
// to grow to an enormous size and consume all available memory.

#ifndef STRING_STACK_H
#define STRING_STACK_H

// Not needed for C23, but needed for C17 and below.
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

#define MAX_CAPACITY 32768
#define MAX_ELEMENT_BYTE_SIZE 256
#define INITIAL_CAPACITY 16

// Make the representation of the stack unknown to code that uses it
typedef struct _Stack *stack;

typedef enum
{
    success,
    out_of_memory,
    stack_element_too_large,
    stack_full,
    stack_empty
} response_code;

// Result object for operations returning a stack. If the stack was
// created, the error field will be success and the result will hold
// a pointer to the stack that the caller is responsible for freeing.
// If there is an error, the stack field will be NULL.
typedef struct
{
    response_code code;
    stack stack;
} stack_response;

// Result object for operations returning a string. If the operation
// was successful, the error field will be success and the result will
// hold a pointer to the string that the caller is responsible for freeing.
// If there is an error, the string field will be NULL.
typedef struct
{
    response_code code;
    char *string;
} string_response;

// Note that since stacks are large, we always pass pointers to them.
// But some of the operations do not mutate the stack, so we mark the
// parameter const. Remember that the typedef 'stack' is a pointer type!
// The strings themselves are defensively copied in and out of the stack.

stack_response create(); // Must destroy() returned stack

int size(const stack s);
bool is_empty(const stack s);
bool is_full(const stack s); // If at MAX_CAPACITY

response_code push(stack s, char *item); // Stores copy of string inside stack
string_response pop(stack s);            // Will include a copy of the string
                                         // from the stack, so the caller is
                                         // responsible for freeing it

void destroy(stack *s); // frees *all* the memory

#endif

typedef struct _Stack
{
    char **elements;
    int top;
    int capacity;
} _Stack;

stack_response create()
{
    stack s = malloc(sizeof(struct _Stack));
    if (s == NULL)
    {
        return (stack_response){.code = out_of_memory, .stack = NULL};
    }

    s->capacity = INITIAL_CAPACITY;
    s->elements = malloc(INITIAL_CAPACITY * sizeof(char *));
    if (s->elements == NULL)
    {
        free(s);
        return (stack_response){.code = out_of_memory, .stack = NULL};
    }

    s->top = 0;
    return (stack_response){.code = success, .stack = s};
}

int size(const stack s)
{
    return s ? s->top : 0;
}

bool is_empty(const stack s)
{
    return s ? s->top == 0 : true;
}

bool is_full(const stack s)
{
    return s ? s->top >= MAX_CAPACITY : false;
}

response_code push(stack s, char *item)
{
    if (is_full(s))
    {
        return stack_full;
    }

    if (strlen(item) >= MAX_ELEMENT_BYTE_SIZE)
    {
        return stack_element_too_large;
    }

    if (s->top == s->capacity)
    {
        int new_capacity = s->capacity * 2;
        if (new_capacity > MAX_CAPACITY)
        {
            new_capacity = MAX_CAPACITY;
        }

        char **new_elements = realloc(s->elements, new_capacity * sizeof(char *));
        if (new_elements == NULL)
        {
            return out_of_memory;
        }

        s->elements = new_elements;
        s->capacity = new_capacity;
    }

    s->elements[s->top] = strdup(item);
    if (s->elements[s->top] == NULL)
    {
        return out_of_memory;
    }

    s->top++;
    return success;
}

string_response pop(stack s)
{
    if (!s || is_empty(s))
    {
        return (string_response){.code = stack_empty, .string = NULL};
    }

    s->top--;
    char *item = s->elements[s->top];
    s->elements[s->top] = NULL;

    return (string_response){.code = success, .string = item};
}

void destroy(stack *s)
{
    if (!s || !*s)
        return;

    for (size_t i = 0; i < (*s)->top; i++)
    {
        free((*s)->elements[i]);
    }

    free((*s)->elements);
    free(*s);
    *s = NULL;
}