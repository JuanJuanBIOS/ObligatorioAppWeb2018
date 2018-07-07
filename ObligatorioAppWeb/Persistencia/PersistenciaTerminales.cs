using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;
using System.Data.SqlClient;
using System.Data;

namespace Persistencia
{
    internal class PersistenciaTerminales : IPersistenciaTerminales
    {
        //Singleton
        private static PersistenciaTerminales _instancia = null;

        private PersistenciaTerminales() { }

        public static PersistenciaTerminales GetInstancia()
        {
            if (_instancia == null)
            {
                _instancia = new PersistenciaTerminales();
            }

            return _instancia;
        }


        //Operaciones
        public void Alta_Terminal(Terminales unaTer)
        {
            SqlConnection oConexion = new SqlConnection(Conexion.STR);
            SqlCommand oComando = new SqlCommand("Alta_Terminal", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            oComando.Parameters.AddWithValue("@codigo", unaTer.Codigo);
            oComando.Parameters.AddWithValue("@ciudad", unaTer.Ciudad);
            oComando.Parameters.AddWithValue("@pais", unaTer.Pais);

            SqlParameter oRetorno = new SqlParameter("@Retorno", SqlDbType.Int);
            oRetorno.Direction = ParameterDirection.ReturnValue;
            oComando.Parameters.Add(oRetorno);

            int oAfectados = -1;

            try
            {
                oConexion.Open();
                oComando.ExecuteNonQuery();

                oAfectados = (int)oComando.Parameters["@Retorno"].Value;

                if (oAfectados == -1)
                {
                    throw new Exception("La terminal ingresada ya existe en la base de datos");
                }
                if (oAfectados == -2)
                {
                    throw new Exception("Error al crear la terminal en la base de datos");
                }
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Problemas con la base de datos:" + ex.Message);
            }

            finally
            {
                oConexion.Close();
            }
        }


        public void Baja_Terminal(Terminales unaTer)
        {
            SqlConnection oConexion = new SqlConnection(Conexion.STR);
            SqlCommand oComando = new SqlCommand("Eliminar_Terminal", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            oComando.Parameters.AddWithValue("@codigo", unaTer.Codigo);

            SqlParameter oRetorno = new SqlParameter("@Retorno", SqlDbType.Int);
            oRetorno.Direction = ParameterDirection.ReturnValue;
            oComando.Parameters.Add(oRetorno);

            int oAfectados = -1;

            try
            {
                oConexion.Open();
                oComando.ExecuteNonQuery();

                oAfectados = (int)oComando.Parameters["@Retorno"].Value;

                if (oAfectados == -1)
                {
                    throw new Exception("La terminal no existe en la base de datos");
                }
                if (oAfectados == -2)
                {
                    throw new Exception("Error al eliminar la terminal en la base de datos");
                }
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Problemas con la base de datos:" + ex.Message);
            }

            finally
            {
                oConexion.Close();
            }
        }


        public void Modificar_Terminal(Terminales unaTer)
        {
            SqlConnection oConexion = new SqlConnection(Conexion.STR);
            SqlCommand oComando = new SqlCommand("Modificar_Terminal", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            oComando.Parameters.AddWithValue("@codigo", unaTer.Codigo);
            oComando.Parameters.AddWithValue("@ciudad", unaTer.Ciudad);
            oComando.Parameters.AddWithValue("@pais", unaTer.Pais);

            SqlParameter oRetorno = new SqlParameter("@Retorno", SqlDbType.Int);
            oRetorno.Direction = ParameterDirection.ReturnValue;
            oComando.Parameters.Add(oRetorno);

            int oAfectados = -1;

            try
            {
                oConexion.Open();
                oComando.ExecuteNonQuery();

                oAfectados = (int)oComando.Parameters["@Retorno"].Value;

                if (oAfectados == -1)
                {
                    throw new Exception("La terminal ingresada no existe en la base de datos");
                }
                if (oAfectados == -2)
                {
                    throw new Exception("Error al modificar la terminal en la base de datos");
                }
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Problemas con la base de datos:" + ex.Message);
            }

            finally
            {
                oConexion.Close();
            }
        }
    }
}
