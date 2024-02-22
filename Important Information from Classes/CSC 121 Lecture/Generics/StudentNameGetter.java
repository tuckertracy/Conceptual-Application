
/**
 * Write a description of class StudentNameGetter here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
public class StudentNameGetter implements IFunc<Student,String>
{
    public String apply(Student data) {
        return data.getName();
    }
}
