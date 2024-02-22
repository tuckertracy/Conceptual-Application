import java.util.Arrays;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

/**
 * @author downey
 * @param <T>
 *
 */
public class MyArrayList<T> implements List<T> {
    int size;                    // keeps track of the number of elements
    private T[] array;           // stores the elements

    /**
     *
     */
    public MyArrayList() {
        // You can't instantiate an array of T[], but you can instantiate an
        // array of Object and then typecast it.  Details at
        // http://www.ibm.com/developerworks/java/library/j-jtp01255/index.html
        array = (T[]) new Object[10];
        size = 0;
    }

    /**
     * @param args
     */
    public static void main(String[] args) {
        // run a few simple tests
        MyArrayList<Integer> mal = new MyArrayList<Integer>();
        mal.add(1);
        mal.add(2);
        mal.add(3);
        System.out.println(Arrays.toString(mal.toArray()) + " size = " + mal.size);

        mal.remove(new Integer(2));
        System.out.println(Arrays.toString(mal.toArray()) + " size = " + mal.size);
    }

    public boolean add(T element) {
        if (size == array.length) {
            T[] newArray = (T[]) new Object[array.length * 2];

            for ( int i = 0 ; i < array.length ; i++ ) {
                newArray[i] = array[i];
            }

            array = newArray;
            array[size] = element;
            size++;
        } else {
            array[size] = element;
            size++;
        }
        return true;
    }

    public int indexOf(Object target) {
        for (int i = 0 ; i < size ; i++){
                if ( equals(target,this.get(i)) ) {
                    return i;
                }
            }
        return -1;
    }

    public T remove(int index) {
        T oldE = this.get(index);
        //array[index] = array[index + 1];
        
        for (int i = index ; i < size-1 ; i++) {
            array[i] = array[i+1];
        }
        
        size--;
        return oldE;
    }

    public T set(int index, T element) {
        T oldE = this.get(index);
        array[index] = element;
        return oldE;
    }

    public void add(int index, T element) {
        if (index < 0 || index > size) {
            throw new IndexOutOfBoundsException();
        }
        // add the element to get the resizing
        add(element);

        // shift the elements
        for (int i=size-1; i>index; i--) {
            array[i] = array[i-1];
        }
        // put the new one in the right place
        array[index] = element;
    }

    public boolean addAll(Collection<? extends T> collection) {
        boolean flag = true;
        for (T element: collection) {
            flag &= add(element);
        }
        return flag;
    }

    public boolean addAll(int index, Collection<? extends T> collection) {
        throw new UnsupportedOperationException();
    }

    public void clear() {
        // note: this version does not actually null out the references
        // in the array, so it might delay garbage collection.
        size = 0;
    }

    public boolean contains(Object obj) {
        return indexOf(obj) != -1;
    }

    public boolean containsAll(Collection<?> collection) {
        for (Object element: collection) {
            if (!contains(element)) {
                return false;
            }
        }
        return true;
    }

    public T get(int index) {
        if (index < 0 || index >= size) {
            throw new IndexOutOfBoundsException();
        }
        return array[index];
    }

    /** Checks whether an element of the array is the target.
     *
     * Handles the special case that the target is null.
     *
     * @param target
     * @param object
     */
    private boolean equals(Object target, Object element) {
        if (target == null) {
            return element == null;
        } else {
            return target.equals(element);
        }
    }

    public boolean isEmpty() {
        return size == 0;
    }

    public Iterator<T> iterator() {
        // make a copy of the array
        T[] copy = Arrays.copyOf(array, size);
        // make a list and return an iterator
        return Arrays.asList(copy).iterator();
    }

    public int lastIndexOf(Object target) {
        // see notes on indexOf
        for (int i = size-1; i>=0; i--) {
            if (equals(target, array[i])) {
                return i;
            }
        }
        return -1;
    }

    public ListIterator<T> listIterator() {
        // make a copy of the array
        T[] copy = Arrays.copyOf(array, size);
        // make a list and return an iterator
        return Arrays.asList(copy).listIterator();
    }

    public ListIterator<T> listIterator(int index) {
        // make a copy of the array
        T[] copy = Arrays.copyOf(array, size);
        // make a list and return an iterator
        return Arrays.asList(copy).listIterator(index);
    }

    public boolean remove(Object obj) {
        int index = indexOf(obj);
        if (index == -1) {
            return false;
        }
        remove(index);
        return true;
    }

    public boolean removeAll(Collection<?> collection) {
        boolean flag = true;
        for (Object obj: collection) {
            flag &= remove(obj);
        }
        return flag;
    }

    public boolean retainAll(Collection<?> collection) {
        throw new UnsupportedOperationException();
    }

    public int size() {
        return size;
    }

    public List<T> subList(int fromIndex, int toIndex) {
        if (fromIndex < 0 || toIndex >= size || fromIndex > toIndex) {
            throw new IndexOutOfBoundsException();
        }
        T[] copy = Arrays.copyOfRange(array, fromIndex, toIndex);
        return Arrays.asList(copy);
    }

    public Object[] toArray() {
        return Arrays.copyOf(array, size);
    }

    public <U> U[] toArray(U[] array) {
        throw new UnsupportedOperationException();
    }
}