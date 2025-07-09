// Cache name and resources to cache
const CACHE_NAME = 'flutter-app-v1';
const urlsToCache = [
  '/',
  '/pages/offline',
  '/pages/about',
  '/pages/contact',
  '/pages/pricing',
  '/pages/faq',
  '/icon.png',
  '/icon.svg'
];

// Install event - cache resources
self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then((cache) => cache.addAll(urlsToCache))
  );
});

// Fetch event - serve from cache when offline
self.addEventListener('fetch', (event) => {
  event.respondWith(
    caches.match(event.request)
      .then((response) => {
        // Return cached version or fetch from network
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
      .catch(() => {
        // If both cache and network fail, show offline page
        if (event.request.destination === 'document') {
          return caches.match('/pages/offline');
        }
      })
  );
});

// Add a service worker for processing Web Push notifications:
self.addEventListener("push", async (event) => {
  const { title, options } = await event.data.json();
  event.waitUntil(self.registration.showNotification(title, options));
});

self.addEventListener("notificationclick", function(event) {
  event.notification.close();
  event.waitUntil(
    clients.matchAll({ type: "window" }).then((clientList) => {
      for (let i = 0; i < clientList.length; i++) {
        let client = clientList[i];
        let clientPath = new URL(client.url).pathname;

        if (clientPath == event.notification.data.path && "focus" in client) {
          return client.focus();
        }
      }

      if (clients.openWindow) {
        return clients.openWindow(event.notification.data.path);
      }
    }),
  );
});
