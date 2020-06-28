package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import util.MySqlDBConexion;
import entidad.Cliente;


public class MySqlClienteDAO implements ClienteDAO {

	private static final Log log = LogFactory.getLog(MySqlClienteDAO.class);
	

	
	@Override
	public int insertaCliente(Cliente obj) {
		Connection conn = null;
		PreparedStatement pstm = null;
		int salida = -1;
		try {			
			String sql = "insert into cliente values (null,?,?,?,?,?)";
			conn = MySqlDBConexion.getConexion();
			pstm = conn.prepareStatement(sql);
			
			pstm.setString(1, obj.getNombre());
			pstm.setString(2, obj.getApellido());
			pstm.setString(3, obj.getCorreo());
			pstm.setDate(4,  obj.getFechanacimiento());
			pstm.setString(5, obj.getDni());
		
			log.info(pstm);
			salida = pstm.executeUpdate();
		} catch (Exception e) {
			log.info(e);
		} finally {
			try {
				if (pstm != null)pstm.close();
				if (conn != null)conn.close();
			} catch (SQLException e) {}
		}
		return salida;
	}
	
	@Override
	public int actualizaCliente(Cliente obj) {
		Connection conn = null;
		PreparedStatement pstm = null;
		int salida = -1;
		try {			
			String sql = "update cliente set nombre = ? , apellido = ?, correo = ?, fecha = ? , dni = ? where idcliente = ? ";
			conn = MySqlDBConexion.getConexion();
			pstm = conn.prepareStatement(sql);			
			pstm.setString(1, obj.getNombre());
			pstm.setString(2, obj.getApellido());
			pstm.setString(3, obj.getCorreo());
			pstm.setDate(4, obj.getFechanacimiento());
			pstm.setString(5, obj.getDni());
			pstm.setInt(6, obj.getIdcliente());
						
			log.info(pstm);
			salida = pstm.executeUpdate();
		} catch (Exception e) {
			log.info(e);
		} finally {
			try {
				if (pstm != null)pstm.close();
				if (conn != null)conn.close();
			} catch (SQLException e) {}
		}
		return salida;
	}
	
	@Override
	public int eliminaCliente(int id) {
		Connection conn = null;
		PreparedStatement pstm = null;
		int salida = -1;
		try {
			String sql = "delete from cliente where idcliente = ? ";
			conn = MySqlDBConexion.getConexion();
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, id);
			log.info(pstm);
			salida = pstm.executeUpdate();
		} catch (Exception e) {
			log.info(e);
		} finally {
			try {
				if (pstm != null)pstm.close();
				if (conn != null)conn.close();
			} catch (SQLException e) {}
		}
		return salida;
	}
	
	
	@Override
	public List<Cliente> listaCliente(String nom) {	
		
		List<Cliente> lista = new ArrayList<Cliente>();
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;	
		
		try {
			conn = MySqlDBConexion.getConexion();
			String sql = "select * from cliente where nombre like ?";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, nom + "%");
			log.info(pstm);
			rs = pstm.executeQuery();
			Cliente obj =null;
			while(rs.next()){
				obj = new Cliente();
				obj.setIdcliente(rs.getInt(1));
				obj.setNombre(rs.getString(2));
				obj.setApellido(rs.getString(3));
				obj.setCorreo(rs.getString(4));
				obj.setFechanacimiento(rs.getDate(5));				
				obj.setDni(rs.getString(6));
				
				lista.add(obj);
			}
		} catch (Exception e) {
			log.info(e);
		} finally {
			try {
				if (rs != null)rs.close();
				if (pstm != null)pstm.close();
				if (conn != null)conn.close();
			} catch (SQLException e) {
				
			}
		}
		return lista;
	}
	
}
 