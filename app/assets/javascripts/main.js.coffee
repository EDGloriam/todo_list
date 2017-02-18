$(document).ready ->
  $(".button-add-list").click ->
    $("#new-project-name, #create-project").show()

  $("#create-project").click ->
    $.ajax
      url: "projects"
      type: "POST"
      data:
        project:
          name: $("#new-project-name").val()
      success: (response) ->
        console.log response
        $("#new-project-name").val('')
        $("#new-project-name, #create-project").hide()
        $("#main-container").append(JST['templates/project'](response))
      error: (xhr, status, statusErr) ->
        console.log xhr

  $(document).on "click", ".js-delete-project", (e) ->
    projectId = $(e.target).parents(".project").attr("projectid")
    $.ajax
      url: "projects/#{projectId}"
      type: "DELETE"
      success: (response) ->
        $("[projectid=#{projectId}]").remove()
      error: (xhr, status, statusErr) ->
        console.log xhr

  $(document).on "click", ".js-edit-project", (e) ->
    e.preventDefault()
    project = $(e.target).parents(".project")
    valueOfProj = project.find(".table-name").text().trim()
    project.find(".table-name").hide()
    project.find(".edit-project").show()
    project.find(".edit-project-name").val(valueOfProj)


  $(document).on "click", ".js-cancel-btn", (e) ->
    e.preventDefault()
    project = $(e.target).parents(".project")
    project.find(".table-name").show()
    project.find(".edit-project").hide()


  $(document).on "click", ".js-update-btn", (e) ->
    e.preventDefault()
    projectId = $(e.target).parents(".project").attr("projectid")
    perentElement = $(e.target).parent()
    $.ajax
      url: "projects/#{projectId}"
      type: "PATCH"
      data:
        project:
          name: $(e.target).parent().find(".edit-project-name").val()
      success: (response) ->
        $(e.target).parents(".project").find(".edit-project").hide()
        $(e.target).parents(".project").find(".table-name").text(response.name)
        $(e.target).parents(".project").find(".table-name").show()
      error: (xhr, status, statusErr) ->
        console.log xhr


  $(document).on "click", ".js-add-task", (e) ->
    e.preventDefault()
    projectId = $(e.target).parents(".project").attr("projectid")
    $.ajax
      url: "projects/#{projectId}/tasks"
      type: "POST"
      data:
        task:
          content: $(e.target).parent().find(".task-name").val()
      success: (response) ->
        taskTemplate = JST['templates/task'](response)
        $(e.target).parents(".project").find(".task-table tbody").append(taskTemplate)
        $(e.target).parent().find(".task-name").val("")
      error: (xhr, status, statusErr) ->
        console.log xhr