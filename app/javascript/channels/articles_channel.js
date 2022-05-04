import consumer from "./consumer"

console.log('hello')

consumer.subscriptions.create("ArticlesChannel", {
  connected() {
    console.log('<<connected!>>');
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log('received data', data);

    const newItem = `
      <li class="collection-item new">
        <a href="/articles/${data.id}">${data.title}</a>
      </li>
     `;

    const collection = document.querySelector(".content .collection")
    collection.insertAdjacentHTML("afterbegin", newItem)
  }
});
