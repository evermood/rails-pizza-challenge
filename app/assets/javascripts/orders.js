const completeOrder = (orderId) => {
  const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

  // TODO: handle case when all orders are completed
  fetch(`/orders/${orderId}`, {
    method: 'PATCH',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrfToken,
    },
  })
  .then(response => {
      if (response.ok) {
        window.location.href = '/orders';
        alert("Order has been successfuly updated"); // TODO: nicer flash
      } else {
        console.error('Error:', response.status);
      }
    })
  .catch(error => {
    console.error('Fetch error:', error);
  })
};
