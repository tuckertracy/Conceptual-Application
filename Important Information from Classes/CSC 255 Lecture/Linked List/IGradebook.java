
/**
 * A general interface for implementations of a gradebook
 */
public interface IGradebook {
  /** Returns the number of grades in this book */
  int count();

  /** Updates the list of grades in this book by adding the given grade */
  void addGrade(int g);

  /** Produces the average grade of all added grades */
  double average();
  
  /** Produces the highest grade */
  int bestGrade();
}
