package controlador;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ClienteDAO;
import entidad.Cliente;

import fabricas.Fabrica;

/**
 * Servlet implementation class ClienteCrudControlador
 */
@WebServlet("/ClienteCrudControlador")
public class ClienteCrudControlador extends HttpServlet {
	private static final long serialVersionUID = 1L;


	Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL);
	ClienteDAO dao = fabrica.getClienteDAO();
	
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String metodo = request.getParameter("metodo");

		if (metodo.equals("lista")) {			
			lista(request, response);
		} else if (metodo.equals("registra")) {
			registra(request, response);
		} else if (metodo.equals("elimina")) {
			elimina(request, response);
		} else if (metodo.equals("actualiza")) {
			actualiza(request, response);
		}		
		
	}	
	
	
	protected void lista(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {		
	    
		
		List<Cliente> data = null;
		try {
			String filtro = request.getParameter("filtro");
					
			data = dao.listaCliente(filtro);
		} catch (Exception e) {
			e.printStackTrace();
			request.getSession().setAttribute("NODATA", "NO PASA");
		}
		for (Cliente x: data) {
			System.out.println(x.getIdcliente());
			System.out.println(x.getNombre());
			System.out.println(x.getApellido());
			System.out.println(x.getFechanacimiento());
		}
		
		
		
		request.setAttribute("DATA", data);		 
		
		request.getRequestDispatcher("/clienteCRUD.jsp").forward(request, response);

	}
	
	protected void registra(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<Cliente> data = null;
		
			String fecha = request.getParameter("fecha");
		
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 					
		
		try {
			
			Date fechanac = new Date (sdf.parse(fecha).getTime());
			
			Cliente obj = new Cliente();			
			
			
			obj.setNombre(request.getParameter("nombre"));
			obj.setApellido(request.getParameter("apellido"));
			obj.setCorreo(request.getParameter("correo"));
			obj.setFechanacimiento(fechanac);
			obj.setDni(request.getParameter("dni"));			
			
			int s = dao.insertaCliente(obj);	
			
			if (s > 0) {

				request.getSession().setAttribute("REGISTRO", "registro exitoso");
				request.getSession().setAttribute("message", "success");

			} else if(s < 0) {

				request.getSession().setAttribute("REGISTRO", "registro erróneo");
				request.getSession().setAttribute("message", "danger");

			}			
			
			data = dao.listaCliente("");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("DATA", data);
		request.getRequestDispatcher("/clienteCRUD.jsp").forward(request, response);
	}

	protected void actualiza(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<Cliente> data = null;
		try {
			Cliente obj = new Cliente();			
			obj.setIdcliente(Integer.parseInt(request.getParameter("iduser")));
			obj.setNombre(request.getParameter("nombre"));
			obj.setApellido(request.getParameter("apellido"));
			obj.setCorreo(request.getParameter("correo"));
			obj.setFechanacimiento(Date.valueOf(request.getParameter("fecha")));
			obj.setDni(request.getParameter("dni"));
			
			int s = dao.actualizaCliente(obj);			
					
			if (s > 0) {

				request.getSession().setAttribute("ACTUALIZO", "actualizacion exitosa");
				request.getSession().setAttribute("message", "success");

			} else {

				request.getSession().setAttribute("ACTUALIZO", "actualizacion errónea");
				request.getSession().setAttribute("message", "danger");

			}
			
			data = dao.listaCliente("");
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("DATA", data);
		request.getRequestDispatcher("/clienteCRUD.jsp").forward(request, response);

	}

	protected void elimina(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<Cliente> data = null;
		
		try {
			int id = Integer.parseInt(request.getParameter("id")) ;
			dao.eliminaCliente(id);
			data = dao.listaCliente("");			
				
			
			if (id > 0) {

				request.getSession().setAttribute("ELIMINO", "Eliminación exitosa");
				request.getSession().setAttribute("message", "success");

			} else {

				request.getSession().setAttribute("ELIMINO", "Eliminación falló");
				request.getSession().setAttribute("message", "danger");

			}
			
		} catch (Exception e) {
			e.printStackTrace();
			request.getSession().setAttribute("ELIMINO", "Eliminación falló");
		}
		
		
			
		
		request.setAttribute("DATA", data);
		
		request.getRequestDispatcher("/clienteCRUD.jsp").forward(request, response);

	}
	

}
