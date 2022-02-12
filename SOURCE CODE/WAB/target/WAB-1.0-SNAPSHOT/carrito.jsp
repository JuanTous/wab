<%-- 
    Document   : compras
    Created on : 9/09/2021, 09:02:21 PM
    Author     : Juan Sebastian Tous Triana
--%>

<%@page import="com.model.compras"%>
<%@page import="com.model.compras"%>
<%@page import="java.util.List"%>
<%@page import="com.model.usuario"%>
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
        <nav class="navbar sticky-top navbar-expand-lg navbar-dark">
            <a class="navbar-brand ml-sm-2" href="controlador?accion=home">
                <img src="images/icon.png" height="87" width="90" />
                <b class="align-bottom" id="logo">WAB</b><span style="color: black">&#174;</span>
            </a>

            <div class="collapse navbar-collapse navbar-brand ml-sm-4" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto" id="ul_nav">
                    <li class="nav-item">
                        <a class="nav-link" href="controlador?accion=home">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="controlador?accion=home">
                            Seguir comprando <i class="fas fa-shopping-cart"></i>
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

        <div class="container mt-4">
            <h1>Mi carrito</h1>
            <br>
            <div class="row">
                <div class="col-sm-8">
                    <table class="table" id="tablaCarrito">
                        <thead class="bg-secondary text-light">
                            <tr>
                                <th>ITEM</th>
                                <th>NOMBRE</th>
                                <th>DESCRIPCIÓN</th>
                                <th>PRECIO</th>
                                <th>CANTIDAD</th>
                                <th>SUBTOTAL</th>
                                <th>HERRAMIENTAS</th>
                            </tr>
                        </thead>
                        <tbody>
                        <input type="hidden" id="nroPros" value="${idProductos}">
                        <c:choose>
                            <c:when test="${contador == 0}">
                                <tr>
                                    <td id="noProdu" colspan="7"><h3 class="mt-5 mb-5"><b>No tiene productos en su carrito</b></h3></td>
                                </tr>
                                <tr class="bg-secondary">
                                    <td colspan="7"><a class="btn btn-outline-light" href="controlador?accion=home">Ir al Home</a></td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="car" items="${carrito}">
                                    <tr>
                                        <td>${car.getItem()}</td>
                                        <td>${car.getNombre()}</td>
                                        <td><img src="controlador?accion=listarIMG&id=${car.getIdProducto()}" alt="${car.getNombre()}" width="100" height="100">
                                        </td>
                                        <td>$${car.getPrecioCompra()}</td>
                                        <td>
                                            <input type="hidden" id="idpro" value="${car.getIdProducto()}">   
                                            <input type="number" id="cantidad${car.getIdProducto()}" value="${car.getCantidad()}" class="form-control text-center bg-light" min="1" max="${car.getExistencias()}" readonly="yes">
                                        </td>
                                        <td>$${car.getSubTotal()}</td>
                                        <td>
                                            <input type="hidden" id="idp" value="${car.getIdProducto()}">     
                                            <input type="button" class="btn table-danger btn-block" id="btnDelete" value="Eliminar"></input>
                                            <input type="button" class="btn table-primary btn-block" id="btnEdit${car.getIdProducto()}" value="Editar cantidad"></input>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
                <div class="col-sm-4">
                    <div class="card">
                        <div class="card-header text-center text-light bg-secondary">
                            <h3>Recibo de compras</h3>
                        </div>
                        <div class="card-body">
                            <label>Titular</label>
                            <input type="text" readonly="" value="${sesion.getNombres()} ${sesion.getApellidos()}" class="form-control">
                            <label>Total a pagar</label>
                            <input type="text" readonly="" value="COP. $${totalPagar}" class="form-control">
                        </div>
                        <div class="card-footer">
                            <a id="btnComprarCar" href="#" class="btn btn-danger btn-block">Generar compra</a>
                            <label id="mensajeCompra" class="mt-3">Compra exitosa.</label>
                        </div>
                    </div>                                          
                </div>
            </div>
        </div>

        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" >
                <form id="metodoPago" action="#">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" id="myModalLabel"><i class="far fa-credit-card mr-2"></i>Metodo de pago</h4>
                        </div>
                        <div class="modal-body">
                            <div class="row ">
                                <div class="col-md-12">
                                    <input type="number" class="form-control" placeholder="Digite numero de tarjeta" pattern="[0-9]{10}" min="1" required="true"/>
                                </div>
                            </div>
                            <div class="row mt-2">
                                <div class="col-md-3 col-sm-3 col-xs-3">
                                    <span class="help-block text-muted" >Codigo</span>
                                    <input type="number" class="form-control" placeholder="CCV" pattern="[0-9]{3}" min="1" required="true"/>
                                </div>

                                <div class="ml-4">
                                    <span class="help-block text-muted small-font" >Mes y año de expiración</span>
                                    <input type="month" class="form-control" placeholder="MMYY" required="true"/>
                                </div>
                            </div>
                            <div class="row ">
                                <div class="col-md-12 pad-adjust mt-2">
                                    Seleccione la entidad
                                    <select class="btn custom-select" name="mp" id="mp" required="true">
                                        <option value="null">...</option>
                                        <option value="aval">GRUPO AVAL</option>
                                        <option value="bancolombia">BANCOLOMBIA</option>
                                        <option value="bbva">BBVA</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger btn-block" data-dismiss="modal">Cerrar</button>
                            <input type="submit" id="smp" class="btn btn-warning btn-block" value="Pagar"></button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div class="modal bd-example-modal-lg" id="myModalConfig" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog modal-lg">

                <div class="modal-content">
                    <div class="container">
                        <span id="cerrarModal" class="btn close" aria-hidden="true">&times;</span>

                        <ul class="nav d-flex justify-content-center mt-4">
                            <li class="navbar-brand mb-0 h1 mr-4"><a class="text-dark" data-toggle="tab" href="#editarDatos">Editar mis datos</a></li>
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

        <script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="Functions/functions.js" type="text/javascript"></script>
    </body>
</html>
