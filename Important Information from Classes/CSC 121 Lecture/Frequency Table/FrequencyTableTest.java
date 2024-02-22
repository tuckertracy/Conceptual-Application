
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

/**
 * The test class FrequencyTableTest.
 *
 * @author  (your name)
 * @version (a version number or a date)
 */
public class FrequencyTableTest
{
    @Test
    public void testFreqTable() {
        FrequencyTable ft = new FrequencyTable();
        assertEquals(0, ft.getTotalChars());

        ft.addOne('a');
        ft.addOne('n');
        ft.addOne('a');
        ft.addOne('z');
        ft.addOne('a');

        assertEquals(5, ft.getTotalChars());
        assertEquals(3, ft.freqOf('a'));
        assertEquals(0, ft.freqOf('b'));
        assertEquals(1, ft.freqOf('z'));
        
        ft.addOne('a');
        ft.addOne('b');
        ft.addOne('t');
        ft.addOne('z');
        
        assertEquals(9, ft.getTotalChars());
        assertEquals(4, ft.freqOf('a'));
        assertEquals(1, ft.freqOf('b'));
        assertEquals(2, ft.freqOf('z'));
        assertEquals(1, ft.freqOf('t'));
        assertEquals(1, ft.freqOf('n'));
    }
}
