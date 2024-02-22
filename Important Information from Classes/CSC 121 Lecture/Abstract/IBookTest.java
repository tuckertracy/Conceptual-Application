
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

/**
 * The test class IBookTest.
 *
 * @author  (your name)
 * @version (a version number or a date)
 */
public class IBookTest
{
    IBook b1 = new Book("The Hobbit", "Tolkein", 45);
    IBook b2 = new RefBook("Websters", 52);
    IBook b3 = new AudioBook("Alice in Wonderland", "L.C.", 38, 180);

    @Test
    public void testDaysOverdue() {
        assertEquals( -9 , b1.daysOverdue(50) );
        assertEquals( 0 , b1.daysOverdue(59) );
        assertEquals( 6 , b1.daysOverdue(65) ); // 45+14 = 59
        assertEquals( 0 , b2.daysOverdue(54) );
        assertEquals( 1 , b2.daysOverdue(55) );
        assertEquals( 0 , b3.daysOverdue(52) );
        assertEquals( 2 , b3.daysOverdue(54) );
        
        
        assertTrue( b2.isOverdue(55) );
        assertFalse( b1.isOverdue(59) ) ; 
        assertTrue( b3.isOverdue(54) );
        
        assertEquals( 0 , b1.computeFine(50) );
        assertEquals( 0 , b1.computeFine(59) );
        assertEquals( 60 , b1.computeFine(65) );
        assertEquals( 0 , b2.computeFine(54) );
        assertEquals( 10 , b2.computeFine(55) );
        assertEquals( 0 , b3.computeFine(40) );
        assertEquals( 40 , b3.computeFine(54) );
    }

}
