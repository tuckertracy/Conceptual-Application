
/**
 * Write a description of class StudentGPAUpdater here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
public class StudentGPAUpdater implements IFunc<Student,Student>
{
    private double from;
    private double to;
    
    StudentGPAUpdater(double from, double to) {
        this.from = from;
        this.to = to;
    }
    
    public Student apply(Student s) {
        return s.normalizeGPA( from, to );
    }
}
