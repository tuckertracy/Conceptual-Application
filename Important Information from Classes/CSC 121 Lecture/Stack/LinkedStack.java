 

import java.util.NoSuchElementException;

public class LinkedStack<T> implements IStack<T> {
  private class Node {
    public T data;
    public Node next;
    public Node(T data, Node next) {
      this.data = data;
      this.next = next;
    }
  }

  private Node top;

  
  public LinkedStack() {
    top = null;
  }
  

  public T push(T item) {
    this.top = new Node(item, this.top);
    return item;
  }


  public T pop() {
    T save = peek();
    this.top = this.top.next;
    return save;
  }


  public T peek() {
    if (top == null) {
      throw new NoSuchElementException("Stack is empty");
    }
    
    return this.top.data;
  }


  // TODO:  make this more efficient...
  public int size() {
    int count = 0;
    for (Node node = top; node != null; node = node.next) {
        count++;
    }
    return count;
  }


  public boolean isEmpty() {
    return (top == null);
  }

}
