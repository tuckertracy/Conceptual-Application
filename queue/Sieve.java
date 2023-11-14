import java.util.*;

public class Sieve
{
    Queue<Integer> numQueue = new ArrayDeque<Integer>();
    Queue<Integer> primeQueue = new ArrayDeque<Integer>();
    private int max;
    private int count;

    public Sieve() {
        this.numQueue = numQueue;
        this.primeQueue= primeQueue;
        max = -1;
        count = -1;
    }

    public void computeTo(int n) {
        max = n;

        if (n < 2) {
            throw new IllegalArgumentException("Number must be at least 2");
        }

        for(int i = 2; i <= n; i++) {
            numQueue.add(i);
        }

        int p;

        do {
            p = numQueue.remove();
            primeQueue.add(p);
            int size = numQueue.size();
            for(int i = 0; i < size ; i++) {
                int x = numQueue.remove();
                if ( x % p != 0 ) {
                    numQueue.add(x);
                }
            }
        }
        while (p < Math.sqrt(n));

        for(int i : numQueue) {
            primeQueue.add(i);
        }

        count = primeQueue.size();
    }

    public void reportResults() {
        /*if ( primeQueue.size() < 12 ) {
        while ( !primeQueue.isEmpty() ) {
        System.out.print(primeQueue.remove() + " ");
        }
        } else {
        for ( int x = 0 ; x < primeQueue.size() ; x++ ) {
        for (int i = 0 ; i < 12 ; i++ ) {
        System.out.print(primeQueue.remove() + " ");
        }
        System.out.println();
        }
        }*/
        int count = 0;
        String str = "";
        for ( int x : primeQueue ) {
            str += (x + " ");
            count++;
            System.out.print(str);
            if ( count % 12 == 0) {
                System.out.println();
            }
            str = "";
        }
        numQueue.clear();
        primeQueue.clear();
    }

    public int getMax() {
        if (max < 0) {
            throw new IllegalStateException();
        }
        else {
            return max;
        }
    }

    public int getCount() {
        if (count < 0) {
            throw new IllegalStateException();
        }
        else {
            return count;
        }
    }
}