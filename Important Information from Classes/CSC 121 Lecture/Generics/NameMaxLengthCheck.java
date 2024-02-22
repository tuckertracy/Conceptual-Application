
/**
 * Write a description of class NameMaxLengthCheck here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
public class NameMaxLengthCheck implements IPred<Student>
{
    // instance variables - replace the example below with your own
    private int max;

    NameMaxLengthCheck(int max) {
        this.max = max;
    }

    public boolean satisfiedBy(Student obj) {
        return obj.getName().length() <= max;
    }
}
