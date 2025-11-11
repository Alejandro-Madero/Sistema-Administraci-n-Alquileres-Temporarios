using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;
using accesoDatos;
using System.Diagnostics.Eventing.Reader;
using System.Runtime.Remoting.Messaging;
using System.Data;

namespace negocio
{
    public class UsuarioNegocio
    {

        public Usuario Login(string email, string password)
        {
                AccesoDatos datos = new AccesoDatos();
                        

            try
            {
                datos.SetearConsulta("SELECT * FROM USUARIOS WHERE Email = @email AND Contraseña = @password AND Activo = 1");
                datos.setearParametro("@email", email);
                datos.setearParametro("@password", password);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    Usuario usuario = new Usuario();
                    usuario.IdUsuario = (int)datos.Lector["idUsuario"];
                    usuario.Nombre = (string)datos.Lector["Nombre"];
                    usuario.Apellido = (string)datos.Lector["Apellido"];
                    usuario.Email = (string)datos.Lector["Email"];
                    usuario.Telefono = datos.Lector["Telefono"] != DBNull.Value ? (string)datos.Lector["Telefono"] : null;
                    usuario.FechaRegistro = (DateTime)datos.Lector["FechaRegistro"];
                    usuario.UltimoLogin = datos.Lector["UltimoLogin"] != DBNull.Value ? (DateTime?)datos.Lector["UltimoLogin"] : null;
                    usuario.Activo = (bool)datos.Lector["Activo"];

                    datos.cerrarConexion();
                    //Actualizar ultimo login del usuario

                    datos.limpiarParametros();
                    datos.SetearConsulta("UPDATE Usuarios SET UltimoLogin = GETDATE() WHERE idUsuario = @id");
                    datos.setearParametro("@id", usuario.IdUsuario);
                    datos.ejecutarLectura(); 

                    return usuario;

                }
                return null;
            }catch (Exception ex)
            {
                throw new Exception("Email o contraseña incorrectos. " + ex.Message);
            }
            finally
            {
                datos.cerrarConexion();
            }                

        }
        
        public void Registrar(Usuario nuevoUsuario, string password)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearConsulta("SELECT COUNT(*) FROM USUARIOS WHERE Email = @Email");
                datos.setearParametro("@Email", nuevoUsuario.Email);
                int existe =(int)datos.ejecutarScalar();

                if(existe >= 1)
                {
                    throw new Exception("Ya existe un usuario registrado con el email " + nuevoUsuario.Email);
                } 

                datos.SetearConsulta("INSERT INTO Usuarios(Nombre, Apellido, Email, Contraseña, Telefono) values(@Nombre, @Apellido, @Email, @Contraseña, @Telefono)");
                datos.setearParametro("@Nombre", nuevoUsuario.Nombre);
                datos.setearParametro("@Apellido", nuevoUsuario.Apellido);
                datos.setearParametro("@Email", nuevoUsuario.Email);
                datos.setearParametro("@Contraseña", password);
                datos.setearParametro("@Telefono", nuevoUsuario.Telefono ?? (Object)DBNull.Value);
                datos.ejecutarAccion();
                
            }
            catch (Exception ex)
            {

                throw new Exception("No se pudo registrar el usuario. " + ex.Message);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        
        public void DesactivarCuenta(int idUsuario)
        {

            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearStoredProcedure("sp_desactivarCuenta");
                datos.setearParametro("@idUsuario", idUsuario);
                datos.ejecutarAccion();

            }
            catch (Exception ex)
            {

                throw new Exception("No se pudo desactivar el usuario " + ex.Message);
            }finally
            {
                datos.cerrarConexion();
            }

        }

    }
}
