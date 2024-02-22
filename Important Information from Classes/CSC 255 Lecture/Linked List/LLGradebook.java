
/**
 * Represents a gradebook using a linked list of
 * numbers.
 */
public class LLGradebook implements IGradebook
{
    NumNode head;

    public LLGradebook() {
        this.head = null;
    }

    /** Returns the number of grades 
     * in this book */
    public int count() {
        int total = 0;
        NumNode cur = this.head;

        while ( cur != null ) {
            total = total + 1; 
            cur = cur.next;
        }

        return total;

        // how this would go...
        /*
        if (cur == null) { return total; }
        else { total = total + 1; cur = cur.next;
        if (cur == null) { return total; }
        else { total = total + 1; cur = cur.next;
        if (cur == null) { return total; }
        else { total = total + 1; cur = cur.next;
        if (cur == null) { return total; }
        else { total = total + 1; cur = cur.next;
        ... */
    }

    /** Updates the list of grades in 
     * this book by adding the given grade */
    public void addGrade(int g) {
        this.head = new NumNode(g, this.head);
    }

    /** Produces the average grade of all 
     * added grades */
    public double average() {
        int sum = 0;
        int total = 0;
        NumNode cur = this.head;

        while ( cur != null ) {
            sum = sum + cur.value; 
            total = total + 1;
            cur = cur.next;
        }

        return sum / (double) total;
    }

    /** Produces the highest grade */
    public int bestGrade() {
        //   if (count() == 0) { throw ....Exception(...); }

        int biggest = 0;
        NumNode cur = head;

        while ( cur != null ) {
            if (cur.value > biggest) {
                biggest = cur.value;
            }

            cur = cur.next;
        }

        return biggest;
    }

    /** produces the number of grades in this gradebook between 
     *  low and high, inclusive
     */
    public int countBetween(int low, int high) {
        int count = 0;
        NumNode cur = head;

        while(cur != null) {
            if(cur.value >= low  && cur.value <= high) {
                count = count + 1;
            }

            cur = cur.next;
        }

        return count;
    }

    /** deletes the most recently added grade from this gradebook */
    public void removeLastAdded() {
        if(this.head != null) {
            this.head = this.head.next;
        }
    }

    /** produces a comma separated list of the grades in this gradebook */
    public String toString() {
        String s = "";
        NumNode cur = head;
        while(cur!=null) {
            if(cur.next == null) {
                s = s + cur.value;
            } else {
                s = s + cur.value + ",";
            }
            cur = cur.next;
        }

        return s;
    }

    public void addSorted(int g) {
    NumNode cur = this.head;
    
    if(this.head==null || g > this.head.value) {
                this.addGrade(g);
            } else {
                
                while ( cur.next != null && cur.next.value > g) {
                    cur = cur.next;
                }
                NumNode newNode = new NumNode ( g , cur.next );
                cur.next = newNode;
            }
    
}
}