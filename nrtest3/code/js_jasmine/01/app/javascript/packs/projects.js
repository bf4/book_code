/***
 * Excerpted from "Rails 5 Test Prescriptions",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
***/
export class Project {
  constructor() {
    this.tasks = []
  }

  appendTask(task) {
    this.tasks.push(task)
    task.project = this
    task.index = this.tasks.length - 1
  }

  firstTask() {
    return this.tasks[0]
  }

  lastTask() {
    return this.tasks[this.tasks.length - 1]
  }

  swapTasksAt(index1, index2) {
    const temp = this.tasks[index1]
    this.tasks[index1] = this.tasks[index2]
    this.tasks[index2] = temp
  }
}

export class Task {
  constructor(name, size) {
    this.name = name
    this.size = size
    this.project = null
    this.index = null
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
    this.project.swapTasksAt(this.index - 1, this.index)
  }

  moveDown() {
    if (this.isLast()) {
      return
    }
    this.project.swapTasksAt(this.index, this.index + 1)
  }
}
