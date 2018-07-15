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
        public Terminales Buscar_Terminal(string pCodTerminal)
        {
            SqlConnection oConexion = new SqlConnection(Conexion.STR);
            SqlCommand oComando = new SqlCommand("Buscar_Terminal", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            oComando.Parameters.AddWithValue("@codigo", pCodTerminal);

            Terminales unaTer = null;

            try
            {
                oConexion.Open();

                SqlDataReader _Reader = oComando.ExecuteReader();

                if (_Reader.HasRows)
                {
                    _Reader.Read();

                    string _codigo=(string)_Reader["codigo"];
                    string _ciudad=(string)_Reader["ciudad"];
                    string _pais=(string)_Reader["pais"];
                    List<Facilidades> _facilidades = new List<Facilidades>();
                    _facilidades = PersistenciaFacilidades.CargoFacilidades(pCodTerminal);

                    unaTer = new Terminales(_codigo, _ciudad, _pais, _facilidades);

                    _Reader.Close();
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }

            finally
            {
                oConexion.Close();
            }
            return unaTer;
        }


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
            
            SqlTransaction _transaccion = null;

            try
            {
                oConexion.Open();

                _transaccion = oConexion.BeginTransaction();

                oComando.Transaction = _transaccion;

                oComando.ExecuteNonQuery();

                //string oRetorno = Convert.ToString(oRetorno.Value);

                if (Convert.ToInt32(oRetorno.Value) == -1)
                {
                    throw new Exception("La terminal ingresada ya existe en la base de datos");
                }
                if (Convert.ToInt32(oRetorno.Value) == -2)
                {
                    throw new Exception("Error al crear la terminal en la base de datos");
                }

                foreach (Facilidades unaFac in unaTer.ListaFacilidades)
                {
                    PersistenciaFacilidades.Alta_Facilidad(unaFac, unaTer.Codigo, _transaccion);
                }

                _transaccion.Commit();
            }
            catch (Exception ex)
            {
                _transaccion.Rollback();
                throw new Exception("Problemas con la base de datos:" + ex.Message);
            }

            finally
            {
                oConexion.Close();
            }
        }


        public void Eliminar_Terminal(Terminales unaTer)
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
