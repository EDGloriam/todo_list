#-----------------------------------------------------------------------
# Add Project
#-----------------------------------------------------------------------
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
        # console.log response
        $("#new-project-name").val('')
        $("#new-project-name, #create-project").hide()
        $("#main-container").append(JST['templates/project'](response))
      error: (xhr, status, statusErr) ->
        console.log xhr
#-----------------------------------------------------------------------
# Edit Project
#-----------------------------------------------------------------------
  $(document).on "click", ".js-edit-project", (e) ->
    e.preventDefault()
    project = $(e.target).parents(".project")
    nameOfProject = project.find(".table-name").text().trim()
    project.find(".table-name").hide()
    project.find(".edit-project").show()
    project.find(".edit-project-name").val(nameOfProject)


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
#-----------------------------------------------------------------------
# DELETE Project
#-----------------------------------------------------------------------
  $(document).on "click", ".js-delete-project", (e) ->
    # console.log("!")
    # debugger
    projectid = $(e.target).parents(".project").attr("projectid")
    $.ajax
      url: "projects/#{projectid}"
      type: "DELETE"
      success: (response) ->
        $("[projectid=#{projectid}]").remove()
      error: (xhr, status, statusErr) ->
        console.log xhr
#-----------------------------------------------------------------------
# Add Task
#-----------------------------------------------------------------------
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
        $(e.target).parents(".project").find(".task-table #tasks").append(taskTemplate)
        $(e.target).parent().find(".task-name").val("")
      error: (xhr, status, statusErr) ->
        console.log xhr
#-----------------------------------------------------------------------
# Edit Task
#-----------------------------------------------------------------------
  $(document).on "click", ".js-edit-task", (e) ->
    contentWithinEdit = $(e.target).parents("tr").find(".col-2 p").text().trim()
    $(e.target).parents("tr").find(".edit-task-content").val(contentWithinEdit)
    $(e.target).parents("tr").find(".edit-task-form").show()
    $(e.target).parents("tr").find(".col-2 p").hide()

  $(document).on "click", ".js-cancel-task-btn", (e) ->
    e.preventDefault()
    $(e.target).parents("tr").find(".edit-task-form").hide()
    $(e.target).parents("tr").find(".col-2 p").show()

  $(document).on "click", ".js-update-task-btn", (e) ->
    e.preventDefault()
    projectId = $(e.target).parents(".project").attr("projectid")
    id = $(e.target).parents("tr").attr("id")
    $.ajax
      url: "projects/#{projectId}/tasks/#{id}"
      type: "PATCH"
      data:
        task:
          content: $(e.target).parent().find(".edit-task-content").val().trim()
      success: (response) ->
        $(e.target).parents("tr").find(".edit-task-form").hide()
        $(e.target).parents("tr").find(".col-2 p").text(response.content)
        $(e.target).parents("tr").find(".col-2 p").show()
      error: (xhr, status, statusErr) ->
        console.log xhr

#-----------------------------------------------------------------------
# DELETE Task
#-----------------------------------------------------------------------
  $(document).on "click", ".js-delete-task", (e) ->
    projectid = $(e.target).parents(".project").attr("projectid")
    id = $(e.target).parents("tr").attr("id")
    $.ajax
      url: "projects/#{projectid}/tasks/#{id}"
      type: "DELETE"
      success: (response) ->
        $("[id=#{id}]").remove()
      error: (xhr, status, statusErr) ->
        console.log xhr




