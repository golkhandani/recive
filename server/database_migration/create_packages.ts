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

        let count = await db.collection('art_items').countDocuments();

        let proccessedIds: ObjectId[] = [];

        do {


            let result = await db.collection('art_items').findOne({ _id: { $nin: proccessedIds } });
            let venue = await db.collection('venue_items').findOne({ _id: result!.location.venue });
            proccessedIds.push(result!._id);


            let items = await db.collection('art_items').aggregate([
                {
                    $geoNear: {
                        near: { type: 'Point', coordinates: result!.location.geolocation.coordinates },
                        distanceField: 'distance',
                        maxDistance: 200,
                        query: { _id: { $nin: proccessedIds } },
                        spherical: true
                    }
                },
                {
                    $limit: 4
                },
                {
                    $lookup: {
                        from: 'venue_items',
                        localField: 'location.venue',
                        foreignField: '_id',
                        as: 'location.venue'
                    }
                },
                { $unwind: { path: '$location.venue' } }
            ]).toArray();

            console.log(`ITEM COUNT ${items.length}`);

            if (items.length <= 1) {
                items = await db.collection('art_items').aggregate([
                    {
                        $geoNear: {
                            near: { type: 'Point', coordinates: result!.location.geolocation.coordinates },
                            distanceField: 'distance',
                            maxDistance: 10000,
                            query: { _id: { $nin: proccessedIds } },
                            spherical: true
                        }
                    },
                    {
                        $limit: 2
                    },
                    {
                        $lookup: {
                            from: 'venue_items',
                            localField: 'location.venue',
                            foreignField: '_id',
                            as: 'location.venue'
                        }
                    },
                    { $unwind: { path: '$location.venue' } }
                ]).toArray();


                console.log(`RE ITEM COUNT ${items.length}`);
            }



            let firstItem = {
                ...result,
                location: {
                    geolocation: result!.location.geolocation,
                    venue: venue
                }
            }
            //  console.log(firstItem);
            items = [firstItem!, ...items];



            let title = `From ${items[0].location.venue.address.localizedAddressDisplay?.split(',')[0] ?? items[0].location.venue.title ?? items[0].title ?? 'Van'}` +
                ` to ${items[items.length - 1].location.venue.address.localizedAddressDisplay?.split(',')[0] ?? items[0].location.venue.title ?? items[0].title ?? 'Van'}`;
            let packageItem: any = {
                "_id": new ObjectId(),
                "title": title,
                "description": 'Visit ',
                "images": [],
                "art_types": [],
                "tags": [],
                'arts': [],
                'points_geo_locations': []
            };


            for (const item of items) {
                proccessedIds.push(item._id);
                packageItem.description += item._id == items[0]._id ? item.title : ' and ' + item.title;
                packageItem.images = packageItem.images.concat(...item.images);
                packageItem.art_types = Array.from(new Set([...packageItem.art_types, item.art_type]));
                packageItem.tags = Array.from(new Set([...packageItem.tags, ...item.tags]));
                packageItem.arts = Array.from(new Set([...packageItem.arts, item._id]));
                packageItem.points_geo_locations = Array.from(new Set([...packageItem.points_geo_locations, item.location.geolocation]));
            }

            let cord = packageItem.points_geo_locations.map((geo) => geo.coordinates);

            const osrmResponse = await osrm.route({
                coordinates: cord,
                steps: true,
                alternatives: false,
                overview: 'full',
                geometries: 'geojson',
            });




            var version = 'v5';
            var osrmTextInstructions = require('osrm-text-instructions')(version);

            let route = osrmResponse.routes[0] as any;

            let trip: any = {
                polyline: route!.geometry!.coordinates.map((c) => { return { coordinates: c } }),
                instructions: [],
                duration: route.distance,
                distance: route.duration,
            }

            for (const leg of route.legs) {
                let steps: any = [];
                for (const step of leg.steps) {
                    steps.push(osrmTextInstructions.compile('en', step, {
                        legCount: route.legs.length,
                        legIndex: route.legs.indexOf(leg),

                    }))
                }
                trip.instructions.push({
                    steps,
                    summary: leg.summary,
                    duration: leg.duration,
                    distance: leg.distance,
                })
            }

            packageItem.trip = trip;




            await db.collection('trip_items').insertOne(packageItem);

            console.log("COUNTERRRRRR ", count, proccessedIds.length);
            proccessedIds = Array.from(new Set(proccessedIds));

        } while (count >= proccessedIds.length);







    } finally {
        // Ensures that the client will close when you finish/error
        await client.close();
    }
}



run().catch(console.dir);