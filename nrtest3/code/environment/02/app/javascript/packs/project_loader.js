/***
 * Excerpted from "Rails 5 Test Prescriptions",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
***/
export class ProjectLoader {
  constructor(project) {
    this.project = project
  }

  load() {
    return $.ajax(this.ajaxData())
  }

  ajaxData() {
    return {
      url: `/projects/${this.project.id}.js`,
      dataType: "json"
    }
  }
}
