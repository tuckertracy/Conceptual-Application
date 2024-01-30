
/**
 * Operations required for implementing a page history
 * mechanism for a web browser. Every implementation should
 * provide an initial current page named "Home", which should
 * thereafter always be accessible by going all the way back
 * in the history.
 *
 */
public interface IPageTracker {
  
  /**
   * Produces the name/URL of the current page
   */
  public String currentPage();
  
  /**
   * Produces the name/URL of the page that results from going back
   * n steps in the history. This should never go earlier than the 
   * initial "Home" page. If n <= 0, do nothing.
   * @param n number of steps to go back in the history
   * @return the name/URL of the current page after going back
   */
  public String goBack(int n);
  
  /**
   * Produces the name/URL of the page that results from going forward
   * n steps in the history. If n <= 0, or if there are no 
   * pages forward in the history, do nothing.
   * @param n number of steps to go forward in the history
   * @return the name/URL of the current page after going forward
   */
  public String goForward(int n);
  
  /**
   * Make the current page be the given page name/URL. This should
   * cause the current page just before the operation become the
   * one that would be accessed by  goBack(1), and it should also
   * clear out the forward history.
   */
  public void visit(String pageName);
  
  /**
   * Clear out both the backward and forward history, returning the
   * current page to "Home".
   */
  public void clear();
}