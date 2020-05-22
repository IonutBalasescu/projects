import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.LinkedBlockingDeque;

/**
 * Class that implements the channel used by headquarters and space explorers to communicate.
 */
public class CommunicationChannel {

	BlockingQueue<Message> exp = new LinkedBlockingDeque<Message>();
	ConcurrentHashMap<Long,Message> hq = new ConcurrentHashMap<Long, Message>();
	List<Long> list = new ArrayList<>();

	/**
	 * Creates a {@code CommunicationChannel} object.
	 */
	public CommunicationChannel() {
	}

	/**
	 * Puts a message on the space explorer channel (i.e., where space explorers write to and 
	 * headquarters read from).
	 * 
	 * @param message
	 *            message to be put on the channel
	 */
	public void putMessageSpaceExplorerChannel(Message message) {
		if (message.getData().equals(HeadQuarter.END) || message.getData().equals(HeadQuarter.EXIT))
			return;
            try {
                exp.put(message);
            } catch (InterruptedException e) { }
	}

	/**
	 * Gets a message from the space explorer channel (i.e., where space explorers write to and
	 * headquarters read from).
	 * 
	 * @return message from the space explorer channel
	 */
	public Message getMessageSpaceExplorerChannel() {

		Message mess1 = null;
            try {
                mess1 = exp.take();
            } catch (InterruptedException ex) { }
            return mess1;
	}

	/**
	 * Puts a message on the headquarters channel (i.e., where headquarters write to and 
	 * space explorers read from).
	 * 
	 * @param message
	 *            message to be put on the channel
	 */
	public synchronized void putMessageHeadQuarterChannel(Message message) {
		if (message.getData().equals(HeadQuarter.END) || message.getData().equals(HeadQuarter.EXIT))
			return;
		if(hq.putIfAbsent(Thread.currentThread().getId(), message) != null){	//pun id ul unui thread de la federatie ca si cheie
			hq.put(Thread.currentThread().getId(), message);
		}
		synchronized (list) {
			list.add(Thread.currentThread().getId());
		}
	}

	/**
	 * Gets a message from the headquarters channel (i.e., where headquarters write to and
	 * space explorer read from).
	 * 
	 * @return message from the header quarter channel
	 */
	public synchronized Message getMessageHeadQuarterChannel() {
		//daca e primul sau al doilea mesaj
		//daca e al doilea se verifica daca e alt thread care incearca sa ia

		Message mess2 = null;
		if (list.size() > 0) {
			mess2 = hq.get(list.get(0));
			if (mess2 != null) {
				hq.remove(list.get(0), mess2);
				System.out.println("done!");
			}

		}
		return mess2;
	}
}
