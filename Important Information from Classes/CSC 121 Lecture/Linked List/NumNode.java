
/**
 * Represents a node in a linked list of numbers
 */
public class NumNode
{
    int value;       // "first"
    NumNode next;    // "rest"
    
    public NumNode(int value, NumNode next) {
        this.value = value;
        this.next = next;
    }
    
    /*
    public int length() {
        if (this.next == null) {
            return 1;
        } else {
            return 1 + this.next.length();
        }
    }
    */
}
