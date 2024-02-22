interface IBook {
    int daysOverdue(int today);
    boolean isOverdue(int today);
    int computeFine(int today);
}

abstract class ABook implements IBook{
    String title;
    int dayTaken;
    int rentTime; // the number of days a book can be out
    int fee;

    ABook(String title, int dayTaken, int rentTime, int fee) {
        this.title = title;
        this.dayTaken = dayTaken;
        this.rentTime = rentTime;
        this.fee = fee;
    }
    
    public int daysOverdue(int today) {
        return today - this.dayTaken - this.rentTime;
    }
    
    public boolean isOverdue(int today) {
        return today > this.dayTaken + this.rentTime;
    }
    
    public int computeFine(int today) {
        if (this.daysOverdue(today) < 0) {
            return 0;
        } else {
            return this.daysOverdue(today) * this.fee;
        }
    }
}

class Book extends ABook {
    String author;

    Book(String title, String author, int dayTaken) {
        super(title, dayTaken, 14, 10);
        this.author = author;
    }
}

class RefBook extends ABook {
    RefBook(String title, int dayTaken) {
        super(title, dayTaken, 2, 10);
    }
}

class AudioBook extends ABook {
    String author;
    int runTime;    // minutes

    AudioBook(String title, String author, int dayTaken, int runTime) {
        super(title, dayTaken, 14, 20);
        this.author = author;
        this.runTime = runTime;
    }
}