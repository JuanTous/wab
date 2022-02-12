<%-- 
    Document   : tablero
    Created on : 13/10/2021, 08:31:13 PM
    Author     : Juan Sebastian Tous Triana
--%>

<%@page import="com.model.ventas"%>
<%@page import="com.modelDAO.tiendaDAO"%>
<%@page import="com.model.tienda"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.modelDAO.usuarioDAO"%>
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
        <link href="Styles/stylesTablero.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%
            if (!usuario.class.cast(request.getSession().getAttribute("sesion")).getPerfil().equals("Emprendedor")) {
                request.getRequestDispatcher("controlador?accion=home").forward(request, response);
            }
        %>
        <nav class="navbar sticky-top navbar-expand-lg navbar-dark">
            <a class="navbar-brand ml-sm-2" href="controladorEmp?accion=destroy">
                <img src="images/icon.png" height="87" width="90" />
                <b class="align-bottom" id="logo">WAB</b><span style="color: black">&#174;</span>
            </a>

            <div class="collapse navbar-collapse navbar-brand justify-content-end ml-sm-4" id="navbarSupportedContent">
                <ul class="navbar-nav mr-5">
                    <li class="nav-item" style="cursor: default">
                        <p class="nav-link">Ganancias: $ ${ganancias}</p>
                    </li>
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

        <%
            usuarioDAO udao = new usuarioDAO();
            tiendaDAO tdao = new tiendaDAO();

            int id = usuario.class.cast(request.getSession().getAttribute("sesion")).getIdUsuario();
            boolean validar = udao.verificarTienda(id);
        %>

        <c:choose>
            <c:when test="<%=validar%>">

                <div class="container">
                    <ol class="breadcrumb bg-light mb-4 mr-3 ml-3 mt-4 ">
                        <li class="breadcrumb-item">
                            <img src="controladorEmp?accion=listarLogoTienda&id=${sesion.getIdUsuario()}" alt="${tienda.getNombre()}" class="rounded" height="100"> 
                        </li>
                        <li class="ml-3">${tienda.getNombre()}</li>
                    </ol>

                    <div class="container mt-4">
                        <div class="row justify-content-center">
                            <table class="table">
                                <thead class="bg-secondary text-light">
                                    <tr>
                                        <th>FOTO</th>
                                        <th>NOMBRE</th>
                                        <th>DESCRIPCIÓN</th>
                                        <th>PRECIO</th>
                                        <th>INVENTARIO</th>
                                        <th>TIPO</th>
                                        <th>DESCUENTO</th>
                                        <th>HERRAMIENTAS</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <input type="hidden" id="nroPros" value="${idProductos}">
                                <c:choose>
                                    <c:when test="${contadorMisPro == 0}">
                                        <tr>
                                            <td id="noProdu" colspan="8"><h3 class="mt-5 mb-5"><b>Aun no has registrado algun producto ¡HAZLO YA!</b></h3></td>
                                        </tr>
                                        <tr class="bg-secondary">
                                            <td colspan="8"><a class="btn btn-outline-light" href="controladorEmp?accion=home">Crear producto</a></td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="pro" items="${misProductos}">
                                            <tr class="align-items-center">
                                                <td class="align-middle">
                                                    <img src="controlador?accion=listarIMG&id=${pro.getId()}" alt="${pro.getNombre()}" width="100">
                                                </td>
                                                <td class="align-middle">${pro.getNombre()}</td>
                                                <td class="align-middle">${pro.getDescripcion()}</td>
                                                <td class="align-middle">$${pro.getPrecio()}</td>    
                                                <td class="align-middle">${pro.getExistencias()}</td>
                                                <td class="align-middle">${pro.getTipo()}</td>  
                                                <td class="align-middle">${pro.getDescuento()}</td>  
                                                <td class="align-middle">
                                                    <input type="hidden" id="idp" value="${pro.getId()}">     
                                                    <input type="button" class="btn table-danger btn-block" id="btnDelete" value="Eliminar"></input>
                                                    <input type="button" class="btn table-primary btn-block" id="btnEdit${pro.getId()}" value="Editar"></input>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>
                        </div>
                        <input type="button" class="btn btn-success mt-1" value="Crear nuevo producto">
                    </div>

                    <div class="modal fade" id="myModalEdit" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel"><i class="fas fa-cogs mr-2"></i>Editar producto</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form action="controladorEmp" method="POST" enctype="multipart/form-data">
                                        <div class="card-body">
                                            <input type="hidden" id="idProEdi" name="idProEdi">
                                            <div class="row mb-2">
                                                <div class="col">
                                                    <label for="descripcionE">Descripción</label>
                                                    <input type="text" class="form-control" name="descripcionE" id="descripcionE" minlength="10" autocomplete="off" required>
                                                </div>

                                                <div class="col">
                                                    <label for="precioE">Precio</label>
                                                    <input type="number" class="form-control" name="precioE" id="precioE" autocomplete="off" min="10000" required>
                                                </div>
                                            </div>
                                            <div class="row mb-2">
                                                <div class="col">
                                                    <label for="inventarioE">Unidades disponibles</label>
                                                    <input type="number" class="form-control" name="inventarioE" id="inventarioE" autocomplete="off" min="1" required>
                                                </div>
                                                <div class="col">
                                                    <label for="descuentoE">Descuento</label>
                                                    <select name="descuentoE" id="descuentoE" class="form-control" required="true">
                                                        <option>Seleccione</option>
                                                        <option value="No">No</option>
                                                        <option value="Si">Si</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <input type="submit" class="btn btn-info btn-block" id="accion" name="accion" value="Editar">

                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="add" class="container col-sm-6 mt-5 mb-4">
                        <div class="card" style="border-radius: 1rem">
                            <form action="controladorEmp" class="" method="POST" enctype="multipart/form-data">
                                <div class="card-header"><h3>Agregar producto</h3></div>
                                <div class="card-body">
                                    <div class="form-group text-center">
                                        <label for="nombrePro" class="sz-1">Nombre del producto</label>
                                        <input type="text" class="form-control" name="nombrePro" id="nombrePro" autocomplete="off" required>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col">
                                            <label for="descripcion">Descripción</label>
                                            <input type="text" class="form-control" name="descripcion" id="descripcion" minlength="10" autocomplete="off" required>
                                        </div>

                                        <div class="col">
                                            <label for="precio">Precio</label>
                                            <input type="number" class="form-control" name="precio" id="precio" autocomplete="off" min="10000" required>
                                        </div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col">
                                            <label for="foto">Foto</label>
                                            <input type="file" name="foto" id="foto" accept="image/png,image/jpeg" class="form-control" required>       
                                        </div>
                                        <div class="col">
                                            <label for="inventario">Unidades disponibles</label>
                                            <input type="number" class="form-control" name="inventario" id="inventario" autocomplete="off" min="1" required>
                                        </div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col">
                                            <label for="descuento">Descuento</label>
                                            <select name="descuento" id="descuento" class="form-control" required="true">
                                                <option>Seleccione</option>
                                                <option value="No">No</option>
                                                <option value="Si">Si</option>
                                            </select>
                                        </div>
                                        <div class="col">
                                            <label for="tipo">Tipo de producto</label>
                                            <select name="tipo" id="tipo" class="form-control" required="true">
                                                <option>Seleccione</option>
                                                <option value="Anillos">Anillos</option>
                                                <option value="Aretes">Aretes</option>
                                                <option value="Cadenas">Cadenas</option>
                                                <option value="Pulseras">Pulseras</option>
                                                <option value="Relojes">Relojes</option>
                                                <option value="Otros">Otros</option>
                                            </select>
                                        </div>
                                    </div> 
                                </div>
                                <div class="card-footer text-center">
                                    <input type="submit" class="btn btn-info btn-block" name="accion" value="Crear">
                                </div> 
                            </form> 
                        </div>
                    </div>



                </c:when>
                <c:otherwise>
                    <div class="container">
                        <ol class="breadcrumb bg-light mb-4 mr-3 ml-3 mt-4">
                            <li class="mr-2">Cree una tienda para comercializar sus productos.</li>
                        </ol>
                        <div class="container addStore mt-5 mb-5">
                            <div class="column text-success">
                                <div class="card">
                                    <div class="animacion"><i class="fas fa-store"></i></div> 
                                    <span class="animacion">Click para crear</span> 
                                </div>
                            </div>
                        </div>
                        <div class="alert alert-warning" role="alert">
                            Tenga en cuenta que solo es posible crear una tienda por usuario.
                        </div>
                    </div>

                    <div class="modal fade" id="myModalCreateStore" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel"><i class="fas fa-scroll mr-2"></i>Mi negocio</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form action="controladorEmp" class="" method="POST" enctype="multipart/form-data">
                                        <div class="form-group">
                                            <label for="nombre">Nombre de la tienda</label>
                                            <input type="text" class="form-control" name="nombre" id="nombre" autocomplete="off" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="nit">NIT</label>
                                            <input type="text" class="form-control" name="nit" id="nit" pattern="^[0-9]{3}\s[0-9]{3}\s[0-9]{3}\s-\s[0-9]{1}$" title="000 000 000 - 0" autocomplete="off" required>
                                        </div>

                                        <div class="form-group">
                                            <label for="logotipo">Logotipo <span class="text-secondary">(solo acepta formato png y jpeg)</span></label>
                                            <input type="file" name="logotipo" id="logotipo" accept="image/png,image/jpeg" class="form-control">       
                                        </div>
                                        <div class="form-group">
                                            <label for="ubicacion">Ubicacion <span class="text-secondary">(en caso que tenga un local fisico)</span></label>
                                            <input type="text" class="form-control" name="ubicacion" id="ubicacion" autocomplete="off">
                                        </div>
                                        <input type="submit" class="btn btn-info" name="accion" value="Montar">
                                    </form>
                                </div>
                            </div>
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
                                <li class="navbar-brand mb-0 h1 ml-4"><a class="text-dark" data-toggle="tab" href="#misVentas">Mis ventas</a></li>
                            </ul>

                            <div class="dropdown-divider mt-1"></div>

                            <div class="tab-content">
                                <div id="editarDatos" class="tab-pane fade show active">
                                    <div class="card mb-4 mt-4" style="border-radius: inherit !important">
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

                                <div id="misVentas" class="tab-pane fade">
                                    <div class="card mb-4 mt-4" style="border-radius: inherit !important">
                                        <table class="table" id="tablaVentas">
                                            <div class="card-header">
                                                <thead class="bg-secondary text-light">
                                                    <tr>
                                                        <th>VENTA</th>
                                                        <th>CLIENTE</th>
                                                        <th>PRODUCTO</th>
                                                        <th>FECHA</th>
                                                        <th>HORA</th>
                                                        <th>CANTIDAD</th>
                                                        <th>TOTAL</th>
                                                    </tr>
                                                </thead>
                                            </div>
                                            <tbody>
                                                <c:choose>
                                                    <c:when test="${misVentasContador == 0}">
                                                        <tr>
                                                            <td colspan="4"><h3 class="mt-5 mb-5"><b>Aun no ha realzado alguna venta</b></h3></td>
                                                        </tr>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <%
                                                            if (usuario.class.cast(request.getSession().getAttribute("sesion")) != null) {
                                                                List<ventas> misVentas = List.class.cast(request.getSession().getAttribute("misVentas"));

                                                                for (int i = 0; i < misVentas.size(); i++) {

                                                                    int idv = misVentas.get(i).getIdVenta();
                                                                    String cliente = misVentas.get(i).getUsuario().getNombres() + " " + misVentas.get(i).getUsuario().getApellidos();
                                                                    String producto = misVentas.get(i).getProducto();
                                                                    String fecha = misVentas.get(i).getFecha();
                                                                    String hora = misVentas.get(i).getHora();
                                                                    int cantidad = misVentas.get(i).getCantidad();
                                                                    int total = misVentas.get(i).getMonto();
                                                        %>
                                                        <tr>
                                                            <td><%=idv%></td>
                                                            <td><%=cliente%></td>
                                                            <td><%=producto%></td>
                                                            <td><%=fecha%></td>
                                                            <td><%=hora%></td>
                                                            <td><%=cantidad%></td>
                                                            <td><% out.print(total + " pesos"); %></td>
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
            <input type="hidden" id="nroPros" value="${idProductos}">
            <br class="mb-5">

            <script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
            <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
            <script src="Functions/functionsTablero.js" type="text/javascript"></script>
    </body>
</html>