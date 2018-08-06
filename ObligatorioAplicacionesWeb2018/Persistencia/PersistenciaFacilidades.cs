using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;
using System.Data.SqlClient;
using System.Data;

namespace Persistencia
{
    internal class PersistenciaFacilidades
    {
        internal static List<Facilidades> CargoFacilidades(string pcodTerminal)
        {
            SqlConnection oConexion = new SqlConnection(Conexion.STR);
            SqlCommand oComando = new SqlCommand("Buscar_Facilidades", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            oComando.Parameters.AddWithValue("@terminal", pcodTerminal);

            List<Facilidades> unaListaFacilidades = new List<Facilidades>();
            try
            {
                oConexion.Open();

                SqlDataReader _Reader = oComando.ExecuteReader();

                if (_Reader.HasRows)
                {
                    while (_Reader.Read())
                    {
                        Facilidades _unaFacilidad = new Facilidades((string)_Reader["nombre"]);
                        unaListaFacilidades.Add(_unaFacilidad);
                    }
                }

                _Reader.Close();
            }

            catch (SqlException)
            {
                throw new Exception("La base de datos no se encuantra disponible. Contacte al administrador.");
            }

            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }

            finally
            {
                oConexion.Close();
            }
            return unaListaFacilidades;
        }

        internal static void Alta_Facilidad(Facilidades pFacilidad, Terminales pTer, SqlTransaction _pTransaccion)
        {
            SqlCommand oComando = new SqlCommand("Alta_Facilidades", _pTransaccion.Connection);
            oComando.CommandType = CommandType.StoredProcedure;

            oComando.Parameters.AddWithValue("@terminal", pTer.Codigo);
            oComando.Parameters.AddWithValue("@nombre", pFacilidad.Facilidad);

            SqlParameter oRetorno = new SqlParameter("@Retorno", SqlDbType.Int);
            oRetorno.Direction = ParameterDirection.ReturnValue;
            oComando.Parameters.Add(oRetorno);


            try
            {
                oComando.Transaction = _pTransaccion;

                oComando.ExecuteNonQuery();

                int retorno = Convert.ToInt32(oRetorno.Value);

                if (retorno == -1)
                {
                    throw new Exception("La terminal ingresada no existe en la base de datos o está dada de baja");
                }
                if (retorno == -2)
                {
                    throw new Exception("Error al crear la terminal en la base de datos");
                }
            }

            catch (SqlException)
            {
                throw new Exception("La base de datos no se encuantra disponible. Contacte al administrador.");
            }

            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal static void Eliminar_Facilidades(Terminales pTerminal, SqlTransaction _pTransaccion)
        {
            SqlCommand oComando = new SqlCommand("Eliminar_Facilidades", _pTransaccion.Connection);
            oComando.CommandType = CommandType.StoredProcedure;

            oComando.Parameters.AddWithValue("@codigo", pTerminal.Codigo);

            SqlParameter oRetorno = new SqlParameter("@Retorno", SqlDbType.Int);
            oRetorno.Direction = ParameterDirection.ReturnValue;
            oComando.Parameters.Add(oRetorno);

            try
            {
                oComando.Transaction = _pTransaccion;

                oComando.ExecuteNonQuery();

                int retorno = Convert.ToInt32(oRetorno.Value);

                if (retorno == -1)
                {
                    throw new Exception("La terminal ingresada no existe en la base de datos o está dada de baja");
                }
                if (retorno == -2)
                {
                    throw new Exception("Error al eliminar la terminal en la base de datos");
                }
            }

            catch (SqlException)
            {
                throw new Exception("La base de datos no se encuantra disponible. Contacte al administrador.");
            }

            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
