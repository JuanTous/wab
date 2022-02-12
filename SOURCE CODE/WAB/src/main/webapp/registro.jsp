<%-- 
    Document   : registro
    Created on : 9/09/2021, 09:03:13 PM
    Author     : Juan Sebastian Tous Triana
--%>

<%@page import="com.model.usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>WAB</title>
        <link rel="icon" href="images/favicon.png">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous"">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link href="Styles/styleLogin.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%
        if (usuario.class.cast(request.getSession().getAttribute("sesion")) != null) {
                request.getRequestDispatcher("controlador?accion=home").forward(request, response);
            }
        %>
        <nav class="navbar sticky-top navbar-expand-lg navbar-dark">
            <a class="navbar-brand ml-sm-2" href="controlador?accion=home">
                <img src="images/iconWhite.png" height="87" width="90" />
                <b class="align-bottom" id="logo">WAB</b><span style="color: white">&#174;</span>
            </a>

            <div class="collapse navbar-collapse navbar-brand ml-sm-5" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto" id="ul_nav">
                    <li class="nav-item">
                        <a class="nav-link" href="controlador?accion=home">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="controlador?accion=ofertas">Ofertas</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="identificacion" style="font-weight: bold" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            &nbsp;Si ya tiene una cuenta ingrese aquí <i class="fas fa-user"></i>
                        </a>
                        <div class="container dropdown-menu bg-light text-center mt-2 ml-4" style="height: 45px" aria-labelledby="navbarDropdown" id="barraId">
                            <div class="form-group">
                                <span class="text-center text-white">Completar<i class="fas fa-arrow-down ml-2"></i></span>
                                <div class="dropdown-divider"></div>
                                <form action="controlador?accion=login" method="POST">
                                    <div class="form-group mt-4">
                                        <input type="email" class="btn btn-block btn-light form-control" name="user" placeholder="Email" pattern=".+\.com" title="Ejemplo@email.com" required>
                                        <input type="password" class="btn btn-block btn-light form-control" name="pass" placeholder="Contraseña" required>
                                        <br>
                                        <input type="submit" class="btn btn-outline-info" value="Entrar">
                                    </div>
                                </form>
                            </div> 
                            <div class="dropdown-divider"></div>
                            <span style="color: #e6e6e6">WAB&#174;</span>
                            <div class="dropdown-divider"></div>
                        </div>
                        </div>
                    </li>
                </ul>
            </div>
        </nav>

        <i id="sesion" style="visibility: hidden">${sesionJSON}</i>


        <div class="container">
            <header class="heading"> Formulario de registro</header>
            <form id="fm" action="controlador?accion=registrar" method="POST">
                <div class="row">
                    <div class="col-sm-5">
                        <div class="row">
                            <div class="col-xs-4">
                                <label class="nombre ml-4">Primer nombre </label> </div>
                            <div class="col-xs-8 ml-4">
                                <input type="text" name="pnombre" id="pnombre" class="form-control" autocomplete="no" required>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-5">
                        <div class="row">
                            <div class="col-xs-4">
                                <label class="nombre ml-4">Segundo nombre </label> </div>
                            <div class="col-xs-8 ml-4">
                                <input type="text" name="snombre" id="snombre" class="form-control" autocomplete="no">
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-5">
                        <div class="row">
                            <div class="col-xs-4">
                                <label class="apellido ml-4">Primer apellido </label></div>
                            <div class="col-xs-8 ml-4">	 
                                <input type="text" name="papellido" id="papellido" class="form-control" autocomplete="no" required>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-5">
                        <div class="row">
                            <div class="col-xs-4">
                                <label class="apellido ml-4">Segundo apellido </label></div>
                            <div class="col-xs-8 ml-4">	 
                                <input type="text" name="sapellido" id="sapellido" class="form-control" autocomplete="no" required>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-5">
                        <div class="row">
                            <div class="col-xs-4">
                                <label class="mail ml-4 mr-5" >Email </label></div>
                            <div class="col-xs-8 ml-4">	 
                                <input type="email" name="email"  id="email" pattern=".+\.com" title="Ejemplo@email.com" class="form-control" autocomplete="no" required>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-5">
                        <div class="row">
                            <div class="col-xs-4">
                                <label class="pass ml-4">Contraseña </label></div>
                            <div class="col-xs-8 ml-4">
                                <input type="password" name="password" id="password" pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$" title="Mínimo ocho caracteres, al menos una letra y un número" class="form-control" autocomplete="no" required>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-5">
                        <div class="row">
                            <div class="col-xs-4">
                                <label class="dni mr-5 ml-4">DNI </label></div>
                            <div class="col-xs-8 ml-4">
                                <input type="text" name="dni" id="dni" pattern="[0-9]{10}" class="form-control" required>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-5">
                        <div class="row">
                            <div class="col-xs-4">
                                <label class="direccion ml-4">Direccion </label></div>
                            <div class="col-xs-8 ml-4">
                                <input type="text" name="direccion" id="direccion" class="form-control" autocomplete="no" required>
                            </div>
                        </div>
                    </div>

                    <div class="input-group mt-5 mr-5">
                        <div class="input-group-prepend ml-4">
                            <label class="input-group-text bg-info text-white" for="perfil">Elija el tipo de usuario.</label>
                        </div>
                        <select class="custom-select mr-5" name="perfil" id="perfil" required="true">
                            <option>Seleccione</option>
                            <option value="Usuario">Usuario</option>
                            <option value="Emprendedor">Emprendedor</option>
                        </select>
                    </div>
                    <label id="mensajeRegistro" class="text-white ml-4 mt-3">*Debe seleccionar el tipo de usuario*</label>
                    <input type="submit" id="subm" value="Registrarme" class="btn btn-warning mt-5 ml-4 text-center">
                </div>	 
            </form>
        </div>

        <footer>
            <div class="d-flex flex-column flex-md-row text-center text-md-start mt-3 justify-content-between px-3 px-xl-5">
                <div class="text-white mb-3 mb-md-0">
                    Copyright © 2021. All rights reserved.
                </div>
                <div>
                    <a href="https://www.facebook.com/tousjuan01/" target="blank" class="text-white me-4">
                        <i class="fab fa-facebook-f ml-2"></i>
                    </a>
                    <a href="https://twitter.com/JuanTousT" target="blank" class="text-white me-4">
                        <i class="fab fa-twitter ml-2"></i>
                    </a>
                    <a href="https://www.instagram.com/tous10/?hl=es" target="blank" class="text-white me-4">
                        <i class="fab fa-instagram ml-2"></i>
                    </a>
                    <a href="https://www.linkedin.com/in/juan-sebastian-tous-triana-8800b2210/" target="blank" class="text-white">
                        <i class="fab fa-linkedin-in ml-2"></i>
                    </a>
                </div>
            </div>
        </footer>

        <script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="Functions/functions.js" type="text/javascript"></script>
    </body>
</html>
