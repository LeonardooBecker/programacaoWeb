import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="fade"
export default class extends Controller {
  connect() {
    document.addEventListener("keydown", this.handleKeyDown.bind(this));
  }

  disconnect() {
    document.removeEventListener("keydown", this.handleKeyDown.bind(this));
    console.log("fasfa")

    var href = $('a[href]:not([class])');
  
    var verifica=$(href).attr('href')

    console.log(verifica)
    if(verifica!=null)
    {
      var parts=verifica.split("/")

      var div1 = $("<div class='sign'></div>");

      if(parts[1]=='users')
        $(href).wrapAll(div1);
    }
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
