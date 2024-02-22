import static org.junit.Assert.*;
import org.junit.Test;

public class LListTest {

    @Test
    public void test() {
        // facts.subjectNames() ===> [ "plants", "cars", "rabbits" ]
        // stus.firstNames() ===> [ "Alice", "Bob", "Chan", "Dee" ]

        LList<Fact> facts = new LList<Fact>();
        facts.addToFront(new Fact("plants", "need", "the sun"));
        facts.addToFront(new Fact("cars", "run on", "fuel"));
        facts.addToFront(new Fact("rabbits", "like", "carrots"));
        assertEquals(3, facts.length());

        LList<Student> stus = new LList<Student>();
        stus.addToFront(new Student("Alice", 3.75));
        stus.addToFront(new Student("Bob", 3.2));
        stus.addToFront(new Student("Chan", 2.8));
        stus.addToFront(new Student("Dee", 3.54));
        assertEquals(4, stus.length());

        LList<String> names = stus.map( new StudentNameGetter() );
        LList<String> things = facts.map( new FactSubjectGetter() );
        LList<Double> gpas = stus.map( new StudentGPANormalizer() );

        LList<Student> adjusted = stus.map( new StudentGPAUpdater(4.0,5.0) ); // 4.0 -> 5.0
        LList<Student> adjustedBack = adjusted.map( new StudentGPAUpdater(5.0,4.0) ); // 5.0 -> 4.0

        assertEquals("[Dee Chan Bob Alice]", names.toString());
        assertEquals("[3.9825 3.15 3.6 4.21875]", gpas.toString());

        assertEquals("[rabbits cars plants]", things.toString());

        // LList<String> names = stus.map( toName );
        // LList<String> things = facts.map( nounA );

        /*
         * LList<String> names = stus.map(new StudentNameFunction());
         * assertEquals("[Dee Chan Bob Alice]", names.toString());
         * 
         * LList<String> things = facts.map(new FactSubjectFunction());
         * assertEquals("[rabbits cars plants]", things.toString());
         */

        LList<Fact> facts0 = new LList<Fact>();
        facts0.addToFront(new Fact("plants", "need", "the sun"));
        facts0.addToFront(new Fact("cars", "run on", "fuel"));
        facts0.addToFront(new Fact("rabbits", "like", "carrots"));

        LList<Fact> filteredFacts = facts0.filter(new SingleWordRelation());
        assertEquals("[rabbits plants]", filteredFacts.map(new FactSubjectGetter()).toString());

        LList<Student> stus0 = new LList<Student>();
        stus0.addToFront(new Student("Alice", 3.75));
        stus0.addToFront(new Student("Bob", 3.2));
        stus0.addToFront(new Student("Chan", 2.8));
        stus0.addToFront(new Student("Desire", 3.54));

        LList<Student> filteredStus = stus0.filter(new NameMaxLengthCheck(4));
        assertEquals("[Chan Bob]", filteredStus.map(new StudentNameGetter()).toString());
    }

}

/*
idea:
class StudentFunction {
public String apply(Student s) { ... }
}

class FactFunction {
public String apply(Fact f) { ... }
}
 */

