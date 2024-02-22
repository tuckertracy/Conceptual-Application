 

/**
 * A small queue interface.  You can query the size of the queue and
 * ask whether it is empty, enqueue items, dequeue items, and peek at the top
 * item.
 */
public interface IQueue<T> {
  
  /**
   * Adds the item to this queue.
   * @param item the item to add
   * @return the same item
   */
  public T enqueue(T item);

  /**
   * Removes and returns the item on this queue that was least recently added.
   * @return the item on this queue that was least recently added
   * @throws java.util.NoSuchElementException if this queue is empty
   */
  public T dequeue();

  /**
   * Returns the item least recently added to this queue.
   * @return the item least recently added to this queue
   * @throws java.util.NoSuchElementException if this queue is empty
   */
  public T peek();
  
  /**
   * Returns the number of items currently in the queue.
   */
  public int size();
  
  /**
   * Returns whether the queue is empty or not.
   */
  public boolean isEmpty();

}
