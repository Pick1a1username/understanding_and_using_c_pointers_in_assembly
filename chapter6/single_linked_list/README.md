# Single Linked List

## Build

## Unit Test

Install Unity.

Reference: https://github.com/ThrowTheSwitch/Unity/issues/302#issuecomment-508945504

```
git clone git@github.com:ThrowTheSwitch/Unity.git
cd Unity
cmake .  # generates a Makefile
make     # build it
sudo make install  # install source and headers to /usr/local/src
```

Build unit test.


```
$ gcc -I/usr/local/include/unity -g -fbounds-check -o single_linked_list_test single_linked_list_test.c single_linked_list.o employee.o -no-pie -lunity
```

Note: `-lunity` should be placed at the end of the arguments!


