 

import static org.junit.Assert.*;
import org.junit.Before;
import org.junit.Test;

public class ArrayStackTest extends StackTest {

  @Before
  public void makeBoundedStack() {
      s = new ArrayStack<String>();
  }

}
