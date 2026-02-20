function filterByStatus(status) {
  // Update button states
  document.querySelectorAll('.status-btn').forEach(btn => {
    btn.classList.remove('active');
  });
  event.target.classList.add('active');
  
  // Find the Quarto list.js instance
  const listingEl = document.querySelector('.quarto-listing');
  if (!listingEl) return;
  const listingId = listingEl.id;
  const list = window['quarto-listings'] && window['quarto-listings'][listingId];
  
  if (list) {
    if (status === 'all') {
      list.filter(); // Clear filter
    } else {
      list.filter(function(item) {
        const statusVal = item.values()['listing-status'];
        return statusVal && statusVal.trim().toLowerCase() === status;
      });
    }
  }
}
