// Custom service worker for better cache management
const CACHE_NAME = "not-static-icons-v1";
const urlsToCache = [
  "/",
  "/main.dart.js",
  "/flutter.js",
  "/icons/Icon-192.png",
  "/icons/Icon-512.png",
  "/favicon.png",
];

// Install event
self.addEventListener("install", function (event) {
  event.waitUntil(
    caches.open(CACHE_NAME).then(function (cache) {
      return cache.addAll(urlsToCache);
    })
  );
  // Force the waiting service worker to become the active service worker
  self.skipWaiting();
});

// Fetch event
self.addEventListener("fetch", function (event) {
  // Skip caching for manifest.json and index.html
  if (
    event.request.url.includes("manifest.json") ||
    event.request.url.includes("index.html") ||
    event.request.url.includes("flutter_service_worker.js") ||
    event.request.url.includes("flutter_bootstrap.js")
  ) {
    return fetch(event.request);
  }

  event.respondWith(
    caches.match(event.request).then(function (response) {
      // Return cached version or fetch from network
      if (response) {
        return response;
      }
      return fetch(event.request);
    })
  );
});

// Activate event
self.addEventListener("activate", function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheNames) {
      return Promise.all(
        cacheNames.map(function (cacheName) {
          if (cacheName !== CACHE_NAME) {
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
  // Ensure that the service worker takes control immediately
  return self.clients.claim();
});
