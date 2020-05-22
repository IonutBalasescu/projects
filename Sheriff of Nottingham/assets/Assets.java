package assets;

import java.util.ArrayList;

public class Assets {
    private int id;
    private boolean legal;
    private int profit;
    private int penalty;
    private ArrayList<Assets> bonus;

    public Assets() { }

    public Assets(final int id) {

        this.id = id;
        final int legalPenalty = 2, illegalPenalty = 4;
        final int appleId = 0, appleProfit = 2;
        final int cheeseId = 1, cheeseProfit = 3;
        final int breadId = 2, breadProfit = 4;
        final int chickenId = 3, chickenProfit = 4;
        final int silkId = 10, silkProfit = 9;
        final int pepperId = 11, pepperProfit = 8;
        final int barrelId = 12, barrelProfit = 7;
        final int silkBonuses = 3, pepperBonuses = 2, barrelBonuses = 2;

        if (id == appleId) {
            this.legal = true;
            this.profit = appleProfit;
            this.penalty = legalPenalty;
        } else if (id == breadId) {
            this.legal = true;
            this.profit = breadProfit;
            this.penalty = legalPenalty;
        } else if (id == cheeseId) {
            this.legal = true;
            this.profit = cheeseProfit;
            this.penalty = legalPenalty;
        } else if (id == chickenId) {
            this.legal = true;
            this.profit = chickenProfit;
            this.penalty = legalPenalty;
        } else if (id == silkId) {
            this.legal = false;
            this.profit = silkProfit;
            this.penalty = illegalPenalty;

            this.bonus = new ArrayList<>();
            Assets asset = new Assets(cheeseId);
            for (int i = 0; i < silkBonuses; i++) {
               // System.out.println("silk");
                this.bonus.add(asset);
            }
        } else if (id == pepperId) {
            this.legal = false;
            this.profit = pepperProfit;
            this.penalty = illegalPenalty;

            this.bonus = new ArrayList<>();
            Assets asset = new Assets(chickenId);
            for (int i = 0; i < pepperBonuses; i++) {
                this.bonus.add(asset);
            }
        } else if (id == barrelId) {
            this.legal = false;
            this.profit = barrelProfit;
            this.penalty = illegalPenalty;
            this.bonus = new ArrayList<>();
            Assets asset = new Assets(breadId);

            for (int i = 0; i < barrelBonuses; i++) {
                this.bonus.add(asset);
            }
        }
    }
    public final int getId() {
        return this.id;
    }

    public final int getProfit() {
        return this.profit;
    }

    public final int getPenalty() {
        return this.penalty;
    }

    public final boolean getLegal() {
        return this.legal;
    }

    public final ArrayList<Assets> getBonus() {
        return this.bonus;
    }
}
