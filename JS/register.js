var isRegistered;
var isLoggedIn;

$(document).ready(function () {
    // Only one of these modals should show at a time.
    $('#SignupUsername').on('show.bs.modal', function (e) {
        $('#Signup').modal('hide');
        $('body').css("overflow", "hidden");
        $('body').css("padding-right", "15px");
        $(this).css("overflow-y", "auto");
    })
        .on('hide.bs.modal', function (e) {
            // @todo reload the job
            $('body').css("overflow", "visible");
            $('body').css("padding-right", "0px");
            $('.modal-header .close').css('padding-right', '15px');
        });

    $('#Signup').on('show.bs.modal', function (e) {
        $('#Login').modal('hide');
        $('body').css("overflow", "hidden");
        $('body').css("padding-right", "15px");
        $(this).css("overflow-y", "auto");
    })
        .on('hide.bs.modal', function (e) {
            // @todo reload the job
                $('#Login')
                    .modal('show')
                    .css("overflow-y", "auto");
                $('body').css("padding-right", "15px");
        });

    $('#Login').on('show.bs.modal', function (e) {
        // @todo reload the job
        $('body').css("overflow", "hidden");
        $('body').css("padding-right", "15px");
    })
        .on('hide.bs.modal', function (e) {
            // @todo reload the job
            $('body').css("overflow", "visible");
            $('body').css("padding-right", "0px");
            $('.modal-header .close').css('padding-right', '15px');
        });
});

function previewImage(input) {
    var file = input.files[0];
    if (file) {
        var reader = new FileReader();
        reader.onload = function (e) {
            var image = document.getElementById('profilePic');
            image.src = e.target.result;
        };
        reader.readAsDataURL(file);
    }
}

