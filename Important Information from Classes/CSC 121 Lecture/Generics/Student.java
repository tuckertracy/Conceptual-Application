

public class Student {
  private String name;
  private double gpa;
  
  public Student(String name, double gpa) {
    this.name = name;
    this.gpa = gpa;
  }
  
  public boolean hasName(String n) {
    return this.name.equals(n);
  }

  public String getName() {
    return name;
  }
  
  
  /* 
   * Converts GPA from (assumed) 4.0 scale to 4.5 scale
   */
  public double normalizeGPA() {
      return 4.5 * (gpa / 4.0);
  }

  
  // advanced example - function objects with parameters as fields 
  public Student normalizeGPA(double previousMax, double newMax) {
    return new Student(name, newMax * (gpa / previousMax));
  }
}
