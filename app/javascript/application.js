// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

// Register service worker for PWA
if ("serviceWorker" in navigator) {
  window.addEventListener("load", () => {
    navigator.serviceWorker
      .register("/service-worker")
      .then((registration) => {
        console.log(
          "Service Worker registered with scope:",
          registration.scope,
        );
      })
      .catch((error) => {
        console.error("Service Worker registration failed:", error);
      });
  });
}

// Online/Offline detection
function showOfflineMessage() {
  const offlineDiv = document.createElement('div');
  offlineDiv.id = 'offline-message';
  offlineDiv.innerHTML = `
    <div style="
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      background: #ff4444;
      color: white;
      text-align: center;
      padding: 10px;
      z-index: 9999;
    ">
      🔌 You're offline. Some features may not work.
    </div>
  `;
  document.body.appendChild(offlineDiv);
}

function hideOfflineMessage() {
  const offlineDiv = document.getElementById('offline-message');
  if (offlineDiv) {
    offlineDiv.remove();
  }
}

// Listen for online/offline events
window.addEventListener('online', hideOfflineMessage);
window.addEventListener('offline', showOfflineMessage);

// Check initial state
if (!navigator.onLine) {
  showOfflineMessage();
}
