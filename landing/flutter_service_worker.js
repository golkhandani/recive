'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "8c4fc383435245f421928a8574d866cc",
"version.json": "235d70a8f96506228fe97e24bff77212",
"splash/img/light-2x.png": "cfba4adee84bfd0ab761daa6657ba1a7",
"splash/img/dark-4x.png": "9ade3f88f0797c2068d523eff42e35e3",
"splash/img/light-3x.png": "0e0dbd01b2891d31ca9b987b3b997f43",
"splash/img/dark-3x.png": "0e0dbd01b2891d31ca9b987b3b997f43",
"splash/img/light-4x.png": "9ade3f88f0797c2068d523eff42e35e3",
"splash/img/dark-2x.png": "cfba4adee84bfd0ab761daa6657ba1a7",
"splash/img/dark-1x.png": "eb5fa7a9c383d1fefa570150c225ab1f",
"splash/img/light-1x.png": "eb5fa7a9c383d1fefa570150c225ab1f",
"index.html": "efb6e4e14026322cbb5ad029659f92a7",
"/": "efb6e4e14026322cbb5ad029659f92a7",
"main.dart.js": "4efc0430c5bc4047297c71644a4e7658",
".well-known/apple-app-site-association": "8a6d79efa6b2c41348991f9ff013b9b4",
"jquery/jquery-1.10.2.js": "b36eb23c18580f715487f3907d39da9e",
"jquery/jquery-ui.custom.min.js": "23a7e4f922b9be95d98b084a6f6d75d0",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"favicon.png": "2242e9843540d0d0ed20f293540325fd",
"bootstrap3/css/bootstrap.min.css": "072e95329879934d29384b7a0b24345e",
"bootstrap3/css/bootstrap.css": "e808acb0f6815cbb591b289e458a348a",
"bootstrap3/css/font-awesome.css": "350e379de80f210090217bbc6c3add46",
"bootstrap3/css/bootstrap-theme.css": "b9d9460d64b88e2c071306360dea28b0",
"bootstrap3/css/bootstrap-theme.min.css": "bc4ad5be1fd1afeee933dcb22484dccc",
"bootstrap3/js/bootstrap.js": "56dda6c08d41f2f644183140a0d56cdc",
"bootstrap3/js/bootstrap.min.js": "93ab8e2c2c57a5924f40569afb06d18d",
"bootstrap3/fonts/fontawesome-webfont.svg": "e4c40a7643fe551f1f840f59062cda0c",
"bootstrap3/fonts/FontAwesome.otf": "03c70c5e828508c3c414dda119e75911",
"bootstrap3/fonts/glyphicons-halflings-regular.woff": "5eae1f7217b606d3580dd70ac840fea1",
"bootstrap3/fonts/glyphicons-halflings-regular.eot": "aa16cd35628e6dddf56e766c9aa4ae63",
"bootstrap3/fonts/glyphicons-halflings-regular.ttf": "47da44498fc073d9fff9ab0cdb0bef8e",
"bootstrap3/fonts/fontawesome-webfont.ttf": "9048aedb839b56a3ab8515fae8b5c921",
"bootstrap3/fonts/fontawesome-webfont.woff": "fb0869e352d83a49579e9cd4d9ac1c6b",
"bootstrap3/fonts/glyphicons-halflings-regular.svg": "0a5c48c69a25a93e37ed62db813387fa",
"bootstrap3/fonts/fontawesome-webfont.eot": "d06e73eab020ca784f5b174e62b11804",
"icons/Icon-192.png": "0082a124df1a4c39ceacf58ab495b7e2",
"icons/Icon-maskable-192.png": "0082a124df1a4c39ceacf58ab495b7e2",
"icons/Icon-maskable-512.png": "c1715a031060d8f7005432bd76f5a935",
"icons/Icon-512.png": "c1715a031060d8f7005432bd76f5a935",
"manifest.json": "44274548bc670a60e50a7b2b9f113d78",
"firebase.json": "fb44175dda818189fcc12627fb4d5ce4",
"flutter-app.js": "e8757e1a7dfc5a9473bb3f4d947d95b0",
"flutter-app.html": "72da56656a1d796cf714797fe8344577",
"assets/css/style.css": "f8dba67988c27c9a810e5bbc521fa7c2",
"assets/AssetManifest.json": "5476724b2491367e254d367cc805244f",
"assets/NOTICES": "dad633b6fae7d046e9ac48f95932c744",
"assets/img/banner-blur.webp": "b9aa37b17ed13bd240fe0ec65cb25a6a",
"assets/img/banner.webp": "20386e494fbc8cea66c6be412066be69",
"assets/img/feature-image.webp": "aecc97565c71b9cfbe5be755203506ed",
"assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"assets/AssetManifest.bin.json": "5308151cdc5c810f9946f643fb6f53be",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "8521152765ac463fb43cc71bb7a89163",
"assets/packages/flutter_map/lib/assets/flutter_map_logo.png": "208d63cc917af9713fc9572bd5c09362",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "04f83c01dded195a11d21c2edf643455",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "f3307f62ddff94d2cd8b103daf8d1b0f",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "17ee8e30dde24e349e70ffcdc0073fb0",
"assets/packages/supabase_auth_ui/assets/logos/notion.png": "6b95dbedeafea10db8a51daccd7e31a4",
"assets/packages/supabase_auth_ui/assets/logos/google_light.png": "f243a900707589f1b21af980454090bd",
"assets/packages/supabase_auth_ui/assets/logos/kakao.png": "7e156d594910fef4ae12696161c47a2f",
"assets/packages/supabase_auth_ui/assets/logos/workOS.png": "7ddd6d5a2e3b4dc4dbb1a2ee9ab8cd5b",
"assets/packages/supabase_auth_ui/assets/logos/keycloak.png": "ea74380ccc89dbc26bd0281dd46ee942",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "80f0ffdc06d91eb86991d43673e0f2ef",
"assets/fonts/MaterialIcons-Regular.otf": "7746d832fc46850d70a7aaecb67edf91",
"assets/assets/app_loading.json": "3394bf0feebaa306657910bb51023a3d",
"assets/assets/app_icon.png": "38924f581088a90d16623aa616085485",
"assets/assets/app_background.jpg": "e363dec25b43f172427c410fa3878f34",
"assets/assets/icon/icon.png": "a69b0271aa0f1c8a38cafeb1434b36b2",
"assets/assets/app_splash_animated.gif": "2b5244aa564e6bdef2e581bc6ffb831c",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
