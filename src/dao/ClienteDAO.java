package dao;


import java.util.List;

import entidad.Cliente;


public interface ClienteDAO {	


	public abstract int insertaCliente(Cliente obj);

	public abstract int actualizaCliente(Cliente obj);

	public abstract int eliminaCliente(int idUsuario);

	public abstract List<Cliente> listaCliente(String filtro);

}
