 

import java.util.NoSuchElementException;
import java.util.Scanner;

/**
 *  The {@code LinkedQueue} class represents a first-in-first-out (FIFO)
 *  queue of generic items.
 *  It supports the usual <em>enqueue</em> and <em>dequeue</em>
 *  operations, along with methods for peeking at the first item,
 *  testing if the queue is empty, and iterating through
 *  the items in FIFO order.
 *  <p>
 *  This implementation uses a singly linked list with a non-static nested class 
 *  for linked-list nodes.  
 *  The <em>enqueue</em>, <em>dequeue</em>, <em>peek</em>, <em>size</em>, 
 *  and <em>is-empty</em> operations all take constant time in the worst case.
 *  <p>
 *  For additional documentation, see Section 1.3 of
 *  <i>Algorithms, 4th Edition</i> by Robert Sedgewick and Kevin Wayne.
 *
 *  @author Robert Sedgewick
 *  @author Kevin Wayne
 *  
 *  Code adapted and modified by Nadeem Abdul Hamid, 2019 
 */
public class LinkedQueue<T> implements IQueue<T> {
    private int size;         // number of elements on queue
    private Node first;    // beginning of queue
    private Node last;     // end of queue

    // helper linked list class
    private class Node {
        private T item;
        private Node next;
        
        public Node(T item, Node next) {
          this.item = item;
          this.next = next;
        }
    }

    /**
     * Initializes an empty queue.
     */
    public LinkedQueue() {
        first = null;
        last  = null;
        size = 0;
    }

    /**
     * Is this queue empty?
     * @return true if this queue is empty; false otherwise
     */
    public boolean isEmpty() {
        return first == null;
    }

    /**
     * Returns the number of items in this queue.
     * @return the number of items in this queue
     */
    public int size() {
        return size;     
    }

    /**
     * Returns the item least recently added to this queue.
     * @return the item least recently added to this queue
     * @throws java.util.NoSuchElementException if this queue is empty
     */
    public T peek() {
        if (isEmpty()) throw new NoSuchElementException("Queue underflow");
        return first.item;
    }

    /**
     * Adds the item to this queue.
     * @param item the item to add
   * @return the same item
     */
    public T enqueue(T item) {
        Node oldlast = last;
        last = new Node(item, null);
        if (isEmpty()) first = last;
        else           oldlast.next = last;
        size++;
        return item; 
    }

    /**
     * Removes and returns the item on this queue that was least recently added.
     * @return the item on this queue that was least recently added
     * @throws java.util.NoSuchElementException if this queue is empty
     */
    public T dequeue() {
        if (isEmpty()) throw new NoSuchElementException("Queue underflow");
        T item = first.item;
        first = first.next;
        size--;
        if (isEmpty()) last = null;   // to avoid loitering
        return item;
    }

    /**
     * Returns a string representation of this queue.
     * @return the sequence of items in FIFO order, separated by spaces
     */
    public String toString() {
        StringBuilder s = new StringBuilder();
        Node cur = first;
        while (cur != null) {
            s.append(cur.item + " ");
            cur = cur.next;
        }
        return s.toString();
    } 


    /**
     * Unit tests the {@code LinkedQueue} data type.
     *
     * @param args the command-line arguments
     */
    public static void main(String[] args) {
        LinkedQueue<String> queue = new LinkedQueue<String>();
        Scanner sc = new Scanner(System.in);
        while (sc.hasNext()) {
            String item = sc.next();
            if (!item.equals("-"))
                queue.enqueue(item);
            else if (!queue.isEmpty())
                System.out.print(queue.dequeue() + " ");
        }
        System.out.println("(" + queue.size() + " left on queue)");
    }
}