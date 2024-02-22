
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

/**
 * The test class GradebookTests.
 *
 * @author  (your name)
 * @version (a version number or a date)
 */
public class GradebookTests
{
    @Test 
    public void testHw11() {
        LLGradebook llg = new LLGradebook();

        // PART 1
        llg.addGrade(65);
        llg.addGrade(89);
        llg.addGrade(100);
        llg.addGrade(82);
        llg.addGrade(94);
        llg.addGrade(86);

        assertEquals(0, new LLGradebook().countBetween(80, 89));
        assertEquals(3, llg.countBetween(80, 89));
        assertEquals(0, llg.countBetween(70, 79));
        assertEquals(2, llg.countBetween(94, 100));
        assertEquals(6, llg.countBetween(0, 100));

        // PART 2
        new LLGradebook().removeLastAdded();
        llg.removeLastAdded();
        assertEquals(2, llg.countBetween(80, 89));
        llg.removeLastAdded();
        llg.removeLastAdded();
        assertEquals(2, llg.countBetween(80, 100));
        assertEquals(3, llg.count());

        // PART 3
        assertEquals("100,89,65", llg.toString());
        llg.removeLastAdded();
        llg.removeLastAdded();
        assertEquals("65", llg.toString());
        llg.removeLastAdded();
        assertEquals("", llg.toString());
        llg.removeLastAdded();           // shouldn't do anything
        assertEquals("", llg.toString());
        
        // PART 4
        llg.addSorted(65);
        assertEquals("65", llg.toString());
        llg.addSorted(89);
        assertEquals("89,65", llg.toString());
        llg.addSorted(100);
        assertEquals("100,89,65", llg.toString());
        llg.addSorted(82);
        assertEquals("100,89,82,65", llg.toString());
        llg.addSorted(94);
        llg.addSorted(86);
        llg.addSorted(50);
        assertEquals("100,94,89,86,82,65,50", llg.toString());
         
    }
}


