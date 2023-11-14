
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

/**
 * The test class PalindromeTest.
 *
 * @author  (your name)
 * @version (a version number or a date)
 */
public class PalindromeTest
{
    @Test
    public void testStringStuff() {
        String s = "ab";
        assertEquals("b",s.substring(1,2));
        String c = "a b";
        assertEquals("ab",c.replaceAll(" ",""));
        String z = "ABC";
        assertEquals("abc",z.toLowerCase());
    }

    @Test
    public void testCheckPalindrome() {
        assertEquals(true,Palindrome.checkPalindrome(""));
        assertEquals(true,Palindrome.checkPalindrome("a"));
        assertEquals(false,Palindrome.checkPalindrome("ab"));
    }
}
