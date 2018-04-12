/***
 * Excerpted from "Rails 5 Test Prescriptions",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
***/
import {Project} from "../../app/javascript/packs/project.js"
import {Task} from "../../app/javascript/packs/task.js"

describe("Projects", () => {
  let project

  beforeEach(() => {
    project = new Project(1)
    project.appendTask(new Task("Start Project", 1))
    project.appendTask(new Task("Middle Project", 2))
    project.appendTask(new Task("End Project", 3))
  })

  it("can identify the first element of a project", () => {
    expect(project.firstTask().name).toEqual("Start Project")
    expect(project.firstTask().isFirst()).toBeTruthy()
    expect(project.firstTask().isLast()).toBeFalsy()
    expect(project.firstTask().index()).toEqual(0)
  })

  it("can identify the last element of a project", () => {
    expect(project.lastTask().name).toEqual("End Project")
    expect(project.lastTask().isLast()).toBeTruthy()
    expect(project.lastTask().isFirst()).toBeFalsy()
    expect(project.lastTask().index()).toEqual(2)
  })

  it("can move a task up", () => {
    project.tasks[1].moveUp()
    expect(project.firstTask().name).toEqual("Middle Project")
    expect(project.tasks[1].name).toEqual("Start Project")
    expect(project.lastTask().name).toEqual("End Project")
  })

  it("can move a task down", () => {
    project.tasks[1].moveDown()
    expect(project.firstTask().name).toEqual("Start Project")
    expect(project.tasks[1].name).toEqual("End Project")
    expect(project.lastTask().name).toEqual("Middle Project")
  })

  it("handles asking for the top task to move up", () => {
    project.firstTask().moveUp()
    expect(project.firstTask().name).toEqual("Start Project")
    expect(project.tasks[1].name).toEqual("Middle Project")
    expect(project.lastTask().name).toEqual("End Project")
  })

  it("handles asking for the bottom task to move up", () => {
    project.lastTask().moveDown()
    expect(project.firstTask().name).toEqual("Start Project")
    expect(project.tasks[1].name).toEqual("Middle Project")
    expect(project.lastTask().name).toEqual("End Project")
  })
})
