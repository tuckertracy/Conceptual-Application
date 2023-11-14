import java.util.NoSuchElementException;

/**
 * Write a description of class LeakyStack here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
public class LeakyStack<T> implements IStack<T>
{
    // instance variables - replace the example below with your own
    private int size;
    private T[] array;
    private int top;

    public LeakyStack(int capacity) {
        size = 0;
        top = 0;
        array = (T[]) new Object[capacity];
    }

    /**
     * Adds the given item to the top of the stack.
     * @return the same item
     */
    public T push(T item) {
        array[top] = item;
        top = (top + 1) % array.length;
        if (size < array.length) {
            size++;
        }

        return item;
    }

    /**
     * Removes the top item from the stack and returns it.
     * @exception java.util.NoSuchElementException if the stack is empty.
     */
    public T pop() {
        T save = peek();
        top = (top - 1 + array.length) % array.length;
        size--;
        array[top] = null;
        return save; 
    }

    /**
     * Returns the top item from the stack without popping it.
     * @exception java.util.NoSuchElementException if the stack is empty.
     */
    public T peek() {
        if (size == 0) {
            throw new NoSuchElementException("Cannot peek into empty stack");
        }

        return array[(top - 1 + array.length) % array.length];
    }

    /**
     * Returns the number of items currently in the stack.
     */
    public int size() {
        return this.size;
    }

    /**
     * Returns whether the stack is empty or not.
     */
    public boolean isEmpty() {
        return (size <= 0);
    }
    
    public void clear() {
        size = 0;
    }
}
