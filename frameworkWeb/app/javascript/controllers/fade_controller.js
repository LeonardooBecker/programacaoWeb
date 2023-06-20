import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="fade"
export default class extends Controller {
  connect() {
    document.addEventListener("keydown", this.handleKeyDown.bind(this));
  }

  disconnect() {
    document.removeEventListener("keydown", this.handleKeyDown.bind(this));
  }

  fade_in() {

    $('.allModal:not([style*="display:none"])').css('display', 'none');
    
    var texto="#op"+$(this.element).attr("id")
    console.log(texto)
    $("#modal").fadeIn();
    if ( $(texto).css("display") == "none")
        $(texto).fadeIn()


  }
  fade_out() {
    console.log("JIAJI")
    $("#modal").fadeOut();
  }

  handleKeyDown(event) {
    if (event.key === "Escape") {
      $("#modal").fadeOut();
    }
  }

  handleClick(event) {
    // Lógica do evento de clique aqui
    console.log("Clique detectado!");

    // Acessar o elemento do Stimulus usando 'this.element'
    console.log(this.element);
  }

}
