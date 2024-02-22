
public class LList<T>
{
    private ListNode<T> head;

    public LList() {    // constructs a new empty list
        head = null;
    }

    public void addToFront(T obj) {
        head = new ListNode<T>(obj, head);
    }

    public void addToEnd(T obj) {
        ListNode<T> newNode = new ListNode<T>(obj, null);

        if (head == null) {
            head = newNode;
        } else {
            ListNode<T> cur = head;
            while (cur.next != null) {
                cur = cur.next;
            }
            cur.next = newNode;
        }

    }

    public int length() {
        int total = 0;
        ListNode<T> cur = head;
        while (cur != null) {
            total++;
            cur = cur.next;
        }
        return total;
    }

    public String toString() {
        String inside = "";
        ListNode<T> cur = head;
        while (cur != null) {
            inside = inside + " " + cur.data.toString();
            cur = cur.next;
        }
        return "[" + inside.trim() + "]";
    }

    public <R> LList<R> map( IFunc<T,R> obj ) {
        ListNode<T> cur = this.head;
        LList<R> result = new LList<R>();
        while (cur != null) {
            result.addToEnd( obj.apply(cur.data) );
            cur = cur.next;
        }
        return result;
    }

    public LList<T> filter( IPred<T> obj ) {
        ListNode<T> cur = this.head;
        LList<T> result = new LList<T>();
        while (cur != null ) {
            if (obj.satisfiedBy(cur.data)) {
                result.addToEnd( cur.data );
            }
            cur = cur.next;
        }
        return result;
        /*
        public LList<String> allNames() {
        ListNode<Student> cur = (ListNode<Student>) head;
        LList<String> result = new LList<String>();
        while (cur != null) {
        result.addToEnd( cur.data.getName() );
        cur = cur.next;
        }
        return result;
        }

        public LList<Double> normalizedGPAs() {
        ListNode<Student> cur = (ListNode<Student>) head;
        LList<Double> result = new LList<Double>();
        while (cur != null) {
        result.addToEnd( cur.data.normalizeGPA() );
        cur = cur.next;
        }
        return result;
        }

   
        public LList<String> allSubjects() {
        ListNode<Fact> cur = (ListNode<Fact>) head;
        LList<String> result = new LList<String>();
        while (cur != null) {
        result.addToEnd( cur.data.getSubject() );
        cur = cur.next;
        }
        return result;
        }
         */

    }
}