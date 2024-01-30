
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

/**
 * The test class TrackerTest.
 *
 * @author  (your name)
 * @version (a version number or a date)
 */
public class TrackerTest
{
    IPageTracker history = new Tracker(5);

    @Test
    public void test() {
        history.visit("berry.edu");
        history.visit("catalog");
        history.visit("cs.berry.edu");
        
        assertEquals("cs.berry.edu", history.currentPage());
        
        assertEquals("catalog", history.goBack(1));
        
        assertEquals("cs.berry.edu", history.goForward(1));
        
        assertEquals("cs.berry.edu", history.currentPage());
        
        history.visit("facebook");
        history.visit("friends");
        
        assertEquals("cs.berry.edu", history.goBack(2));
        
        history.visit("linkedin");
        history.goBack(2);
        assertEquals("catalog", history.currentPage());
        history.goForward(2);
        history.visit("ebay");
        history.visit("google");
        history.visit("amazon");
        assertEquals("catalog", history.goBack(5));
        assertEquals("Home", history.goBack(1));
        assertEquals("catalog", history.goForward(1));
        assertEquals("cs.berry.edu", history.goForward(1));
        history.visit("1");
        history.visit("2");
        history.visit("3");
        history.visit("4");
        history.visit("5");
        history.visit("6");
        assertEquals("6", history.currentPage());
    }
}
