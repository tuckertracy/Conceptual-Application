
import static org.junit.Assert.*;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

/**
 * The test class ExpressionParserTest.
 *
 * @author  (your name)
 * @version (a version number or a date)
 */
public class ExpressionParserTest
{
    @Test
    public void testTraversals() {
        String[] tokens = "2 + 5 * 4 - 7".split(" +");
        BinaryTree<String> result = ExpressionParser.buildExpTree(tokens);

        assertEquals("((2 + (5 * 4)) - 7)", result.inOrderString());
        assertEquals("(- (+ 2 (* 5 4)) 7)", result.preOrderString());
        assertEquals("2 5 4 * + 7 -", result.postOrderString());
        assertEquals("- + 2 * 5 4 7", result.depthFirstStackString());
        assertEquals("- + 7 2 * 5 4", result.breadthFirstStackString());
    }
    
    @Test
    public void textMaxDepth() {
        String[] tokens = "2 + 5 * 4 - 7".split(" +");
        BinaryTree<String> result = ExpressionParser.buildExpTree(tokens);

        assertEquals(3, result.maxDepth());
    }
}
