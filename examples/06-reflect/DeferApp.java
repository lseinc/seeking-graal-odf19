

public class DeferApp {

	public static void main(String[] args) throws Exception {
		System.out.println("starting defer app...");
		Class clazz = Class.forName("DeferLoad");
		System.out.println("defer class loaded:  "+clazz);
		DeferInterface defer = (DeferInterface) clazz.newInstance();
		System.out.println("defer interface created: "+defer);

		String message = defer.fetchMessage();
		System.out.println("defer message="+message);
		System.out.println("ending defer app!");
	}
}

