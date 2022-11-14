import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;

import org.bson.*;

public class MongoDb {
	public static void main(String[] args) {

		// Create a mongo client instance
		MongoClientURI uri = new MongoClientURI("mongodb://127.0.0.1:27017");
		MongoClient mongoClient = new MongoClient(uri);

		MongoDatabase database = mongoClient.getDatabase("myDb");

		// If collection is already present gives error
		database.createCollection("test");

		for (String name : database.listCollectionNames()) {
			System.out.println(name);
		}

		MongoCollection collection = database.getCollection("test");

		// Read
		FindIterable itf = collection.find();

		MongoCursor it = itf.iterator();

		while (it.hasNext()) {
			System.out.println(it.next());
		}

		// Create
		Document doc = new Document("name", "Tanmya").append("age", 18);
		collection.insertOne(doc);

		// Update
		collection.updateOne(Filters.eq("name", "Rohan"), Updates.set("age", 21));

		// Delete
		collection.deleteMany(Filters.and(Filters.eq("name", "Tanmya"), Filters.eq("age", 18)));

	}
}
