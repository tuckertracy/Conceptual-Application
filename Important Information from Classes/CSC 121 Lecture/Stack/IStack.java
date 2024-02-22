 

/**
 * A small stack interface.  You can query the size of the stack and
 * ask whether it is empty, push items, pop items, and peek at the top
 * item.
 */
public interface IStack<T> {
  
  /**
   * Adds the given item to the top of the stack.
   * @return the same item
   */
  public T push(T item);

  /**
   * Removes the top item from the stack and returns it.
   * @exception java.util.NoSuchElementException if the stack is empty.
   */
  public T pop();

  /**
   * Returns the top item from the stack without popping it.
   * @exception java.util.NoSuchElementException if the stack is empty.
   */
  public T peek();
  
  /**
   * Returns the number of items currently in the stack.
   */
  public int size();
  
  /**
   * Returns whether the stack is empty or not.
   */
  public boolean isEmpty();

}
