using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;
using accesoDatos;

namespace negocio
{
    public class PropiedadNegocio
    {


        public List<Propiedad> ListarPropiedades(string ciudad, string capacidad, DateTime fechaInicio, DateTime fechaFin)
        {

            AccesoDatos datos = new AccesoDatos();
            List<Propiedad> propiedadesDisponibles = new List<Propiedad>();

            try
            {

                string ciudadLike = "%" + ciudad + "%";
                datos.SetearStoredProcedure("sp_ListarPropiedadesDisponibles");
                datos.setearParametro("@Ciudad", ciudadLike);
                datos.setearParametro("@Capacidad", capacidad);
                datos.setearParametro("@FechaInicio", fechaInicio);
                datos.setearParametro("@FechaFin", fechaFin);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Propiedad propiedad = new Propiedad();

                    propiedad.IdPropiedad = (int)datos.Lector["idPropiedad"];
                    propiedad.Titulo = (string)datos.Lector["Titulo"];
                    propiedad.TipoPropiedad = (string)datos.Lector["TipoPropiedad"];
                    propiedad.PrecioNoche = (decimal)datos.Lector["PrecioNoche"];
                    propiedad.Capacidad = (int)datos.Lector["Capacidad"];
                    propiedad.Direccion = (string)datos.Lector["direccion"];
                    propiedad.Descripcion = (string)datos.Lector["Descripcion"];
                    propiedad.CalificacionPromedio = datos.Lector["CalificacionPromedio"] != DBNull.Value ? (decimal?)datos.Lector["CalificacionPromedio"] : null;
                    Ciudad ciudadPropiedad = new Ciudad();
                    ciudadPropiedad.IdCiudad = (int)datos.Lector["idCiudad"];
                    ciudadPropiedad.Nombre = (string)datos.Lector["Ciudad"];
                    propiedad.Ciudad = ciudadPropiedad;
                    Usuario anfitrion = new Usuario();
                    anfitrion.IdUsuario = (int)datos.Lector["idUsuario"];
                    anfitrion.Nombre = (string)datos.Lector["Nombre"];
                    anfitrion.Apellido = (string)datos.Lector["Apellido"];
                    propiedad.Anfitrion = anfitrion;

                    propiedadesDisponibles.Add(propiedad);
                }

            }
            catch (Exception ex)
            {

                throw ex;

            }
            finally
            {
                datos.cerrarConexion();
            }

            return propiedadesDisponibles;
        }

        public Propiedad ObtenerDetallePropiedad(int idPropiedad)
        {

            AccesoDatos datos = new AccesoDatos();

            try
            {


                datos.SetearStoredProcedure("sp_ObtenerDetallePropiedad");
                datos.setearParametro("@idPropiedad", idPropiedad);
                datos.ejecutarLectura();
                Propiedad propiedad = new Propiedad();


                while (datos.Lector.Read())
                {

                    propiedad.IdPropiedad = (int)datos.Lector["idPropiedad"];
                    propiedad.Titulo = (string)datos.Lector["Titulo"];
                    propiedad.TipoPropiedad = (string)datos.Lector["TipoPropiedad"];
                    propiedad.PrecioNoche = (decimal)datos.Lector["PrecioNoche"];
                    propiedad.Capacidad = (int)datos.Lector["Capacidad"];
                    propiedad.Direccion = (string)datos.Lector["direccion"];
                    propiedad.Descripcion = (string)datos.Lector["Descripcion"];
                    propiedad.CalificacionPromedio = datos.Lector["CalificacionPromedio"] != DBNull.Value ? (decimal?)datos.Lector["CalificacionPromedio"] : null;
                    Ciudad ciudadPropiedad = new Ciudad();
                    ciudadPropiedad.IdCiudad = (int)datos.Lector["idCiudad"];
                    ciudadPropiedad.Nombre = (string)datos.Lector["Ciudad"];
                    propiedad.Ciudad = ciudadPropiedad;
                    Usuario anfitrion = new Usuario();
                    anfitrion.IdUsuario = (int)datos.Lector["idUsuario"];
                    anfitrion.Nombre = (string)datos.Lector["Nombre"];
                    anfitrion.Apellido = (string)datos.Lector["Apellido"];
                    propiedad.Anfitrion = anfitrion;
                }
                return propiedad;

            }
            catch (Exception ex)
            {
                throw new Exception("Detalle de propiedad no encontrado " + ex.Message);
            }
            finally
            {
                datos.cerrarConexion();
            }

        }   
        public List<FotoPropiedad> ObtenerFotosPropiedad(int idPropiedad)
        {

            AccesoDatos datos = new AccesoDatos();
            List<FotoPropiedad> fotosPropiedad = new List<FotoPropiedad>();
            try
            {


                datos.SetearStoredProcedure("sp_ObtenerFotosPropiedad");
                datos.setearParametro("@idPropiedad", idPropiedad);
                datos.ejecutarLectura();


                while (datos.Lector.Read())
                {
                    FotoPropiedad foto = new FotoPropiedad();
                    foto.IdFoto = (int)datos.Lector["idFoto"];
                    foto.IdPropiedad = (int)datos.Lector["idPropiedad"];
                    foto.Descripcion = (string)datos.Lector["Descripcion"];
                    foto.URL = (string)datos.Lector["URL"];
                    fotosPropiedad.Add(foto);
                }
                return fotosPropiedad;

            }
            catch (Exception ex)
            {
                throw new Exception("Las fotos de la propiedad de la propiedad no fueron encontradas " + ex.Message);
            }
            finally
            {
                datos.cerrarConexion();
            }

        }

    }       
    
}

