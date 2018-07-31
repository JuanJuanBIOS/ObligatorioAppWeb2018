using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;
using Persistencia.Interfaces;
using System.Data.SqlClient;
using System.Data;

namespace Persistencia
{
    internal class PersistenciaInternacionales : IPersistenciaInternacionales
    {
        //Singleton
        private static PersistenciaInternacionales _instancia = null;

        private PersistenciaInternacionales() { }

        public static PersistenciaInternacionales GetInstancia()
        {
            if (_instancia == null)
            {
                _instancia = new PersistenciaInternacionales();
            }

            return _instancia;
        }


        //Operaciones
        public Internacionales Buscar_Viaje(int pCodViaje)
        {
            SqlConnection oConexion = new SqlConnection(Conexion.STR);
            SqlCommand oComando = new SqlCommand("Buscar_ViajeInternacional", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            oComando.Parameters.AddWithValue("@numero", pCodViaje);

            Internacionales unInter = null;

            try
            {
                oConexion.Open();

                SqlDataReader _Reader = oComando.ExecuteReader();

                if (_Reader.HasRows)
                {
                    int _numero = (int)_Reader["numero"];
                    Companias _compania = PersistenciaCompania.GetInstancia().Buscar_Compania((string)_Reader["compania"]);
                    Terminales _terminal = PersistenciaTerminales.GetInstancia().Buscar_Terminal((string)_Reader["destino"]);
                    DateTime _fechapartida = (DateTime)_Reader["fecha_partida"];
                    DateTime _fechaarribo = (DateTime)_Reader["fecha_arribo"];
                    int _asientos = (int)_Reader["asientos"];
                    Empleados _empleado = PersistenciaEmpleado.GetInstancia().Buscar_Empleado((string)_Reader["empleado"]);
                    bool _servicio = (bool)_Reader["servicio"];
                    string _documentacion = (string)_Reader["documentacion"];

                    unInter = new Internacionales(_numero, _compania, _terminal, _fechapartida, _fechaarribo, _asientos, _empleado, _servicio, _documentacion);

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

            return unInter;
        }

        public void Alta_Internacional(Internacionales unInter)
        {
            SqlConnection oConexion = new SqlConnection(Conexion.STR);
            SqlCommand oComando = new SqlCommand("Alta_ViajeInternacional", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            oComando.Parameters.AddWithValue("@numero", unInter.Numero);
            oComando.Parameters.AddWithValue("@compania", unInter.Compania.Nombre);
            oComando.Parameters.AddWithValue("@destino", unInter.Terminal.Codigo);
            oComando.Parameters.AddWithValue("@fecha_partida", unInter.Fecha_partida);
            oComando.Parameters.AddWithValue("@fecha_arribo", unInter.Fecha_arribo);
            oComando.Parameters.AddWithValue("@asientos", unInter.Asientos);
            oComando.Parameters.AddWithValue("@empleado", unInter.Empleado.Cedula);
            oComando.Parameters.AddWithValue("@servicio", unInter.Servicio);
            oComando.Parameters.AddWithValue("@documentacion", unInter.Documentacion);

            SqlParameter oRetorno = new SqlParameter("@Retorno", SqlDbType.Int);
            oRetorno.Direction = ParameterDirection.ReturnValue;
            oComando.Parameters.Add(oRetorno);

            try
            {
                oConexion.Open();

                oComando.ExecuteNonQuery();

                if (Convert.ToInt32(oRetorno.Value) == -1)
                {
                    throw new Exception("El número de viaje ingresado ya existe en la base de datos");
                }
                if (Convert.ToInt32(oRetorno.Value) == -2)
                {
                    throw new Exception("Ya existe un viaje al destino indicado en ese horario. Los viajes al mismo destino deben tener un mínimo de 2 horas de diferencia entre ellos.");
                }
                if (Convert.ToInt32(oRetorno.Value) == -3)
                {
                    throw new Exception("La compañía ingresada no existe en la base de datos.");
                }
                if (Convert.ToInt32(oRetorno.Value) == -4)
                {
                    throw new Exception("La terminal ingresada no existe en la base de datos..");
                }
                if (Convert.ToInt32(oRetorno.Value) == -5)
                {
                    throw new Exception("El empleado logueado no existe en la base de datos.");
                }
                if (Convert.ToInt32(oRetorno.Value) == -6 || Convert.ToInt32(oRetorno.Value) == -7) 
                {
                    throw new Exception("Se produjo un error al intentar dar de alta el viaje. Inténtelo nuevamente.");
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Problemas con la base de datos:" + ex.Message);
            }

            finally
            {
                oConexion.Close();
            }
        }

        public void Modificar_Internacional(Internacionales unInter)
        {
            SqlConnection oConexion = new SqlConnection(Conexion.STR);
            SqlCommand oComando = new SqlCommand("Modificar_ViajeInternacional", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            oComando.Parameters.AddWithValue("@numero", unInter.Numero);
            oComando.Parameters.AddWithValue("@compania", unInter.Compania.Nombre);
            oComando.Parameters.AddWithValue("@destino", unInter.Terminal.Codigo);
            oComando.Parameters.AddWithValue("@fecha_partida", unInter.Fecha_partida);
            oComando.Parameters.AddWithValue("@fecha_arribo", unInter.Fecha_arribo);
            oComando.Parameters.AddWithValue("@asientos", unInter.Asientos);
            oComando.Parameters.AddWithValue("@empleado", unInter.Empleado.Cedula);
            oComando.Parameters.AddWithValue("@servicio", unInter.Servicio);
            oComando.Parameters.AddWithValue("@documentacion", unInter.Documentacion);

            SqlParameter oRetorno = new SqlParameter("@Retorno", SqlDbType.Int);
            oRetorno.Direction = ParameterDirection.ReturnValue;
            oComando.Parameters.Add(oRetorno);

            try
            {
                oConexion.Open();

                oComando.ExecuteNonQuery();

                if (Convert.ToInt32(oRetorno.Value) == -1)
                {
                    throw new Exception("El número de viaje ingresado no existe en la base de datos");
                }
                if (Convert.ToInt32(oRetorno.Value) == -2)
                {
                    throw new Exception("Ya existe un viaje al destino indicado en ese horario. Los viajes al mismo destino deben tener un mínimo de 2 horas de diferencia entre ellos.");
                }
                if (Convert.ToInt32(oRetorno.Value) == -3)
                {
                    throw new Exception("La compañía ingresada no existe en la base de datos.");
                }
                if (Convert.ToInt32(oRetorno.Value) == -4)
                {
                    throw new Exception("La terminal ingresada no existe en la base de datos..");
                }
                if (Convert.ToInt32(oRetorno.Value) == -5)
                {
                    throw new Exception("El empleado logueado no existe en la base de datos.");
                }
                if (Convert.ToInt32(oRetorno.Value) == -6 || Convert.ToInt32(oRetorno.Value) == -7)
                {
                    throw new Exception("Se produjo un error al intentar modificar el viaje. Inténtelo nuevamente.");
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Problemas con la base de datos:" + ex.Message);
            }

            finally
            {
                oConexion.Close();
            }
        }

        public void Eliminar_Internacional(Internacionales unInter)
        {
            SqlConnection oConexion = new SqlConnection(Conexion.STR);
            SqlCommand oComando = new SqlCommand("Eliminar_ViajeInternacional", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            oComando.Parameters.AddWithValue("@numero", unInter.Numero);

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
                    throw new Exception("El viaje ingresado no existe en la base de datos");
                }
                if (oAfectados == -2 || oAfectados == -3)
                {
                    throw new Exception("Error al eliminar el viaje en la base de datos. Inténtelo nuevamente   ");
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Problemas con la base de datos:" + ex.Message);
            }

            finally
            {
                oConexion.Close();
            }
        }



        public List<Internacionales> Listar_Viajes_Int()
        {
            SqlConnection oConexion = new SqlConnection(Conexion.STR);
            SqlCommand oComando = new SqlCommand("Listar_Viajes_Internacionales", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;
            List<Internacionales> _Lista = new List<Internacionales>();

            try
            {
                oConexion.Open();
                SqlDataReader _Reader = oComando.ExecuteReader();
                while (_Reader.Read())
                {
                    int _numero = (int)_Reader["numero"];
                    Companias _compania = PersistenciaCompania.GetInstancia().Buscar_Compania((string)_Reader["compania"]);
                    Terminales _terminal = PersistenciaTerminales.GetInstancia().Buscar_Terminal((string)_Reader["destino"]);
                    DateTime _fechapartida = (DateTime)_Reader["fecha_partida"];
                    DateTime _fechaarribo = (DateTime)_Reader["fecha_arribo"];
                    int _asientos = (int)_Reader["asientos"];
                    Empleados _empleado = PersistenciaEmpleado.GetInstancia().Buscar_Empleado((string)_Reader["empleado"]);
                    bool _servicio = (bool)_Reader["servicio"];
                    string _documentacion = (string)_Reader["documentacion"];

                    Internacionales viaje = new Internacionales(_numero, _compania, _terminal, _fechapartida, _fechaarribo, _asientos, _empleado, _servicio, _documentacion);
                    _Lista.Add(viaje);
                }
                _Reader.Close();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }

            finally
            {
                oConexion.Close();
            }

            return _Lista;
        }
    }
}
