 

import java.util.NoSuchElementException;

public class ArrayStack<T> implements IStack<T> {
  private final static int CAPACITY = 40;
  
  private T[] array;
  private int size; // actual number of things in the stack

  
  public ArrayStack() {
    size = 0;
    array = (T[]) new Object[CAPACITY];
  }
  

  public T push(T item) {
    if (size == array.length) {
      throw new IllegalStateException("Stack full!");   
      // TODO:   fix this...
      // https://opendatastructures.org/ods-java/2_1_ArrayStack_Fast_Stack_O.html#SECTION00512000000000000000
    }

    array[size] = item;
    size++;  
    return item;
  }

  
  public T pop() {
    T save = peek();
    size--;
    array[size] = null;
    return save;    
  }

  
  public T peek() {
    if (size == 0) {
      throw new NoSuchElementException("Cannot peek into empty stack");
    }
    
    return array[size-1];
  }
  

  public int size() {
    return size;
  }

  
  public boolean isEmpty() {
    return (size == 0);
  }

}
