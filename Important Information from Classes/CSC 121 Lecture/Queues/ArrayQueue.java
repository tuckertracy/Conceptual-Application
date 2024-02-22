 

import java.util.NoSuchElementException;
import java.util.Scanner;

/**
 *  The {@code ResizingArrayQueue} class represents a first-in-first-out (FIFO)
 *  queue of generic items.
 *  It supports the usual <em>enqueue</em> and <em>dequeue</em>
 *  operations, along with methods for peeking at the first item,
 *  testing if the queue is empty, and iterating through
 *  the items in FIFO order.
 *  <p>
 *  This implementation uses a resizing array, which double the underlying array
 *  when it is full and halves the underlying array when it is one-quarter full.
 *  The <em>enqueue</em> and <em>dequeue</em> operations take constant amortized time.
 *  The <em>size</em>, <em>peek</em>, and <em>is-empty</em> operations takes
 *  constant time in the worst case. 
 *  <p>
 *  For additional documentation, see Section 1.3 of
 *  <i>Algorithms, 4th Edition</i> by Robert Sedgewick and Kevin Wayne.
 *
 *  @author Robert Sedgewick
 *  @author Kevin Wayne
 *  
 *  Code adapted and modified by Nadeem Abdul Hamid, 2019 
 */
public class ArrayQueue<T> implements IQueue<T> {
    private T[] q;       // queue elements
    private int size;          // number of elements on queue
    private int first;      // index of first element of queue
    private int last;       // index of next available slot


    /**
     * Initializes an empty queue.
     */
    public ArrayQueue() {
        q = (T[]) new Object[2];
        size = 0;
        first = 0;
        last = 0;
    }

    /**
     * Is this queue empty?
     * @return true if this queue is empty; false otherwise
     */
    public boolean isEmpty() {
        return size == 0;
    }

    /**
     * Returns the number of items in this queue.
     * @return the number of items in this queue
     */
    public int size() {
        return size;
    }

    // resize the underlying array
    private void resize(int capacity) {
        assert capacity >= size;
        T[] temp = (T[]) new Object[capacity];
        for (int i = 0; i < size; i++) {
            temp[i] = q[(first + i) % q.length];
        }
        q = temp;
        first = 0;
        last  = size;
    }

    /**
     * Adds the item to this queue.
     * @param item the item to add
     */
    public T enqueue(T item) {
        // double size of array if necessary and recopy to front of array
        if (size == q.length) resize(2*q.length);   // double size of array if necessary
        q[last] = item;  
        last++;// add item
        if (last == q.length) last = 0;          // wrap-around
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
        T item = q[first];
        q[first] = null;                            // to avoid loitering
        size--;
        first++;
        if (first == q.length) first = 0;           // wrap-around
        // shrink size of array if necessary
        if (size > 0 && size == q.length/4) resize(q.length/2); 
        return item;
    }

    /**
     * Returns the item least recently added to this queue.
     * @return the item least recently added to this queue
     * @throws java.util.NoSuchElementException if this queue is empty
     */
    public T peek() {
        if (isEmpty()) throw new NoSuchElementException("Queue underflow");
        return q[first];
    }


   /**
     * Unit tests the {@code ResizingArrayQueue} data type.
     *
     * @param args the command-line arguments
     */
    public static void main(String[] args) {
        ArrayQueue<String> queue = new ArrayQueue<String>();
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