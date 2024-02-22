
/**
 * Write a description of class SingleWordRelation here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
public class SingleWordRelation implements IPred<Fact> {
    public boolean satisfiedBy(Fact obj) {
        return !obj.getRelation().contains(" ");
    }
}