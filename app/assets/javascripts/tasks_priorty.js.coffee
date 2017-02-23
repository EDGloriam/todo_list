$(document).ready ->
  $(document).on "click", ".tasks", (e) ->
    $(".tasks").sortable
      update: (e, ui)->
        projectId = $(e.target).parents(".project").attr("projectid")
        $.post("/projects/#{projectId}/tasks/sort_tasks", {ids: $(this).sortable('toArray')})