/***
 * Excerpted from "Rails 5 Test Prescriptions",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
***/
import {TaskUpdater} from "../../../app/javascript/packs/task_updater.js"

export class Task {
  constructor(name, size, id) {
    this.name = name
    this.size = size
    this.project = null
    this.id = id
  }

  index() {
    return this.project.tasks.indexOf(this)
  }

  isFirst() {
    if (this.project) {
      return this.project.firstTask() === this
    }
    return false
  }

  isLast() {
    if (this.project) {
      return this.project.lastTask() === this
    }
    return false
  }

  moveUp() {
    if (this.isFirst()) {
      return
    }
    this.project.swapTasksAt(this.index() - 1, this.index())
    new TaskUpdater(this, "up").update()
  }

  moveDown() {
    if (this.isLast()) {
      return
    }
    this.project.swapTasksAt(this.index(), this.index() + 1)
    new TaskUpdater(this, "down").update()
  }
}
