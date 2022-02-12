/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controlador;

import com.google.gson.JsonObject;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;
import com.model.carrito;
import com.model.compras;
import com.model.producto;
import com.model.usuario;
import com.modelDAO.comprasDAO;
import com.modelDAO.productoDAO;
import com.modelDAO.usuarioDAO;

/**
 *
 * @author Juan Sebastian Tous Triana
 */
public class controlador extends HttpServlet {

    usuario usu;
    producto pro;
    carrito car;
    JsonObject json = new JsonObject();
    usuarioDAO udao = new usuarioDAO();
    productoDAO pdao = new productoDAO();
    comprasDAO cdao = new comprasDAO();
    List<producto> productos = new ArrayList<>();
    List<carrito> listaCarrito = new ArrayList<>();
    List<compras> misCompras = new ArrayList<>();
    int cantidad = 1;
    int item;
    int totalPagar;
    int idp;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        productos = pdao.listar();

        switch (accion) {
            case "home":
                if ((usuario.class.cast(request.getSession().getAttribute("sesion")) != null) && (!listaCarrito.isEmpty())) {
                    misCompras = cdao.misCompras(usuario.class.cast(request.getSession().getAttribute("sesion")).getIdUsuario());
                    request.getSession().setAttribute("misCompras", misCompras);
                    request.getSession().setAttribute("misComprasContador", misCompras.size());
                    request.setAttribute("contador", List.class.cast(request.getSession().getAttribute("carrito")).size());
                } else {
                    request.setAttribute("contador", 0);
                }
                request.setAttribute("productos", productos);
                request.setAttribute("nroProductos", productos.size());
                request.getRequestDispatcher("index.jsp").forward(request, response);
                break;
            case "login":
                usu = new usuario();
                String user = request.getParameter("user");
                String pass = request.getParameter("pass");
                usu = udao.validarSesion(user, pass);
                json = udao.retornarJSON(usu);
                misCompras = cdao.misCompras(usu.getIdUsuario());
                request.getSession().setAttribute("misCompras", misCompras);
                request.getSession().setAttribute("misComprasContador", misCompras.size());
                request.getSession().setAttribute("sesion", usu);
                //   request.setAttribute("misComprasCon", misCompras.size());
                request.getSession().setAttribute("sesionJSON", json);
                if (usu.getPerfil().equals("Usuario")) {
                    request.getRequestDispatcher("controlador?accion=home").forward(request, response);
                } else {
                    response.sendRedirect("controladorEmp?accion=home");
                }
                break;
            case "registrar":
                int dni = Integer.parseInt(request.getParameter("dni").trim());
                String nombres;
                if (request.getParameter("snombre").equals("no_tiene")) {
                    nombres = request.getParameter("pnombre").trim();
                } else {
                    nombres = request.getParameter("pnombre").trim() + " " + request.getParameter("snombre").trim();
                }
                String apellidos = request.getParameter("papellido").trim() + " " + request.getParameter("sapellido").trim();
                String direccion = request.getParameter("direccion");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String perfil = request.getParameter("perfil");
                usu = new usuario();
                usu.setNombres(nombres);
                usu.setApellidos(apellidos);
                usu.setDireccion(direccion);
                usu.setEmail(email);
                usu.setPerfil(perfil);
                usu.setDni(dni);
                boolean validar = udao.registrar(nombres, apellidos, email, password, dni, direccion, perfil);
                JOptionPane.showMessageDialog(null, validar);
                if (validar) {
                    json = udao.retornarJSON(usu);
                    request.getSession().setAttribute("sesion", usu);
                    request.getRequestDispatcher("controlador?accion=home").forward(request, response);
                } else {
                    response.sendRedirect("registro.jsp");
                }
                break;
            case "destroy":
                usu = null;
                json = null;
                listaCarrito.clear();
                request.getSession().removeAttribute("sesion");
                request.getSession().removeAttribute("carrito");
                request.getSession().removeAttribute("misCompras");
                request.getSession().removeAttribute("misComprasContador");
                request.getSession().removeAttribute("sesionJSON");  request.getSession().invalidate();
                request.getRequestDispatcher("controlador?accion=home").forward(request, response);
                break;
            case "comprar":
                if (usuario.class.cast(request.getSession().getAttribute("sesion")) == null) {
                    request.getRequestDispatcher("registro.jsp").forward(request, response);
                } else {
                    String id = request.getParameter("idp");
                    if (id.equals("lista")) {
                        cdao.comprar(listaCarrito, usuario.class.cast(request.getSession().getAttribute("sesion")).getIdUsuario());
                        listaCarrito.clear();
                        request.getSession().removeAttribute("carrito");
                    } else {
                        listaCarrito.clear();
                        pro = pdao.listarId(Integer.parseInt(id));
                        item = 1;
                        car = new carrito();
                        if (pro.getDescuento().equals("No")) {
                            car.setItem(item);
                            car.setIdProducto(pro.getId());
                            car.setNombre(pro.getNombre());
                            car.setIdTienda(pro.getIdTienda());
                            car.setNombreTienda(pro.getNombreTienda());
                            car.setDescripcion(pro.getDescripcion());
                            car.setPrecioCompra(pro.getPrecio());
                            car.setCantidad(cantidad);
                            car.setSubTotal(cantidad * pro.getPrecio());
                            car.setExistencias(pro.getExistencias());
                            car.setDescuento(pro.getDescuento());
                            car.setTipo(pro.getTipo());
                            listaCarrito.add(car);
                            totalPagar = car.getSubTotal();
                            request.getSession().setAttribute("carrito", listaCarrito);
                            request.setAttribute("idProductos", "[" + id + "]");
                            request.setAttribute("totalPagar", totalPagar);
                            request.getRequestDispatcher("controlador?accion=carrito").forward(request, response);
                        } else {
                            car.setItem(item);
                            car.setIdProducto(pro.getId());
                            car.setNombre(pro.getNombre());
                            car.setIdTienda(pro.getIdTienda());
                            car.setNombreTienda(pro.getNombreTienda());
                            car.setDescripcion(pro.getDescripcion());
                            car.setPrecioCompra(pro.getPrecio());
                            car.setCantidad(cantidad);
                            car.setSubTotal(cantidad * cdao.aplicarDescuento(Integer.parseInt(pro.getDescuento()), pro.getPrecio()));
                            car.setExistencias(pro.getExistencias());
                            car.setDescuento(pro.getDescuento());
                            car.setTipo(pro.getTipo());
                            listaCarrito.add(car);
                            totalPagar = car.getSubTotal();
                            request.getSession().setAttribute("carrito", listaCarrito);
                            request.setAttribute("idProductos", "[" + id + "]");
                            request.setAttribute("totalPagar", totalPagar);
                            request.setAttribute("contador", List.class.cast(request.getSession().getAttribute("carrito")).size());
                            request.getRequestDispatcher("controlador?accion=carrito").forward(request, response);
                        }
                    }
                }
                break;
            case "ofertas":
                productos = pdao.productosOfertados();
                List<Integer> idps = new ArrayList<>();
                for (int i = 0; i < productos.size(); i++) {
                    idps.add(productos.get(i).getId());
                }
                request.setAttribute("idProductos", idps);
                request.setAttribute("ofertados", productos);
                request.setAttribute("contador", listaCarrito.size());
                // request.setAttribute("sesionJSON", json);
                request.setAttribute("nroProductos", productos.size());
                request.getRequestDispatcher("ofertas.jsp").forward(request, response);
                break;
            case "buscar":
                String busqueda = request.getParameter("buscador");
                String tipo = request.getParameter("tipoBus");
                productos = pdao.buscarProductos(tipo, busqueda);
                // request.setAttribute("sesionJSON", json);
                request.setAttribute("contadorPro", productos.size());
                // --->    request.setAttribute("contador", List.class.cast(request.getSession().getAttribute("carrito")).size());
                request.setAttribute("productos", productos);
                request.setAttribute("nroProductos", productos.size());
                request.getRequestDispatcher("index.jsp").forward(request, response);
                break;
            case "agregarCarrito":
                int pos = 0;
                cantidad = 1;
                idp = Integer.parseInt(request.getParameter("idp"));
                pro = new producto();
                pro = pdao.listarId(idp);
                if (listaCarrito.size() > 0) {
                    for (int i = 0; i < listaCarrito.size(); i++) {
                        if (idp == listaCarrito.get(i).getIdProducto()) {
                            pos = i;
                        }
                    }
                    if (idp == listaCarrito.get(pos).getIdProducto()) {
                        cantidad = listaCarrito.get(pos).getCantidad() + cantidad;
                        int subtotal = listaCarrito.get(pos).getPrecioCompra() * cantidad;
                        listaCarrito.get(pos).setCantidad(cantidad);
                        listaCarrito.get(pos).setSubTotal(subtotal);
                        if (!"No".equals(listaCarrito.get(pos).getDescuento())) {
                            listaCarrito.get(pos).setSubTotal(cantidad * cdao.aplicarDescuento(Integer.parseInt(listaCarrito.get(pos).getDescuento()), listaCarrito.get(pos).getPrecioCompra()));
                        }
                    } else {
                        item = item + 1;
                        car = new carrito();
                        car.setItem(item);
                        car.setIdProducto(pro.getId());
                        car.setNombre(pro.getNombre());
                        car.setIdTienda(pro.getIdTienda());
                        car.setNombreTienda(pro.getNombreTienda());
                        car.setDescripcion(pro.getDescripcion());
                        car.setPrecioCompra(pro.getPrecio());
                        car.setCantidad(cantidad);
                        car.setSubTotal(cantidad * pro.getPrecio());
                        car.setExistencias(pro.getExistencias());
                        car.setDescuento(pro.getDescuento());
                        if (!"No".equals(car.getDescuento())) {
                            car.setSubTotal(cantidad * cdao.aplicarDescuento(Integer.parseInt(car.getDescuento()), car.getPrecioCompra()));
                        }
                        car.setTipo(pro.getTipo());
                        listaCarrito.add(car);
                        request.getSession().setAttribute("carrito", listaCarrito);
                    }
                } else {
                    item = item + 1;
                    car = new carrito();
                    car.setItem(item);
                    car.setIdProducto(pro.getId());
                    car.setNombre(pro.getNombre());
                    car.setIdTienda(pro.getIdTienda());
                    car.setNombreTienda(pro.getNombreTienda());
                    car.setDescripcion(pro.getDescripcion());
                    car.setPrecioCompra(pro.getPrecio());
                    car.setCantidad(cantidad);
                    car.setSubTotal(cantidad * pro.getPrecio());
                    car.setExistencias(pro.getExistencias());
                    car.setDescuento(pro.getDescuento());
                    if (!"No".equals(car.getDescuento())) {
                        car.setSubTotal(cantidad * cdao.aplicarDescuento(Integer.parseInt(car.getDescuento()), car.getPrecioCompra()));
                    }
                    car.setTipo(pro.getTipo());
                    listaCarrito.add(car);
                    request.getSession().setAttribute("carrito", listaCarrito);
                }
                String type = request.getParameter("type");
                request.setAttribute("contador", List.class.cast(request.getSession().getAttribute("carrito")).size());
                if (type.equals("oferta")) {
                    request.getRequestDispatcher("controlador?accion=ofertas").forward(request, response);
                } else {
                    request.getRequestDispatcher("controlador?accion=home").forward(request, response);
                }
                break;
            case "carrito":
                totalPagar = 0;
                List<Integer> ids = new ArrayList<>();
                request.setAttribute("carrito", List.class.cast(request.getSession().getAttribute("carrito")));
                for (int i = 0; i < listaCarrito.size(); i++) {
                    if (listaCarrito.get(i).getDescuento().equals("No")) {
                        totalPagar = totalPagar + listaCarrito.get(i).getSubTotal();
                        ids.add(listaCarrito.get(i).getIdProducto());
                    } else {
                        listaCarrito.get(i).setSubTotal(listaCarrito.get(i).getCantidad() * cdao.aplicarDescuento(Integer.parseInt(listaCarrito.get(i).getDescuento()), listaCarrito.get(i).getPrecioCompra()));
                        totalPagar = totalPagar + listaCarrito.get(i).getSubTotal();
                        ids.add(listaCarrito.get(i).getIdProducto());
                    }
                }
                request.setAttribute("contador", listaCarrito.size());
                // request.setAttribute("sesionJSON", json);
                request.setAttribute("idProductos", ids);
                request.setAttribute("totalPagar", totalPagar);
                request.getRequestDispatcher("carrito.jsp").forward(request, response);
                break;
            case "delete":
                int idProducto = Integer.parseInt(request.getParameter("idp"));
                if (listaCarrito != null) {
                    for (int i = 0; i < listaCarrito.size(); i++) {
                        if (listaCarrito.get(i).getIdProducto() == idProducto) {
                            listaCarrito.remove(i);
                            request.getSession().setAttribute("carrito", listaCarrito);
                        }
                    }
                }
                break;
            case "actualizarCantidad":
                int idpro = Integer.parseInt(request.getParameter("idp"));
                int cant = Integer.parseInt(request.getParameter("cantidad"));
                for (int i = 0; i < listaCarrito.size(); i++) {
                    if (listaCarrito.get(i).getIdProducto() == idpro) {
                        listaCarrito.get(i).setCantidad(cant);
                        int st = listaCarrito.get(i).getPrecioCompra() * cant;
                        listaCarrito.get(i).setSubTotal(st);
                        if (!listaCarrito.get(i).getDescuento().equals("No")) {
                            int total = listaCarrito.get(i).getCantidad() * cdao.aplicarDescuento(Integer.parseInt(listaCarrito.get(i).getDescuento()), listaCarrito.get(i).getPrecioCompra());
                            listaCarrito.get(i).setSubTotal(total);
                        }
                        request.getSession().setAttribute("carrito", listaCarrito);
                    }
                }
                break;
            case "listarIMG":
                int id = Integer.parseInt(request.getParameter("id"));
                pdao.listarImg(id, response);
                break;
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
