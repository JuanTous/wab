$(document).ready(function () {

    var localObj = window.location;
    var contextPath = localObj.pathname.split("/")[1];
    var basePath = localObj.protocol + "//" + localObj.host + "/" + contextPath + "/tablero.jsp";
    var nroPros = JSON.parse($("#nroPros").val());

    if (window.location == basePath) {
        location.href = "controladorEmp?accion=home";
    }

    $(".container:eq(2) .btn-success").click(function () {
        $(".container:eq(3)").fadeTo("slow", 1);
        location.href = "#add";
    });

    if ($("#sesion").text() !== '') {
        if ($("#sesion").text() !== '{}') {
            if ($("#sesion").text().length !== 75) {
                var usuario = JSON.parse($("#sesion").text());
                if (usuario.nombres.length > 14) {
                    var nuevo = usuario.nombres.split(" ");
                    $("#identificacion").text(" " + nuevo[0]);
                } else {
                    $("#identificacion").text(" " + usuario.nombres);
                }
                $("#barraId").html(`
                    <div class='form-group'>
                        <span class='text-center text-dark form-control' style='font-weight: bold;'>MI CUENTA<i class='fas fa-user ml-2'></i></span>
                            <div class='dropdown-divider'></div>
                                <button id='config' class='btn btn-outline-info mt-2' data-backdrop='static'>Area personal</button>
                                <br>
                                <a href='#' id='cerrarSes' class='btn btn-outline-danger mt-2'>Cerrar sesión</a>
                    </div>
                    <div class='dropdown-divider'></div>
                        <span class='text-dark'>W A B&#174;</span>
                    </div>                       
            `);
            } else {
                Swal.fire({
                    position: 'top-end',
                    icon: 'error',
                    title: 'Usuario inexistente',
                    showConfirmButton: false,
                    timer: 3000
                });
            }
        }
    }

    $("#config").click(function () {
        $('#myModalConfig').show("slow");
        $('#myModalConfig').modal({backdrop: 'static'});
        $('#cerrarModal').click(function () {
            $('#myModalConfig').modal('hide');
        });
    });

    $("#cerrarSes").click(function () {
        Swal.fire({
            title: '¿Seguro desea salir?',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: 'Cerrar sesión',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                location.href = "controladorEmp?accion=destroy";
            }
        });
    });

    $("#descuento").change(function () {
        if ($("#descuento").val() == 'Si') {
            Swal.fire({
                title: '<strong>Seleccione de cuanto quiere que sea el descuento</strong>',
                icon: 'question',
                html: `                    <div class="input-group mt-5 mr-5">
                        <div class="input-group-prepend ml-4">
                            <label class="input-group-text bg-info text-white" for="porcentaje">Defina el porcentaje.</label>
                        </div>
                        <input type="number" id="porcentaje" class="custom-select mr-5" min="1" max="100" required="true">
                    </div>`,
                confirmButtonText: 'Confirmar'
            }).then((result) => {
                if (result.isConfirmed) {
                    $("#descuento").find("option:eq(2)").val($("#porcentaje").val());
                }
            });
        }
    });

    $("#descuentoE").change(function () {
        if ($("#descuentoE").val() == 'Si') {
            Swal.fire({
                title: '<strong>Seleccione de cuanto quiere que sea el descuento</strong>',
                icon: 'question',
                html: `                    <div class="input-group mt-5 mr-5">
                        <div class="input-group-prepend ml-4">
                            <label class="input-group-text bg-info text-white" for="porcentajeE">Defina el porcentaje.</label>
                        </div>
                        <input type="number" id="porcentajeE" class="custom-select mr-5" min="1" max="100" required="true">
                    </div>`,
                confirmButtonText: 'Confirmar'
            }).then((result) => {
                if (result.isConfirmed) {
                    $("#descuentoE").find("option:eq(2)").val($("#porcentajeE").val());
                }
            });
        }
    });

    for (var i = 0; i < nroPros.length; i++) {
        $("tr #btnEdit" + nroPros[i]).click(function () {
            var idp = $(this).parents("tr").find("#idp").val();
            $('#myModalEdit').show("slow");
            $('#myModalEdit').modal({backdrop: 'static'});
            $('#myModalEdit #idProEdi').val(idp);
            for (var j = 1; j <= nroPros.length; j++) {
                if ($("table tr:eq(" + j + ") td:last-child input:first-child").val() === idp) {
                    $("#descripcionE").val($("table tr:eq(" + j + ") td:eq(2)").text());
                    let precio = $("table tr:eq(" + j + ") td:eq(3)").text().split("$");
                    $("#precioE").val(precio[1]);
                    $("#inventarioE").val($("table tr:eq(" + j + ") td:eq(4)").text());
                }
            }
        });
    }

    $("#myModalEdit #accion").click(function (e) {
        if ($("#descuentoE").val() == 'Seleccione') {
            e.preventDefault();
            alert("No deje ningun campo vacio, por favor.");
        }
    });

    $("tr #btnDelete").click(function () {
        var idp = $(this).parent().find("#idp").val();
        Swal.fire({
            title: '¿Seguro que desea eliminar el producto?',
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: 'Eliminar',
            cancelButtonText: 'cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                location.href = "controladorEmp?accion=eliminarProducto&idp=" + idp;
            }
        });
    });

    $(".animacion").click(function () {
        $('#myModalCreateStore').show("slow");
        $('#myModalCreateStore').modal({backdrop: 'static'});
    });

});