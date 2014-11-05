/***
 * Excerpted from "Rails Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
***/
Ajax.InPlaceSelectEditor = Class.create(); 
Object.extend(Object.extend(Ajax.InPlaceSelectEditor.prototype,
                            Ajax.InPlaceEditor.prototype), {
    createEditField: function() {
      var text;
      if(this.options.loadTextURL) { 
        text = this.options.loadingText;
      } else {
        text = this.getText();
      }
      this.options.textarea = false;
      var selectField = document.createElement("select"); 
      selectField.name = "value";
      selectField.innerHTML=this.options.selectOptionsHTML ||
                     "<option>" + text + "</option>"; 
      $A(selectField.options).each(function(opt, index){
        if(text == opt.value) {
          selectField.selectedIndex = index;
        } 
      }
      );
      selectField.style.backgroundColor = this.options.highlightcolor;
      this.editField = selectField;
      if(this.options.loadTextURL) {
        this.loadExternalText();
      }
      this.form.appendChild(this.editField);
    }
});