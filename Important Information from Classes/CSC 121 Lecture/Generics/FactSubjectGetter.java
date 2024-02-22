
/**
 * Write a description of class FactSubjectGetter here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
public class FactSubjectGetter implements IFunc<Fact,String>
{
    public String apply(Fact f) {
        return f.getSubject();
    }
}
