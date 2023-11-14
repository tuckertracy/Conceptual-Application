import java.util.*;
import java.util.ArrayDeque;

/**
 * Write a description of class Palindrome here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
public class Palindrome
{

    private static Stack<Character> stack = new Stack();
    private static Queue<Character> queue = new ArrayDeque();

    public static void main (String args[]) {
        Scanner sc = new Scanner (System.in);
        System.out.println("Input something to see if it is a palindrome.");
        String line = sc.nextLine();
        sc = new Scanner(line);
        
        while ( sc.hasNext() ) {
            String token = sc.nextLine();
            //System.out.println( stack.size() + " " + queue.size() );
            System.out.println(checkPalindrome(token));
        }
    }

    public static boolean checkPalindrome(String str) {
        boolean b = false;

        /*if ( str.equals("") ) {
            b = true;
        } else {
            // Credit https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/regex/Pattern.html
            // for the "\\p{Punct}" and "\\p{Space}" parameters
            str = str.replaceAll("\\p{Punct}||\\p{Space}",""); 
            str = str.toLowerCase();
        }
        
        for ( int n = 0 ; n < str.length() ; n++ ) {
                //put every character from the string into the stack and the array
                //then pop the head of the stack and the array
                //compare the charcaters
                //repeat for size of array and stack
                String s = str.substring(n,n+1);
                stack.push(s);
                queue.add(s);
        }
        
        while ( !queue.isEmpty() ) {
            String first = queue.remove();
            String last = stack.pop();
            if ( first.equals(last) ) {
                b = true;
            } else {
                b = false;
            }
        }
        
        
        return b;
    }  */
    
    for ( int i = 0 ; i < str.length() ; i++ ) {
        char c = Character.toLowerCase(str.charAt(i));
        if ( Character.isLetter(c) ) {
            stack.push(c);
            queue.add(c);
        }
    }
    
    while ( !queue.isEmpty() ) {
        Character first = queue.remove();
        Character last = stack.pop();
        if ( first.equals(last) ) {
                b = true;
            } else {
                b = false;
            }
    }
    return b;
}
}

