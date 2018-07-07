using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;
using System.Data.SqlClient;
using System.Data;

namespace Persistencia
{
    internal class PersistenciaCompania : IPersistenciaCompania
    {
        //Singleton
        private static PersistenciaCompania _instancia = null;

        private PersistenciaCompania() { }

        public static PersistenciaCompania GetInstancia()
        {
            if (_instancia == null)
            {
                _instancia = new PersistenciaCompania();
            }

            return _instancia;
        }


        //Operaciones
        //Buscar
        public Companias Buscar_Compania(string pNombre)
        {
            Companias unaComp = null;

            SqlConnection oConexion = new SqlConnection(Conexion.STR);
            SqlCommand oComando = new SqlCommand("Buscar_Compania", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            oComando.Parameters.AddWithValue("@nombre", pNombre);

            try
            {
                oConexion.Open();
                SqlDataReader oReader = oComando.ExecuteReader();

                if (oReader.HasRows)
                {
                    oReader.Read();

                    string _nombre = (string)oReader["nombre"];
                    string _direccion = (string)oReader["direccion"];
                    string _telefono = (string)oReader["telefono"];

                    oReader.Close();

                    unaComp = new Companias(_nombre, _direccion, _telefono);
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

            return unaComp;
        }


        //Crear
        public void Alta_Compania(Companias unaC)
        {
            SqlConnection oConexion = new SqlConnection(Conexion.STR);
            SqlCommand oComando = new SqlCommand("Alta_Compania", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            oComando.Parameters.AddWithValue("@nombre", unaC.Nombre);
            oComando.Parameters.AddWithValue("@direccion", unaC.Direccion);
            oComando.Parameters.AddWithValue("@telefono", unaC.Telefono);

            SqlParameter oRetorno = new SqlParameter("@Retorno", SqlDbType.Int);
            oRetorno.Direction = ParameterDirection.ReturnValue;
            oComando.Parameters.Add(oRetorno);

            try
            {
                oConexion.Open();
                oComando.ExecuteNonQuery();

                int oAfectados = (int)oComando.Parameters["@Retorno"].Value;

                if (oAfectados == -1)
                {
                    throw new Exception("Ya existe el Compañía con el nombre ingresado");
                }
                else if (oAfectados == -2)
                {
                    throw new Exception("Error en la base de datos");
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                oConexion.Close();
            }
        }

        //Modificar
        public void Modificar_Compania(Companias unaC)
        {
            SqlConnection oConexion = new SqlConnection(Conexion.STR);
            SqlCommand oComando = new SqlCommand("Modificar_Compania", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            oComando.Parameters.AddWithValue("@nombre", unaC.Nombre);
            oComando.Parameters.AddWithValue("@direccion", unaC.Direccion);
            oComando.Parameters.AddWithValue("@telefono", unaC.Telefono);

            SqlParameter oRetorno = new SqlParameter("@Retorno", SqlDbType.Int);
            oRetorno.Direction = ParameterDirection.ReturnValue;
            oComando.Parameters.Add(oRetorno);

            try
            {
                oConexion.Open();
                oComando.ExecuteNonQuery();

                int oAfectados = (int)oComando.Parameters["@Retorno"].Value;

                if (oAfectados == -1)
                {
                    throw new Exception("No existe Compañía con el nombre ingresado");
                }
                else if (oAfectados == -2)
                {
                    throw new Exception("Error en la base de datos");
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                oConexion.Close();
            }
        }

        //Eliminar
        public void Eliminar_Compania(Companias unaC)
        {
            SqlConnection oConexion = new SqlConnection(Conexion.STR);
            SqlCommand oComando = new SqlCommand("Eliminar_Compania", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            oComando.Parameters.AddWithValue("@nombre", unaC.Nombre);

            SqlParameter oRetorno = new SqlParameter("@Retorno", SqlDbType.Int);
            oRetorno.Direction = ParameterDirection.ReturnValue;
            oComando.Parameters.Add(oRetorno);

            try
            {
                oConexion.Open();
                oComando.ExecuteNonQuery();

                int oAfectados = (int)oComando.Parameters["@Retorno"].Value;

                if (oAfectados == -1)
                {
                    throw new Exception("La Compañía no existe en la base de datos");
                }
                else if (oAfectados == -2)
                {
                    throw new Exception("Error al eliminar Compañía de la base de datos");
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                oConexion.Close();
            }
        }

    }
}
