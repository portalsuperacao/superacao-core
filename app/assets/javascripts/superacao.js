
$(document).ready(function () {
  $('.delete-action').click(function () {
      var action_url = $(this).data('action')
      var success_redirect = $(this).data('success-redirect')
      swal({
          title: "Você tem certeza?",
          text: "Após a exclusão não será possível recuperar estes dados!",
          type: "warning",
          showCancelButton: true,
          confirmButtonColor: "#DD6B55",
          confirmButtonText: "Sim, excluir!",
          cancelButtonText: "Cancelar",
          closeOnConfirm: false
      }, function (isConfirm) {
          if (!isConfirm) return;
          $.ajax({
              url: action_url,
              type: "DELETE",
              dataType: "json",
              success: function () {
                  swal("Feito!", "Foi excluído.", "success");
                  setTimeout(function() {
                    window.location.href = success_redirect }, 1000);
              },
              error: function (xhr, ajaxOptions, thrownError) {
                  swal("Erro excluindo!", "Por favor, tente novamente.", "error");
              }
          });
      });
  });
});
