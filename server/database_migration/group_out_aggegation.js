const { MongoClient, ServerApiVersion, ObjectId } = require('mongodb');
const cheerio = require('cheerio');

const uri = "mongodb+srv://golkhandani:PRF8HkWLhIojSCtw@cluster0.pnixghy.mongodb.net/?retryWrites=true&w=majority";
// Create a MongoClient with a MongoClientOptions object to set the Stable API version
const client = new MongoClient(uri, {
    serverApi: {
        version: ServerApiVersion.v1,
        strict: true,
        deprecationErrors: true,
    }
});
async function run() {

    try {
        // Connect the client to the server	(optional starting in v4.7)
        await client.connect();
        // Send a ping to confirm a successful connection
        await client.db("admin").command({ ping: 1 });
        console.log("Pinged your deployment. You successfully connected to MongoDB!");

        let db = client.db("revice_explorer");
        // let result = await db.collection('arts').aggregate(
        //     [
        //         {
        //             $group: {
        //                 _id: '$type',
        //                 type: { $first: '$type' },
        //                 docs: { $push: '$$ROOT' }
        //             }
        //         }
        //     ]).toArray();

        let result = await db.collection('arts').find().limit(10).skip(0).toArray();


        let source_id = new ObjectId();
        let source_url = 'https://opendata.vancouver.ca';
        let source_name = 'Vancouver Open Data';

        let finalSource = {
            _id: source_id,
            name: source_name,
            copy_right: 'https://covapp.vancouver.ca',
            data_url: source_url,
        };

        await db.dropCollection('art_items');
        await db.dropCollection('artist_items');
        await db.dropCollection('image_items');
        await db.dropCollection('source_items');
        await db.dropCollection('venue_items');


        await db.createCollection('art_items');
        await db.createCollection('artist_items');
        await db.createCollection('image_items');
        await db.createCollection('source_items');
        await db.createCollection('venue_items');

        let insertedSource = await db.collection('source_items').insertOne(finalSource);

        for (let index = 0; index < result.length; index++) {
            const orginalData = result[index];

            await new Promise(r => setTimeout(r, 5000));
            console.log(orginalData);
            let defLoc = {
                _id: new ObjectId(),
                osm_id: null,
                osm_venue_id: null,
                osm_licence: null,
                title: orginalData.sitename,
                address: {
                    city: 'Vancouver',
                    country: 'Canada',
                    latitude: 49.2608724,
                    localizedAddressDisplay: `${orginalData.sitename}, ${orginalData.siteaddress}`,
                    longitude: -123.113952,
                    postalCode: null,
                    region: 'British Columbia',
                    // extra
                    area: orginalData.neighbourhood,
                },
                geolocation: {
                    type: "Point",
                    coordinates: [-123.113952, 49.2608724]
                },
            }
            let originalMapData = orginalData.geo_point_2d == null ? null : await (await fetch(`https://geocode.maps.co/reverse?lat=${orginalData.geo_point_2d.lat}&lon=${orginalData.geo_point_2d.lon}`)).json()

            console.log(originalMapData);
            let originalArtists = await db.collection('artists').find({ artistid: { $in: orginalData.artists.map((item) => parseInt(item)) } }).toArray()





            let originalDetailsData = await fetchDetails(orginalData.url);

            let artImages = []
            for (let index = 0; index < originalDetailsData.photoUrls.length; index++) {
                const imageUrl = originalDetailsData.photoUrls[index];
                const imageUrlData = await fetch(imageUrl);
                const buffer = await imageUrlData.arrayBuffer();
                const stringifiedBuffer = Buffer.from(buffer).toString('base64');
                const contentType = imageUrlData.headers.get('content-type');
                const imageBase64 =
                    `data:${contentType};base64,${stringifiedBuffer}`;

                artImages.push({
                    _id: new ObjectId,
                    image_url: imageUrl,
                    image_data: imageBase64,
                    image_credit: originalDetailsData.photoBy,
                });
            }

            let insertedImages = await db.collection('image_items').insertMany(artImages);
            console.log(insertedImages.insertedIds)

            let finalArtists = [];
            for (let index = 0; index < originalArtists.length; index++) {
                const originalArtist = originalArtists[index];
                const imageUrl = originalArtist.photo;
                if (imageUrl == null) {
                    let finalArtist = {
                        _id: originalArtist._id,
                        original_id: originalArtist.artistid,
                        name: originalArtist.firstname + ' ' + originalArtist.lastname,
                        url: originalArtist.artisturl,
                        website: originalArtist.website,
                        images: [],
                        biography: originalArtist.biography,
                        country: originalArtist.country,
                    };
                    let insertedArtists = await db.collection('artist_items').updateOne({ _id: finalArtist._id }, { "$setOnInsert": finalArtist }, { upsert: true });

                    finalArtists.push(finalArtist);
                } else {
                    const imageUrlData = await fetch(imageUrl);
                    const buffer = await imageUrlData.arrayBuffer();
                    const stringifiedBuffer = Buffer.from(buffer).toString('base64');
                    const contentType = imageUrlData.headers.get('content-type');
                    const imageBase64 =
                        `data:${contentType};base64,${stringifiedBuffer}`;

                    let artistImage = {
                        _id: new ObjectId,
                        image_url: imageUrl,
                        image_data: imageBase64,
                        image_credit: originalArtists[index].photocredit,
                    };
                    let insertedArtistImages = await db.collection('image_items').insertMany([artistImage]);
                    let finalArtist = {
                        _id: originalArtist._id,
                        original_id: originalArtist.artistid,
                        name: originalArtist.firstname + ' ' + originalArtist.lastname,
                        url: originalArtist.artisturl,
                        website: originalArtist.website,
                        images: [artistImage._id],
                        biography: originalArtist.biography,
                        country: originalArtist.country,
                    }
                    let insertedArtists = await db.collection('artist_items').updateOne({ _id: finalArtist._id }, {}, { upsert: true });
                    finalArtists.push(finalArtist);
                }
            }



            let venue = originalMapData == null ? defLoc : {
                _id: new ObjectId(),
                osm_id: originalMapData.osm_id,
                osm_venue_id: originalMapData.place_id,
                osm_licence: originalMapData.licence,
                title: originalMapData.address.historic,
                address: {
                    city: originalMapData.address.city,
                    country: originalMapData.address.country,
                    latitude: parseFloat(originalMapData.lat),
                    localizedAddressDisplay: originalMapData.display_name,
                    longitude: parseFloat(originalMapData.lon),
                    postalCode: originalMapData.address.postcode,
                    region: originalMapData.address.state,
                    // extra
                    area: originalMapData.address.city_district,
                },
                geolocation: {
                    type: "Point",
                    coordinates: orginalData.geom.geometry.coordinates
                },
            }

            let insertedVenue = await db.collection('venue_items').insertOne(venue);

            let finaldata = {
                _id: orginalData._id,
                original_id: orginalData.registryid,
                original_url: orginalData.url,
                title: orginalData.title_of_work,
                statement: orginalData.artistprojectstatement,
                description: orginalData.descriptionofwork,
                images: artImages.map((e) => e._id),
                // Extra
                art_type: orginalData.type,
                ownership: orginalData.ownership,
                material: [orginalData.primarymaterial],
                learn_more: originalDetailsData.learnMore,
                // End Extra
                tags: Array.from(new Set([
                    orginalData.geo_local_area,
                    orginalData.neighbourhood,
                    orginalData.ownership,
                    orginalData.primarymaterial,
                    orginalData.type,
                    orginalData.yearofinstallation,
                    ...originalDetailsData.tags,
                ])),
                venue: venue._id,
                source: finalSource._id,
                artists: finalArtists.map((e) => e._id),
            }


            await db.collection('art_items').insertOne(finaldata);

            console.log(index, ' IS DONE!!!!!!');
        }


    } finally {
        // Ensures that the client will close when you finish/error
        await client.close();
    }
}

async function fetchDetails(url) {
    let page = await fetch(url);
    let body = await page.text();
    console.log(body);
    let $ = cheerio.load(body);
    let title = $('title').text().trim();

    console.log(title);
    let tags = $('meta[name="keywords"]').attr('content').split(',');
    console.log(tags);

    let mainTitle = $("img[id*='wtWebScreenTitleDesktop']").text();
    console.log(mainTitle);

    // let photoUrl = $("div.CornerImageContainer img.ImageWithBorder").attr('src');
    // console.log(photoUrl);

    let photoUrls = []
    $("span.ListRecords img").each((i, el) => {
        photoUrls.push(`https:${$(el).attr('src')}`.replace('Thumb', 'Large'));
    });
    console.log(photoUrls);


    let photoBy = $("div.Section_content div.OSAutoMarginTop:contains('Photo:')").text();
    console.log(photoBy);

    let learnMore = $("label[id*='wtURLLink']:contains('Learn More:')").next().attr('href');
    console.log(learnMore);

    return {
        title: mainTitle,
        photoUrls: photoUrls,
        photoBy: photoBy,
        learnMore,
        tags,
    }

    return;
}

run().catch(console.dir);