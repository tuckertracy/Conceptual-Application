 

import static org.junit.Assert.*;
import org.junit.Before;
import org.junit.Test;

public class LinkedStackTest extends StackTest {

    @Before
    public void makeLinkedStack() {
        s = new LinkedStack<String>();
    }

}