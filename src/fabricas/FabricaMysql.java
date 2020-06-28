package fabricas;

import dao.ClienteDAO;
import dao.MySqlClienteDAO;



//Es una subfabrica que tiene objetos que acceden
//a la base de datos MYSQL
public class FabricaMysql extends Fabrica{

	@Override
	public ClienteDAO getClienteDAO() {
		return new MySqlClienteDAO();
	}


}





