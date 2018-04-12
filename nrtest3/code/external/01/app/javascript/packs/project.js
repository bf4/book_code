/***
 * Excerpted from "Rails 5 Test Prescriptions",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
***/
import {ProjectLoader} from "../../../app/javascript/packs/project_loader.js"
import {Task} from "../../../app/javascript/packs/task.js"
import {ProjectTable} from "../../../app/javascript/packs/project_table.js"


export class Project {
  constructor(id) {
    this.tasks = []
    this.id = id
    this.loader = new ProjectLoader(this)
  }

  load() {
    return this.loader.load().then(data => this.loadFromData(data))
  }

  loadFromData(data) {
    this.name = data.project.name
    data.project.tasks.forEach(taskData => {
      this.appendTask(new Task(
        taskData.title, taskData.size, taskData.project_order))
    })
    return this
  }

  appendTask(task) {
    this.tasks.push(task)
    task.project = this
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
    new ProjectTable(this, ".task-table").insert()
  }
}
