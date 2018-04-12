/***
 * Excerpted from "Rails 5 Test Prescriptions",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
***/
import {TaskRow} from "../../../app/javascript/packs/task_row.js"

export class ProjectTable {
  constructor(project, selector) {
    this.project = project
    this.selector = selector
  }

  insert() {
    $(this.selector).html(this.asHtml())
  }

  asHtml() {
    const table = $("<table>")
    table.html("<thead> <tr><th>Name</th> <th>Size</th></tr> </thead>")
    const body = $("<tbody>")
    this.project.tasks.forEach(task => {
      body.append(new TaskRow(task).asHtml())
    })
    table.append(body)
    return table
  }
}
