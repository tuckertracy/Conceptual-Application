
/**
 * Write a description of class Tracker here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
public class Tracker implements IPageTracker
{
    // instance variables - replace the example below with your own
    private LeakyStack<String> back;
    private LeakyStack<String> forward;

    public Tracker(int capacity) {
        this.back = new LeakyStack<String> (capacity + 1);
        this.forward = new LeakyStack<String> (capacity);
    }

    /**
     * Produces the name/URL of the current page
     */
    public String currentPage() {
        if ( this.back.isEmpty() ) {
            this.back.push("Home");
        }
        return this.back.peek();
    }

    /**
     * Produces the name/URL of the page that results from going back
     * n steps in the history. This should never go earlier than the 
     * initial "Home" page. If n <= 0, do nothing.
     * @param n number of steps to go back in the history
     * @return the name/URL of the current page after going back
     */
    public String goBack(int n) {
        if ( n <= 0 ) {

        }

        for ( ; n > 0 && !this.back.isEmpty() ; n--) {
            String s = this.back.pop();
            if (!s.equals("Home")) {
                this.forward.push(s);
            }
        }

        return currentPage();
    }

    /**
     * Produces the name/URL of the page that results from going forward
     * n steps in the history. If n <= 0, or if there are no 
     * pages forward in the history, do nothing.
     * @param n number of steps to go forward in the history
     * @return the name/URL of the current page after going forward
     */
    public String goForward(int n) {
        if ( n <= 0 || forward.isEmpty()) {

        }

        for ( n = n; n > 0 ; n--) {
            this.back.push(this.forward.pop());
        } 

        return this.back.peek();
    }

    /**
     * Make the current page be the given page name/URL. This should
     * cause the current page just before the operation become the
     * one that would be accessed by  goBack(1), and it should also
     * clear out the forward history.
     */
    public void visit(String pageName) {
        this.back.push(pageName);
        this.forward.clear();
    }

    /**
     * Clear out both the backward and forward history, returning the
     * current page to "Home".
     */
    public void clear() {
       this.back.clear();
       this.forward.clear();
    }
}
