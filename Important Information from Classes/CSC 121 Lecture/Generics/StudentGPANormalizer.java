
/**
 * Write a description of class StudentGPANormalizer here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
public class StudentGPANormalizer implements IFunc<Student,Double>
{
    public Double apply(Student s) {
        return s.normalizeGPA();
    }
}
