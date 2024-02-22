
public class Fact {
    private String nounA;
    private String relation;
    private String nounB;

    public Fact( String nA, String rel, String nB ) {
        nounA = nA;
        relation = rel;
        nounB = nB;
    }

    public String getSubject() {
        return nounA;
    }

    public String getRelation() {
        return relation;
    }
}
