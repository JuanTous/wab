<%-- 
    Document   : ofertas
    Created on : 25/09/2021, 07:26:01 PM
    Author     : Juan Sebastian Tous Triana
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.model.producto"%>
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

        <div class="container bg-dark mt-5" id="containerO">
            <div id="carouselExampleIndicators" class="carousel slide text-center" data-ride="carousel">
                <ol class="carousel-indicators mb-4">
                    <%
                        List<producto> ofertados = new ArrayList();
                        ofertados = List.class.cast(request.getAttribute("ofertados"));
                        for (int i = 0; i < ofertados.size(); i++) {
                    %>
                    <li data-target="#carouselExampleIndicators" data-slide-to="<%=i%>" class="mb-4 <% if (i == 0) {
                            out.print("active");
                        }%>"></li>
                        <% } %>
                </ol>

                <div class="carousel-inner" role="listbox">
                    <%
                        for (int i = 0; i < ofertados.size(); i++) {
                            int id = ofertados.get(i).getId();
                            String alt = ofertados.get(i).getNombre();
                            String descuento = ofertados.get(i).getDescuento();
                    %>
                    <div class="carousel-item <% if (i == 0) {
                            out.print("active");
                        }%>">
                        <div class="text-light mb-4 mt-4"><h3 style="font-family: verdana"><%=alt%> con el <p style="font-size: 2.5rem; font-weight: bold; font-style: italic"><%=descuento%>% de descuento</p></h3></div>
                        <img class="text-light mb-4" src="controlador?accion=listarIMG&id=<%=id%>" alt="<%=alt%>. *Por favor recargar la pagina para una mejor visualizaciòn*" style="border-radius: 10px" height="430">
                        <div class="">
                            <input type="hidden" id="idp<%=id%>" value="<%=id%>"a>
                            <a href="#" id="btnAggCarr<%=i + 1%>" class="btn btn-info mt-4">Agregar al carrito</a>
                        </div>
                    </div>
                    <% }%>
                </div>

                <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>

            <input type="hidden" id="nrop" value="${nroProductos}">
            <i id="sesion" style="visibility: hidden">${sesionJSON}</i>
            <br class="mb-5">

            <script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
            <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
            <script src="Functions/functions.js" type="text/javascript"></script>
    </body>
</html>
