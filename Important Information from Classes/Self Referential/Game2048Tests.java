
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

/**
 * The test class Game2048Tests.
 *
 * @author  (your name)
 * @version (a version number or a date)
 */

public class Game2048Tests {

    IGamePiece b2 = new BaseTile();
    IGamePiece b4 = new BaseTile(4);
    IGamePiece b8 = new BaseTile(8);
    IGamePiece b16 = new BaseTile(16);
    IGamePiece m4 = new MergeTile(b2, b2);
    IGamePiece m12 = new MergeTile(b4, b8);
    IGamePiece m16 = new MergeTile(b8, new MergeTile(b4, b4));

    IGamePiece m64 = new MergeTile(new MergeTile(m16, b16),
            new MergeTile(m16, m16));

    @Test
    public void testGetValue() {
        assertEquals(2, b2.getValue());
        assertEquals(4, m4.getValue());
        assertEquals(12, m12.getValue());
        assertEquals(16, m16.getValue());
    }

    @Test
    public void testBiggestBase() {
        assertEquals( b4, b4.biggestBase() );
        assertEquals( b2, m4.biggestBase() );
        assertEquals( b8, m12.biggestBase() );
        assertEquals( b8, m16.biggestBase() );
        assertEquals( b16, m64.biggestBase() );
    }

    @Test
    public void testMerge() {
        assertTrue( b4.canMerge(b4) );
        assertTrue( b4.canMerge(m4) );
        assertFalse( b4.canMerge(b8) );
    }

    @Test
    public void testValid() {
        assertTrue( b2.isValid() );
        assertTrue( m4.isValid() );
        assertTrue( m64.isValid() );
        assertFalse( m12.isValid() );
    }

    @Test
    public void testToString() {
        assertEquals("(2)", b2.toString());
        assertEquals("(16)", b16.toString());
        assertEquals("[(8)|[(4)|(4)]]", m16.toString());
    }

    @Test
    public void testCount() {
        assertEquals(0, b2.countMergedBases());
        assertEquals(2, m4.countMergedBases());
        assertEquals(10, m64.countMergedBases());
    }
}
