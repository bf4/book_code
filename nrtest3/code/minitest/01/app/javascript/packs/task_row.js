/***
 * Excerpted from "Rails 5 Test Prescriptions",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
***/
export class TaskRow {
  constructor(task) {
    this.task = task
  }

  asHtml() {
    const row = $("<tr>").attr("id", `task_${this.task.id}`)
    row.append($("<td>", {class: "name"}).text(this.task.name))
    row.append($("<td>", {class: "size"}).text(this.task.size))
    const actionRow = $("<td>")
    if (!this.task.isFirst()) {
      actionRow.append($("<button>", {
        class: "up-button",
        click: () => { this.task.moveUp() }})
        .text("Up"))
    }
    if (!this.task.isLast()) {
      actionRow.append($("<button>", {
        class: "down-button",
        click: () => { this.task.moveDown() }})
        .text("Down"))
    }
    row.append(actionRow)
    return row
  }
}
