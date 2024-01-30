

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

/**
 * The test class BSTTest.
 *
 * @author  (your name)
 * @version (a version number or a date)
 */
public class BSTTest
{
    @Test
    public void testLCA() {
        BST<Integer, Integer> t1 = new BST<Integer, Integer>();
        assertEquals(null, t1.lowestCommonAncestor(2, 8)); //there is nothing in the tree test
        
        BST<Integer, Integer> t = new BST<Integer, Integer>();
        t.put(6, 6);
        t.put(2, 2);
        t.put(8, 8);
        t.put(0, 0);
        t.put(4, 4);
        t.put(7, 7);
        t.put(9, 9);
        t.put(3, 3);
        t.put(5, 5);
        
        assertEquals(null, t.lowestCommonAncestor(1, 18)); //is not part of the tree test
        assertEquals(2, t.lowestCommonAncestor(2, 2)); //they are the same keys
        assertEquals(6, t.lowestCommonAncestor(2, 6)); //one of the given keys is the root of the tree
        assertEquals(6, t.lowestCommonAncestor(2, 8));
        assertEquals(2, t.lowestCommonAncestor(2, 4));
    }
}
