import { MongoClient, ServerApiVersion, ObjectId } from 'mongodb';
import { OSRM, IOsrmWaypoint } from 'osrm-rest-client';

const uri = "mongodb+srv://golkhandani:PRF8HkWLhIojSCtw@cluster0.pnixghy.mongodb.net/?retryWrites=true&w=majority";
// Create a MongoClient with a MongoClientOptions object to set the Stable API version
const client = new MongoClient(uri, {
    serverApi: {
        version: ServerApiVersion.v1,
        strict: true,
        deprecationErrors: true,
    }
});

const osrm = OSRM({
    defaultProfile: 'foot'
});

async function run() {

    try {
        // Connect the client to the server	(optional starting in v4.7)
        await client.connect();
        // Send a ping to confirm a successful connection
        await client.db("admin").command({ ping: 1 });
        console.log("Pinged your deployment. You successfully connected to MongoDB!");

        let db = client.db("revice_explorer");




        await db.collection('category_items').insertMany([
            {
                "_id": new ObjectId("5f68b45a805e2f36f4b3e1a1"),
                "title": "Totem Pole",
                "subtitle": "Native American Art",
                "description": "A traditional Native American art form consisting of tall wooden sculptures.",
                "imageUrl": "https://unsplash.com/photos/u-ONlzZ38nU/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8Mnx8bXVyYWx8ZW58MHx8fHwxNjk0ODU4MDI1fDA&force=true&w=640"
            },
            {
                "_id": new ObjectId("5f68b45a805e2f36f4b3e1a2"),
                "title": "Socially Engaged Art",
                "subtitle": "Contemporary Art",
                "description": "Artwork that is created in collaboration with a community or addresses social issues.",
                "imageUrl": "https://unsplash.com/photos/u-ONlzZ38nU/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8Mnx8bXVyYWx8ZW58MHx8fHwxNjk0ODU4MDI1fDA&force=true&w=640"
            },
            {
                "_id": new ObjectId("5f68b45a805e2f36f4b3e1a3"),
                "title": "Mosaic",
                "subtitle": "Visual Art",
                "description": "A form of art where small pieces of material are assembled to create a larger image or pattern.",
                "imageUrl": "https://unsplash.com/photos/u-ONlzZ38nU/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8Mnx8bXVyYWx8ZW58MHx8fHwxNjk0ODU8MDUyfDA&force=true&w=640"
            },
            {
                "_id": new ObjectId("5f68b45a805e2f36f4b3e1a4"),
                "title": "Welcome Figure",
                "subtitle": "Cultural Art",
                "description": "Artwork traditionally placed at the entrance of a community to welcome visitors.",
                "imageUrl": "https://unsplash.com/photos/u-ONlzZ38nU/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8Mnx8bXVyYWx8ZW58MHx8fHwxNjk0ODU8MDUyfDA&force=true&w=640"
            },
            {
                "_id": new ObjectId("5f68b45a805e2f36f4b3e1a5"),
                "title": "Other",
                "subtitle": "Various Art Forms",
                "description": "Artworks that do not fit into specific categories.",
                "imageUrl": "https://unsplash.com/photos/u-ONlzZ38nU/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8Mnx8bXVyYWx8ZW58MHx8fHwxNjk0ODU8MDUyfDA&force=true&w=640"
            },
            {
                "_id": new ObjectId("5f68b45a805e2f36f4b3e1a6"),
                "title": "Site-Integrated Work",
                "subtitle": "Public Art",
                "description": "Artwork that is designed to be integrated into a specific location or site.",
                "imageUrl": "https://unsplash.com/photos/u-ONlzZ38nU/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8Mnx8bXVyYWx8ZW58MHx8fHwxNjk0ODU8MDUyfDA&force=true&w=640"
            },
            {
                "_id": new ObjectId("5f68b45a805e2f36f4b3e1a7"),
                "title": "Two-Dimensional Artwork",
                "subtitle": "Visual Art",
                "description": "Artwork that is flat and two-dimensional, such as paintings or drawings.",
                "imageUrl": "https://unsplash.com/photos/u-ONlzZ38nU/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8Mnx8bXVyYWx8ZW58MHx8fHwxNjk0ODU8MDUyfDA&force=true&w=640"
            },
            {
                "_id": new ObjectId("5f68b45a805e2f36f4b3e1a8"),
                "title": "Sculpture",
                "subtitle": "Visual Art",
                "description": "Three-dimensional art created by shaping or carving materials.",
                "imageUrl": "https://unsplash.com/photos/u-ONlzZ38nU/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8Mnx8bXVyYWx8ZW58MHx8fHwxNjk0ODU8MDUyfDA&force=true&w=640"
            },
            {
                "_id": new ObjectId("5f68b45a805e2f36f4b3e1a9"),
                "title": "Figurative Art",
                "subtitle": "Visual Art",
                "description": "Artwork that represents the human or animal form.",
                "imageUrl": "https://unsplash.com/photos/u-ONlzZ38nU/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8Mnx8bXVyYWx8ZW58MHx8fHwxNjk0ODU8MDUyfDA&force=true&w=640"
            },
            {
                "_id": new ObjectId("5f68b45a805e2f36f4b3e1aa"),
                "title": "Media Work",
                "subtitle": "Contemporary Art",
                "description": "Artwork that utilizes various forms of media and technology.",
                "imageUrl": "https://unsplash.com/photos/u-ONlzZ38nU/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8Mnx8bXVyYWx8ZW58MHx8fHwxNjk0ODU8MDUyfDA&force=true&w=640"
            },
            {
                "_id": new ObjectId("5f68b45a805e2f36f4b3e1ab"),
                "title": "Fountain or Water Feature",
                "subtitle": "Public Art",
                "description": "Artwork that incorporates water elements, often found in public spaces.",
                "imageUrl": "https://unsplash.com/photos/u-ONlzZ38nU/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8Mnx8bXVyYWx8ZW58MHx8fHwxNjk0ODU8MDUyfDA&force=true&w=640"
            },
            {
                "_id": new ObjectId("5f68b45a805e2f36f4b3e1ac"),
                "title": "Memorial or Monument",
                "subtitle": "Public Art",
                "description": "Artwork created to commemorate a person, event, or concept.",
                "imageUrl": "https://unsplash.com/photos/u-ONlzZ38nU/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8Mnx8bXVyYWx8ZW58MHx8fHwxNjk0ODU8MDUyfDA&force=true&w=640"
            },
            {
                "_id": new ObjectId("5f68b45a805e2f36f4b3e1ad"),
                "title": "Mural",
                "subtitle": "Visual Art",
                "description": "Artwork painted or applied directly to a wall or surface.",
                "imageUrl": "https://unsplash.com/photos/u-ONlzZ38nU/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8Mnx8bXVyYWx8ZW58MHx8fHwxNjk0ODU8MDUyfDA&force=true&w=640"
            },
            {
                "_id": new ObjectId("5f68b45a805e2f36f4b3e1ae"),
                "title": "Gateway",
                "subtitle": "Architectural Art",
                "description": "Artistic structures or entrances that mark a transition or entrance point.",
                "imageUrl": "https://unsplash.com/photos/u-ONlzZ38nU/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8Mnx8bXVyYWx8ZW58MHx8fHwxNjk0ODU8MDUyfDA&force=true&w=640"
            },
            {
                "_id": new ObjectId("5f68b45a805e2f36f4b3e1af"),
                "title": "Relief",
                "subtitle": "Sculptural Art",
                "description": "Sculpture that is raised from a flat background, often seen on walls or panels.",
                "imageUrl": "https://unsplash.com/photos/u-ONlzZ38nU/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8Mnx8bXVyYWx8ZW58MHx8fHwxNjk0ODU8MDUyfDA&force=true&w=640"
            }
        ])






    } finally {
        // Ensures that the client will close when you finish/error
        await client.close();
    }
}



run().catch(console.dir);