/* global Swal */

$(document).ready(function () {
    var localObj = window.location;
    var contextPath = localObj.pathname.split("/")[1];
    var basePath = localObj.protocol + "//" + localObj.host + "/" + contextPath + "/";
    if (window.location == basePath) {
        location.href = "controlador?accion=home";
    }

    if (document.cookie !== 'estado=activo') {
        Swal.fire({
            title: '¡BIENVENIDO A WAB!',
            text: 'Nos complace ofrecerte una cordial bienvenida a nuestra tienda donde encontrarás las ultimas tendencias en joyerías.',
            imageUrl: 'images/welcome.jpg',
            confirmButtonText: 'Siguiente',
            allowOutsideClick: false
        }).then((result) => {
            if (result.isConfirmed) {
                initLogin();
            }
        });
    }

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
                location.href = "controlador?accion=destroy";
            }
        });
    });

    $("#mensajeRegistro").hide();
    $("#fm").on('submit', function (evt) {
        if ($("#perfil").val() === "Seleccione") {
            evt.preventDefault();
            $("#mensajeRegistro").show('slow');
        } else {
            if ($("#snombre").val() == "") {
                $("#snombre").val("no_tiene");
                evt.preventDefault();
            }
        }
    });

    $("#ordenar").click(function () {
        Swal.fire({
            title: '<strong>Seleccione la categoria por la cual desea buscar un producto</strong>',
            icon: 'question',
            html: `      <select class="btn custom-select" name="tipoB" id="tipoB" required="true">
                            <option value="null">Buscar por:</option>
                            <option value="tienda">Productos de una tienda</option>
                            <option value="categoria">Categoría de productos</option>
                            <option value="precio">Precio aproximado</option>
                        </select>`,
            confirmButtonText:
                    'Ok<i class="fa fa-thumbs-up ml-1"></i>'
        }).then(function () {
            $("#tipoBus").val($("#tipoB").val());
            if ($("#tipoB").val() === 'null') {
                $("#buscador").attr("placeholder", "Ingrese el producto");
                $("#buscador").attr("type", "text");
            } else {
                if ($("#tipoB").val() === 'precio') {
                    $("#buscador").attr("type", "number");
                    $("#buscador").attr("min", "1");
                    $("#buscador").attr("placeholder", "Ingrese el precio");
                } else {
                    $("#buscador").attr("placeholder", "Ingrese " + $("#tipoB").val());
                    $("#buscador").attr("type", "text");
                }
            }
        });
    });

    var nroProductos = $("#nrop").val();
    for (var i = 0; i < nroProductos; i++) {
        let idi = $("div .card-body img:nth-child(1):eq(" + i + ")").attr("id");
        $("div .card-body img:nth-child(1):eq(" + i + ")").attr('id', idi + (i + 1));
        let ida = $("div .card-footer div a:nth-child(2):eq(" + i + ")").attr('id');
        $("div .card-footer div a:nth-child(2):eq(" + i + ")").attr('id', ida + (i + 1));
        let idc = $("div .card-footer div a:nth-child(3):eq(" + i + ")").attr('id');
        $("div .card-footer div a:nth-child(3):eq(" + i + ")").attr('id', idc + (i + 1));
    }

    for (var i = 1; i <= nroProductos; i++) {
        $("#imagen" + i).click(function () {
            var imagen = $(this).attr('src');
            var titulo = $(this).parents("div #ampliar").find("#titulo").text();
            var descripcion = $(this).parents("div #ampliar").find("#descripcion").text();
            var precio = $(this).parents("div #ampliar").find("#precio").text();
            Swal.fire({
                imageUrl: imagen,
                title: titulo,
                confirmButtonText: 'Cerrar',
                html: "<i>" + descripcion + " por el espectacular precio de<br><b>" + precio + ".</b></i>"
            });
        });
    }

    for (var i = 1; i <= nroProductos; i++) {
        $("#btnAggCarr" + i).click(function () {
            if ($("#identificacion").text().trim() === 'Ingresar') {
                deshabilitarBtns();
            } else {
                var idp = $(this).parent().find("input").val();
                if (location.href == basePath + 'controlador?accion=ofertas') {
                    location.href = "controlador?accion=agregarCarrito&idp=" + idp + "&type=oferta";
                } else {
                    location.href = "controlador?accion=agregarCarrito&idp=" + idp + "&type=directo";
                }
                /*   $.ajax({
                 type: 'POST',
                 url: url,
                 data: "idp=" + idp,
                 success: function (data, textStatus, jqXHR) {
                 $("#actCon").hide('fast');
                 $("#actCon").show('slow');
                 $("#actCon").load(location.href + " #actCon");
                 }
                 });*/
            }
        });
    }

    for (var i = 1; i <= nroProductos; i++) {
        $("#btnComprarInd" + i).click(function () {
            if ($("#identificacion").text().trim() === 'Ingresar') {
                deshabilitarBtns();
            } else {
                var idp = $(this).parent().find("input").val();
                location.href = "controlador?accion=comprar&idp=" + idp;
            }
        });
    }
    if (window.location.href.includes("controlador?accion=comprar&idp=")) {
        window.location.href = "controlador?accion=carrito";
    }
    function deshabilitarBtns() {
        Swal.fire({
            position: 'top-end',
            icon: 'error',
            title: 'Debes tener una cuenta para poder adquirir los productos',
            html: `<p><i>*Este aviso cerrará automaticamente*</i><p>
                           <a href="registro.jsp" class="btn btn-success ml-2 mt-2">Crear una cuenta gratis</a>`,
            showConfirmButton: false,
            timer: 3000
        });
    }

    function initLogin() {
        Swal.fire({
            title: '¡Inicia sesion para una mejor experiencia!',
            imageUrl: 'images/icon.png',
            text: 'Recuerda que eres muy importante para nosotros, por ello queremos brindarte una buena experiencia mientras nos visitas🤗.',
            html: `<h5><i>Si no posees una cuenta no podras disfrutar de los diversos beneficios que tenemos especialmente para ti. <a href='registro.jsp' >click aquí para crear una cuenta.</a></i></h5>
            <li><i>NOTA: Al ser consciente de toda la información que le hemos proporcionado usted aceptará cookies para una mejor experiencia en el sitio.</i></li>`,
            allowOutsideClick: false,
            confirmButtonText: '<i class="fa fa-thumbs-up"></i> Ok, entiendo'
        });
        document.cookie = "estado=activo; max-age=" + 60 * 60 * 24;
    }

    $("#config").click(function () {
        $('#myModalConfig').show("slow");
        $('#myModalConfig').modal({backdrop: 'static'});
        $('#cerrarModal').click(function () {
            $('#myModalConfig').modal('hide');
        });
    });

    $(function () {
        $('[data-toggle="tooltip"]').tooltip();
    });

    //carrito.jsp -----------------------------------------------------------------------------------

    $("#mensajeCompra").hide();

    if ($("#noProdu").text() === 'No tiene productos en su carrito') {
        $("#btnComprarCar").remove();
    }

    $("tr #btnDelete").click(function () {
        var idp = $(this).parent().find("#idp").val();
        Swal.fire({
            title: '¿Seguro que desea eliminar este articulo?',
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Acepto',
            cancelButtonText: 'cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                eliminar(idp);
                Swal.fire(
                        '¡Eliminado!',
                        'El articulo ha sido eliminado',
                        'success'
                        ).then((result) => {
                    if (result.isConfirmed) {
                        location.href = "controlador?accion=carrito";
                    }
                });
            }
        });
    });

    var nroPros = JSON.parse($("#nroPros").val());
    for (var i = 0; i < nroPros.length; i++) {
        $("tr #btnEdit" + nroPros[i]).click(function () {
            var txtBtn = $(this).attr("value");
            var idp = $(this).parents("tr").find("#idpro").val();
            if (txtBtn === 'Editar cantidad') {
                $(this).val('Confirmar');
                $("#cantidad" + idp).removeAttr('readonly');
                $("#cantidad" + idp).focus();
            } else {
                $(this).val('Editar cantidad');
                $("#cantidad" + idp).attr('readonly', 'yes');
                var validarBtns = true;
                for (var i = 0; i < nroPros.length; i++) {
                    if ($("tr #btnEdit" + nroPros[i]).val() === 'Confirmar') {
                        validarBtns = false;
                    }
                }
                var url = "controlador?accion=actualizarCantidad";
                var cantidad = $("#cantidad" + idp).val();
                $.ajax({
                    type: 'POST',
                    url: url,
                    data: "idp=" + idp + "&cantidad=" + cantidad,
                    success: function (data, textStatus, jqXHR) {
                        if (validarBtns) {
                            location.href = "controlador?accion=carrito";
                        }
                    }
                });
            }
        });
    }

    $("#btnComprarCar").click(function () {
        var validar = true;
        for (var i = 0; i < nroPros.length; i++) {
            var txtBtn = $("tr #btnEdit" + nroPros[i]).val();
            if (txtBtn === "Confirmar") {
                validar = false;
            }
        }
        if (validar) {
            $('#myModal').modal('show');

        } else {
            alert("Aun falta que confirmes algunos cambios");
        }
    });

    $("#myModal").on('submit', function (evt) {
        if ($("#mp").val() === "null") {
            alert("Debe completar todos los campos requeridos");
            evt.preventDefault();
        } else {
            comprar();
            $("#smp").fadeTo("slow", 0.5).hide("slow");
            evt.preventDefault();
        }
    });

    function comprar() {
        url = 'controlador?accion=comprar&idp=lista';
        $.ajax({
            async: true,
            type: 'POST',
            url: url,
            success: function (data) {
                $("#tablaCarrito").load(location.href + " #tablaCarrito");
                $("#btnComprarCar").fadeTo("slow", 0.5).hide("slow");
                $("#mensajeCompra").show('slow');
            }
        });
    }

    function eliminar(idp) {
        var url = "controlador?accion=delete";
        $.ajax({
            type: 'POST',
            url: url,
            data: "idp=" + idp,
            success: function (data, textStatus, jqXHR) {
            }
        });
    }

//registro.jsp -----------------------------------------------------------------------------------

});