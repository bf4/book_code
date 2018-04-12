cart = document.getElementById("cart")
cart.innerHTML = "<%= j render(@cart) %>"

notice = document.getElementById("notice")
if notice
  notice.style.display = "none"
