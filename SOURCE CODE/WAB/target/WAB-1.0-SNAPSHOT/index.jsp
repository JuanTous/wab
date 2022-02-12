<%-- 
    Document   : index
    Created on : 6/09/2021, 08:29:06 PM
    Author     : Juan Sebastian Tous Triana
--%>
<%@page import="com.model.usuario"%>
<%@page import="com.model.compras"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>WAB</title>
        <link rel="icon" href="images/favicon.png">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous"">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link href="Styles/styles.css" rel="stylesheet" type="text/css"/>
        <style>
            .dropdown-menu {
                top: 130%;
                left: -3rem;

            }
            .dropdown-toggle::before{
                display: inline-block;
                width: 0;
                height: 0;
                margin-left: .255em;
                vertical-align: .255em;
                content: "";
                border-top: .3em solid;
                border-right: .3em solid transparent;
                border-bottom: 0;
                border-left: .3em solid transparent;
            }
            .dropdown-toggle::after {
                border-right: .0em solid transparent;
                border-left: .0em solid transparent;
            }
        </style>
    </head>
    <body>
        <%
            if (usuario.class.cast(request.getSession().getAttribute("sesion")) != null) {
                if (usuario.class.cast(request.getSession().getAttribute("sesion")).getPerfil().equals("Emprendedor")) {
                    request.getRequestDispatcher("controladorEmp?accion=home").forward(request, response);
                }
            }
        %>
        <nav class="navbar sticky-top navbar-expand-lg navbar-dark">
            <a class="navbar-brand ml-sm-2" href="controlador?accion=destroy">
                <img src="images/icon.png" height="87" width="90" />
                <b class="align-bottom" id="logo">WAB</b><span style="color: black">&#174;</span>
            </a>

            <div class="collapse navbar-collapse navbar-brand ml-sm-4" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto" id="ul_nav">
                    <li class="nav-item">
                        <a class="nav-link" href="controlador?accion=home">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="controlador?accion=carrito">
                            <span id="actCon"> Mi carrito <span class="badge badge-info">${contador}</span></span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="controlador?accion=ofertas">Ofertas</a>
                    </li>

                </ul>
                <form class="form-inline my-2 my-lg-0" action="controlador?accion=buscar" method="POST">
                    <li class="navbar-nav">
                        <a id="ordenar" class="nav-link" href="#">Filtrar<i class="fas fa-search ml-2"></i></a>
                    </li>
                    <input type="hidden" id="tipoBus" name="tipoBus" id="buscador" value="null">
                    <input class="form-control mr-sm-2" type="search" name="buscador" id="buscador" placeholder="Buscar en WAB" size="14" autocomplete="off">
                    <input type="submit"class="btn btn-outline-info my-2 my-sm-0" value="Buscar">
                </form>
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle ml-4 hover" href="#" id="identificacion" style="font-weight: bold" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fas fa-user"></i>&nbsp;Ingresar
                        </a>
                        <div class="container dropdown-menu bg-light text-center" aria-labelledby="navbarDropdown" id="barraId">
                            <div class="form-group mt-2">
                                <span class="text-center text-dark">Completar<i class="fas fa-arrow-down ml-2"></i></span>
                                <div class="dropdown-divider"></div>
                                <form action="controlador?accion=login" method="POST">
                                    <div class="form-group mt-4">
                                        <input type="email" class="btn btn-block btn-light form-control" name="user" placeholder="Email" pattern=".+\.com" title="Ejemplo@email.com" required>
                                        <input type="password" class="btn btn-block btn-light form-control" name="pass" placeholder="Contraseña" required>
                                        <br>
                                        <input type="submit" class="btn btn-outline-success" value="Entrar">
                                    </div>
                                </form>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item text-info btn btn-outline-light mt-3" href="registro.jsp">Registrarse</a>
                            </div> 
                            <div class="dropdown-divider"></div>
                            <span style="color: #e6e6e6">WAB&#174;</span>
                        </div>
                    </li>
                </ul>
            </div>
        </nav>

        <c:choose>
            <c:when test="${contadorPro == 0}">
                <div class="ml-sm-5 mb-4 mt-5">
                    <div class="container card">
                        <div class="card-header text-center bg-white">
                            <br>
                        </div>
                        <div class="card-body text-center">
                            <img src="images/notFound.jpg" alt="Producto no encontrado" width="300" height="280">
                        </div>
                        <div class="card-footer text-center bg-white">
                            <div>
                                <div class="alert alert-secondary alert-dismissible fade show" role="alert">
                                    <h5>Lastimosamente el sistema no pudo encontrar la solicitud especificada.</h5><i>Intente de nuevo mediante palabras claves que sean semejantes al producto que se requiere.</i> 
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <a href="controlador?accion=home" class="btn btn-outline-danger">Volver</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="container mt-5">
                    <div class="row">
                        <input type="hidden" id="nrop" value="${nroProductos}">
                        <c:forEach var="p" items="${productos}">
                            <div class="col-sm-4 mb-4" id="ampliar">
                                <div class="card">
                                    <div class="card-header text-center">
                                        <c:choose>
                                            <c:when test="${p.getDescuento() != 'No'}">
                                                <div class="badge text-white position-absolute" style="top: 0.7rem; left: 0.9rem; background-color: #2b638f;" data-toggle="tooltip" data-placement="top" title="Agregue para visualizar el descuento">- ${p.getDescuento()}%</div>
                                            </c:when>
                                        </c:choose>
                                        <h4 id="titulo" class="mt-2">${p.getNombre()}</h4>
                                    </div>
                                    <div class="card-body text-center">
                                        <img src="controlador?accion=listarIMG&id=${p.getId()}" alt="${p.getNombre()}" id="imagen" class="rounded" data-toggle="tooltip" data-placement="bottom" title="Click para ampliar" width="200" height="180">
                                    </div>
                                    <div class="card-footer text-center">
                                        <label id="descripcion">${p.getDescripcion()}</label>
                                        <h5 id="precio">COP $${p.getPrecio()}</h5>
                                        <div>
                                            <input type="hidden" id="idp${p.getId()}" value="${p.getId()}">
                                            <a href="#" id="btnAggCarr" class="btn btn-secondary">Agregar al carrito&nbsp;<i class="fas fa-cart-plus">&nbsp;</i></a>
                                            <a href="#" id="btnComprarInd" class="btn btn-success">Comprar &nbsp;<i class="fas fa-credit-card"></i>&nbsp;</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>         
                    </div>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="modal bd-example-modal-lg" id="myModalConfig" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog modal-lg">

                <div class="modal-content">
                    <div class="container">
                        <span id="cerrarModal" class="btn close" aria-hidden="true">&times;</span>

                        <ul class="nav d-flex justify-content-center mt-4">
                            <li class="navbar-brand mb-0 h1 mr-4"><a class="text-dark" data-toggle="tab" href="#editarDatos">Mis datos</a></li>
                            <li class="navbar-brand mb-0 h1 ml-4"><a class="text-dark" data-toggle="tab" href="#misCompras">Mis compras</a></li>
                        </ul>

                        <div class="dropdown-divider mt-1"></div>

                        <div class="tab-content">
                            <div id="editarDatos" class="tab-pane fade show active">
                                <div class="card mb-4 mt-4">
                                    <table class="table" id="tablaDatos">
                                        <div class="card-header">
                                            <thead class="bg-secondary text-light">
                                                <tr>
                                                    <th>NOMBRES</th>
                                                    <th>APELLIDOS</th>
                                                    <th>DNI</th>
                                                    <th>DIRECCIÓN</th>
                                                    <th>EMAIL</th>
                                                </tr>
                                            </thead>
                                        </div>
                                        <tbody>
                                            <tr>
                                                <td>${sesion.getNombres()}</td>
                                                <td>${sesion.getApellidos()}</td>
                                                <td>${sesion.getDni()}</td>
                                                <td>${sesion.getDireccion()}</td>
                                                <td>${sesion.getEmail()}</td>
                                            </tr>
                                        </tbody>
                                    </table> 
                                    <div class="card-footer"></div>
                                </div>
                            </div>

                            <div id="misCompras" class="tab-pane fade">
                                <div class="card mb-4 mt-4">
                                    <table class="table" id="tablaCompras">
                                        <div class="card-header">
                                            <thead class="bg-secondary text-light">
                                                <tr>
                                                    <th>NRO DE COMPRA</th>
                                                    <th>FECHA</th>
                                                    <th>HORA</th>
                                                    <th>TOTAL</th>
                                                </tr>
                                            </thead>
                                        </div>
                                        <tbody>
                                            <c:choose>
                                                <c:when test="${misComprasContador == 0}">
                                                    <tr>
                                                        <td colspan="4"><h3 class="mt-5 mb-5"><b>Aun no ha realzado alguna compra</b></h3></td>
                                                    </tr>
                                                </c:when>
                                                <c:otherwise>
                                                    <%
                                                        if (usuario.class.cast(request.getSession().getAttribute("sesion")) != null) {
                                                            List<compras> misCompras = List.class.cast(request.getSession().getAttribute("misCompras"));

                                                            for (int i = 0; i < misCompras.size(); i++) {

                                                                int id = misCompras.get(i).getIdCompra();
                                                                String fecha = misCompras.get(i).getFechaCompra();
                                                                String hora = misCompras.get(i).getHoraCompra();
                                                                int total = misCompras.get(i).getMonto();
                                                    %>
                                                    <tr>
                                                        <td><%=id%></td>
                                                        <td><%=fecha%></td>
                                                        <td><%=hora%></td>
                                                        <td><% out.print("COP " + total); %></td>
                                                    </tr>

                                                    <% }
                                                        }%>
                                                </c:otherwise>
                                            </c:choose>
                                        </tbody>
                                    </table> 
                                    <div class="card-footer"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <i id="sesion" style="visibility: hidden">${sesionJSON}</i>
        <br class="mb-5">

        <script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="Functions/functions.js" type="text/javascript"></script>
    </body>
</html>
