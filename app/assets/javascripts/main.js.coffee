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
    # debugger
    $.ajax
      url: "projects/#{projectId}"
      type: "PATCH"
      data:
        project:
          name: $(e.target).parent().find(".edit-project-name").val()
      success: (response) ->
          perentElement.find(".table-name").val(response.name)
          perentElement.hide()
          console.log("hide is done")
          perentElement.perent().find(".table-name").show()
          console.log("show is done")
      error: (xhr, status, statusErr) ->
        console.log xhr
