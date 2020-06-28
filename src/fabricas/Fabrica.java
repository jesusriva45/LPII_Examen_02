package fabricas;

import dao.ClienteDAO;


//Es una fábrica de objetos
//Se usa el patrón DAO (Data Access Object)
public abstract class Fabrica {

	public static final int MYSQL = 1;
	public static final int SQLSERVER = 2;

	//Se inscribe el dao alumno a las fábricas
	public abstract ClienteDAO getClienteDAO(); 
	
	//Va fabricar subfabricas (Mysql y sqlserver)
	public static Fabrica getFabrica(int tipo){
		Fabrica salida = null;
		switch(tipo){
			case MYSQL: 
				salida = new FabricaMysql();
				break;
			
		}
		return salida;
	}
}
