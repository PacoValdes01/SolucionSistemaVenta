
$(document).ready(function () {
    $(".card-body").LoadingOverlay("show");

    fetch("/Negocio/Obtener")

        .then(response => {
            $(".card-body").LoadingOverlay("hide");
            return response.ok ? response.json() : Promise.reject(response);
        })
        .then(responseJson => {
            console.log(responseJson);
            if (responseJson.estado) {
                const d = responseJson.objeto
                $("#txtRFC").val(d.rfc)
                $("#txtRégimenFiscal").val(d.régimenFiscal)
                $("#txtCódigoPostal").val(d.códigoPostal)
                $("#txtRazonSocial").val(d.razonSocial)
                $("#txtCorreo").val(d.correo)
                $("#txtDireccion").val(d.direccion)
                $("#txtTelefono").val(d.telefono)
                $("#txtSimboloMoneda").val(d.simboloMoneda)
                $("#imgLogo").attr("src", d.urlLogo)
            }
            else {
                swal("Lo sentimos", responseJson.mensaje, "error")
            }
        })
})

$("#btnGuardarCambios").click(function () {
    console.log("ENTREEE");
    const inputs = $("input.input-validar").serializeArray();
    const inputs_sin_valor = inputs.filter((item) => item.value.trim() == "")

    if (inputs_sin_valor.length > 0) {
        const mensaje = `Debe completar el campo: "${inputs_sin_valor[0].name}"`;
        toastr.warning("", mensaje)
        $(`input[name="${inputs_sin_valor[0].name}"]`).focus()
        return;
    }

    const modelo =
    {
        RFC: $("#txtRFC").val(),
        RégimenFiscal: $("#txtRégimenFiscal").val(),
        CódigoPostal: $("#txtCódigoPostal").val(),
        RazonSocial: $("#txtRazonSocial").val(),
        correo: $("#txtCorreo").val(),
        direccion: $("#txtDireccion").val(),
        telefono: $("#txtTelefono").val(),
        simboloMoneda: $("#txtSimboloMoneda").val(),

    }
    console.log(modelo)
 
    const inputLogo = document.getElementById("txtLogo")
    const formData = new FormData

    formData.append("logo", inputLogo.files[0])
    formData.append("modelo", JSON.stringify(modelo))

    $(".card-body").LoadingOverlay("show");

    fetch("/Negocio/GuardarCambios",
        {
            method: "POST",
            body: formData
        })

        .then(response => {
            $(".card-body").LoadingOverlay("hide");
            return response.ok ? response.json() : Promise.reject(response);
        })
        .then(responseJson => {
            console.log(responseJson);
            if (responseJson.estado) {
                const d = responseJson.objeto
                $("#imgLogo").attr("src", d.urlLogo)
            }
            else {
                swal("Lo sentimos", responseJson.mensaje, "error")
            }
        })
})