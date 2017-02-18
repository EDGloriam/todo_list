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
