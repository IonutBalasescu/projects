package players;

import assets.Assets;
import java.util.ArrayList;

public class BasicPlayer {

    private ArrayList<Assets> handCards;
    private boolean sheriffStatus;
    private int score;
    private int noOfCards;
    private int noOfCardsInBag;
    private ArrayList<Assets> bagCards;
    private int bribe;
    private ArrayList<Assets> merchantTable;
    private Assets statement;
    private String type;

    public BasicPlayer() {
        final int s = 50;
        this.noOfCards = 0;
        this.noOfCardsInBag = 0;
        this.sheriffStatus = false;
        this.score = s;
        this.handCards = new ArrayList<>();
        this.bagCards = new ArrayList<>();
        this.statement = new Assets();
        this.merchantTable = new ArrayList<>();

    }

    public final int getScore() {
        return this.score;
    }

    public int getNoOfCards() {
        return this.noOfCards;
    }

    public final boolean getSheriffStatus() {
        return this.sheriffStatus;
    }

    public ArrayList<Assets> getHandCards() {
        return this.handCards;
    }

    public final ArrayList<Assets> getBagCards() {
        return this.bagCards;
    }

    public  int getBribe() {
        return this.bribe;
    }

    public final ArrayList<Assets> getBag() {
        return this.bagCards;
    }

    public final Assets getStatement() {
        return this.statement;
    }

    public final String getType() {
        return this.type;
    }

    public final void setNoOfCardsInBag(final int nr) {
        this.noOfCardsInBag = nr;
    }

    public int getNoOfCardsInBag() {
        return this.noOfCardsInBag;
    }

    public void setScore(final int score) {
        this.score = score;
    }

    public final void setSheriffStatus(final boolean sheriffStatus) {
        this.sheriffStatus = sheriffStatus;
    }

    public final void setHandCards(final ArrayList<Assets> handCards) {
        this.handCards = handCards;
    }

    public void setBribe(final int bribe) {
        this.bribe = bribe;
    }

    public final void setNoOfCards(final int noOfCards) {
        this.noOfCards = noOfCards;
    }

    public final void setBagCards(final ArrayList<Assets> list) {
        this.bagCards = list;
    }

    public void addCardsToBag(final Assets asset) {

        this.bagCards.add(asset);
        (this.noOfCardsInBag)++;
    }

    public final void removeCardsFromBag(final int idx) {
        this.bagCards.remove(idx);
        (this.noOfCardsInBag)--;
    }

    public void removeCardsFromHand(final int idx) {
        this.handCards.remove(idx);
        (this.noOfCards)--;
    }

    public void setStatement(final Assets statement) {
        this.statement = statement;
    }

    public final void setType(final String type) {
        this.type = type;
    }

    /**
     * pun toate bunurile din sac pe taraba
     *  + bonusurile de ilegale
     */
    public final void fillMerchantTable() {
        final int maxNoOfCards = 6;
        for (int i = 0; i < this.noOfCardsInBag; i++) {
            this.merchantTable.add(this.bagCards.get(i));

            if (!this.bagCards.get(i).getLegal()) {
                ArrayList<Assets> bonuses;
                bonuses = this.bagCards.get(i).getBonus();
                for (Assets asset1 : bonuses) {
                    this.merchantTable.add(asset1);

                }
            }
        }
        if (noOfCardsInBag != 0) {
            this.bagCards.removeAll(this.bagCards);
        }
        this.noOfCardsInBag = 0;
    }

    public final ArrayList<Assets> getMerchantTable() {
        return this.merchantTable;
    }

    /**
     *restabliesc numarul de carti din mana : implicit 6 la fiecare runda
     */

    public final ArrayList<Assets> fillHandCards(final ArrayList<Assets> cards) {
        final int maxNoOfCards = 6;
        for (int i = this.noOfCards; i < maxNoOfCards; i++) {
            this.handCards.add(cards.get(0));
            cards.remove(0);
        }
        this.noOfCards = maxNoOfCards;
        return cards;
    }

    /**
     *extrage o lista de bunuri iegale/ilegale
     *se foloseste pentru toate cele 3 strategii de comercianti
     */

    public ArrayList<Assets> extractSublist(final boolean legal) {
        ArrayList<Assets> sublist = new ArrayList<>();
        sublist.removeAll(sublist);
        boolean legal1;
        boolean legals;
        for (Assets temp : this.handCards) {
            legal1 = temp.getLegal();
            legals = legal1 == legal;
            if (legals) {
                sublist.add(temp);
            }
        }
        return sublist;
    }

    /**
     * Va fi folosita doar in cazul in care se stie ca exista
     * bunuri ilegale in mana si va lua bunul cu cel mai mare profit
     */

    public void basicIllegalStrategy() {
        int idx = -1;
        int maxProfit = 0;
        Assets asset = new Assets(0);
        for (int i = 0; i < this.noOfCards; i++) {
            if (maxProfit < this.handCards.get(i).getProfit()) {
                idx = i;
                maxProfit = this.handCards.get(i).getProfit();
            }
        }
        this.bagCards.add(this.handCards.get(idx));
        (this.noOfCardsInBag)++;
        this.handCards.remove(idx);
        (this.noOfCards)--;
    }

    /**
     *Va adauga in sac bunurile cu cea mai mare frecventa
     * Doar bunuri legale, conform strategiei de baza
     */

    public void basicLegalStrategy(final ArrayList<Assets> sublist) {

        int size = sublist.size();
        final int maxNoOfAssets = 5;
        if (size > 1) {
            int[] frequency = new int[size];
            Assets temp, temp1;
            for (int i = 0; i < size - 1; i++) {
                frequency[i] = 1;
                temp = sublist.get(i);
                for (int j = i + 1; j < size; j++) {
                    temp1 = sublist.get(j);
                    if (temp.getId() == temp1.getId()) {
                        (frequency[i])++;
                    }
                }
            }
            int maxFrequency = 0;
            int idx = -1;
            for (int i = 0; i < size; i++) {
                if (maxFrequency < frequency[i]) {
                    maxFrequency = frequency[i];
                    idx = i;
                } else if (maxFrequency == frequency[i]) {
                    if (sublist.get(i).getProfit() > sublist.get(idx).getProfit()) {
                        maxFrequency = frequency[i];
                        idx = i;
                    }
                }
            }
            int limits = this.noOfCards;
            if (maxFrequency > maxNoOfAssets) {
                --limits;
            }
            this.statement = sublist.get(idx);
            for (int i = 0; i < limits; i++) {
                if (this.handCards.get(i).getId() == this.statement.getId()) {
                    this.bagCards.add(handCards.get(i));
                    (this.noOfCardsInBag)++;
                    this.handCards.remove(i);
                    (this.noOfCards)--;
                    i--;
                    limits--;
                }
            }
        } else if (size == 1) {
            this.bagCards.add(sublist.get(0));
            (this.noOfCardsInBag)++;
            this.statement = sublist.get(0);
            this.handCards.remove(sublist.get(0));
            (this.noOfCards)--;
        }
    }

    /**
     * va aplica metodele precendete dupa ce face niste verificari
     * este metoda superclasei si va fi apelata de subclase la nevoie
     */

    public void merchantStrategy() {
        boolean legal = true;
        ArrayList<Assets> sublist = new ArrayList<>();
        sublist.removeAll(sublist);
        sublist = extractSublist(legal);
        int size = sublist.size();
        if (size == 0) {
            int appleId = 0;
            this.basicIllegalStrategy();
            Assets asset = new Assets(appleId);
            this.statement = asset;
        } else {
            this.basicLegalStrategy(sublist);
        }
    }

    /**
     *Metoda superclasei care are ca scop sa respinga mita
     * si sa taxeze mincinosii
     */

    public ArrayList<Assets> sheriffCheckBag(final BasicPlayer b, final ArrayList<Assets> cards) {
        int sheriffPenalty = 0;
        int merchantPenalty = 0;
        int id1 = b.statement.getId(), id2;
        boolean fraud = false;
        for (int i = 0; i < b.noOfCardsInBag; i++) {
            id2 = b.bagCards.get(i).getId();
            if (id1 != id2) {
                sheriffPenalty = 0;
                merchantPenalty += b.bagCards.get(i).getPenalty();
                cards.add(b.bagCards.get(i));
                b.bagCards.remove(i);
                i--;
                fraud = true;
                (b.noOfCardsInBag)--;
            }
            if (!fraud) {
                sheriffPenalty += b.bagCards.get(i).getPenalty();
            }
        }

        this.setScore(this.getScore() + merchantPenalty - sheriffPenalty);
        b.setScore(b.getScore() - merchantPenalty + sheriffPenalty);
        b.bribe = 0;
        return cards;

    }

    /**
     *se da bonus de queen (bonusType = 0)
     * sau de king (bonusType = 1)
     */

    public void setBonus(final int bonusType, final int id) {
        final int[] appleBonus = {10, 20};
        final int[] cheeseBonus = {10, 15};
        final int[] breadBonus = {10, 15};
        final int[] chickenBonus = {5, 10};
        final int appleId = 0, cheeseId = 1, breadId = 2, chickenId = 3;
        switch (id) {
            case appleId:
                this.score += appleBonus[bonusType];
                break;
            case cheeseId:
                this.score += cheeseBonus[bonusType];
                break;
            case breadId:
                this.score += breadBonus[bonusType];
                break;
            case chickenId:
                this.score += chickenBonus[bonusType];
                break;
            default:
                break;
        }
    }

    /**
     * Adauga profitul bunurilor de pe taraba
     */
    public final void sellAssets() {
        for (Assets asset : this.merchantTable) {
            this.score +=  asset.getProfit();
        }
    }

    /**
     *construieste vectorii de frecventa
     */
    public final int[] getLegalFrequency(final int[] ids) {
        final int noOfBonuses = 4;
        int[] frequency = new int[noOfBonuses];

        for (int i = 0; i < noOfBonuses; i++) {
            for (int j = 0; j < this.merchantTable.size(); j++) {
                if (this.merchantTable.get(j).getId() == ids[i]) {
                    frequency[i]++;
                }
            }
        }
        return frequency;
    }
}
