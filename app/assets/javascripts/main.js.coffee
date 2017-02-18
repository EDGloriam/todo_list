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
        $(".main-table").append(JST['templates/project'](response))
      error: (xhr, status, statusErr) ->
        console.log xhr

  $(".js-delete-project").click (e) ->
    projectId = $(e.target).parents(".project").attr("project-id")
    $.ajax
      url: "projects/#{projectId}"
      type: "DELETE"
      success: (response) ->
        $("[project-id=#{projectId}]").remove()
      error: (xhr, status, statusErr) ->
        console.log xhr
