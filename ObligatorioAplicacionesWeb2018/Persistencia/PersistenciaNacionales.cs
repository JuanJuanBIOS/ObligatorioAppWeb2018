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
    internal class PersistenciaNacionales : IPersistenciaNacionales
    {
        //Singleton
        private static PersistenciaNacionales _instancia = null;

        private PersistenciaNacionales() { }

        public static PersistenciaNacionales GetInstancia()
        {
            if (_instancia == null)
            {
                _instancia = new PersistenciaNacionales();
            }

            return _instancia;
        }


        //Operaciones
        public Nacionales Buscar_Viaje(int pCodViaje)
        {
            SqlConnection oConexion = new SqlConnection(Conexion.STR);
            SqlCommand oComando = new SqlCommand("Buscar_ViajeNacional", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            oComando.Parameters.AddWithValue("@numero", pCodViaje);

            Nacionales unNac = null;

            try
            {
                oConexion.Open();

                SqlDataReader _Reader = oComando.ExecuteReader();

                if (_Reader.HasRows)
                {
                    _Reader.Read();

                    int _numero = (int)_Reader["numero"];
                    Companias _compania = PersistenciaCompania.GetInstancia().BuscarTodos_Compania((string)_Reader["compania"]);
                    Terminales _terminal = PersistenciaTerminales.GetInstancia().BuscarTodos_Terminal((string)_Reader["destino"]);
                    DateTime _fechapartida = (DateTime)_Reader["fecha_partida"];
                    DateTime _fechaarribo = (DateTime)_Reader["fecha_arribo"];
                    int _asientos = (int)_Reader["asientos"];
                    Empleados _empleado = PersistenciaEmpleado.GetInstancia().BuscarTodos_Empleado((string)_Reader["empleado"]);
                    int _paradas = (int)_Reader["paradas"];

                    unNac = new Nacionales(_numero, _compania, _terminal, _fechapartida, _fechaarribo, _asientos, _empleado, _paradas);

                    _Reader.Close();
                }
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

            return unNac;
        }

        public void Alta_Nacional(Nacionales unNac)
        {
            SqlConnection oConexion = new SqlConnection(Conexion.STR);
            SqlCommand oComando = new SqlCommand("Alta_ViajeNacional", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            oComando.Parameters.AddWithValue("@numero", unNac.Numero);
            oComando.Parameters.AddWithValue("@compania", unNac.Compania.Nombre);
            oComando.Parameters.AddWithValue("@destino", unNac.Terminal.Codigo);
            oComando.Parameters.AddWithValue("@fecha_partida", unNac.Fecha_partida);
            oComando.Parameters.AddWithValue("@fecha_arribo", unNac.Fecha_arribo);
            oComando.Parameters.AddWithValue("@asientos", unNac.Asientos);
            oComando.Parameters.AddWithValue("@empleado", unNac.Empleado.Cedula);
            oComando.Parameters.AddWithValue("@paradas", unNac.Paradas);

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
                    throw new Exception("La compañía ingresada no existe en la base de datos o está dada de baja.");
                }
                if (Convert.ToInt32(oRetorno.Value) == -4)
                {
                    throw new Exception("La terminal ingresada no existe en la base de datos o está dada de baja.");
                }
                if (Convert.ToInt32(oRetorno.Value) == -5)
                {
                    throw new Exception("El empleado logueado no existe en la base de datos o está dado de baja.");
                }
                if (Convert.ToInt32(oRetorno.Value) == -6 || Convert.ToInt32(oRetorno.Value) == -7)
                {
                    throw new Exception("Se produjo un error al intentar dar de alta el viaje. Inténtelo nuevamente.");
                }
            }

            catch (SqlException)
            {
                throw new Exception("La base de datos no se encuantra disponible. Contacte al administrador.");
            }

            catch (Exception ex)
            {
                throw new Exception("Problemas con la base de datos: " + ex.Message);
            }

            finally
            {
                oConexion.Close();
            }
        }

        public void Modificar_Nacional(Nacionales unNac)
        {
            SqlConnection oConexion = new SqlConnection(Conexion.STR);
            SqlCommand oComando = new SqlCommand("Modificar_ViajeNacional", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            oComando.Parameters.AddWithValue("@numero", unNac.Numero);
            oComando.Parameters.AddWithValue("@compania", unNac.Compania.Nombre);
            oComando.Parameters.AddWithValue("@destino", unNac.Terminal.Codigo);
            oComando.Parameters.AddWithValue("@fecha_partida", unNac.Fecha_partida);
            oComando.Parameters.AddWithValue("@fecha_arribo", unNac.Fecha_arribo);
            oComando.Parameters.AddWithValue("@asientos", unNac.Asientos);
            oComando.Parameters.AddWithValue("@empleado", unNac.Empleado.Cedula);
            oComando.Parameters.AddWithValue("@paradas", unNac.Paradas);

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
                    throw new Exception("La compañía ingresada no existe en la base de datos o está dada de baja.");
                }
                if (Convert.ToInt32(oRetorno.Value) == -4)
                {
                    throw new Exception("La terminal ingresada no existe en la base de datos o está dada de baja.");
                }
                if (Convert.ToInt32(oRetorno.Value) == -5)
                {
                    throw new Exception("El empleado logueado no existe en la base de datos o está dado de baja.");
                }
                if (Convert.ToInt32(oRetorno.Value) == -6 || Convert.ToInt32(oRetorno.Value) == -7)
                {
                    throw new Exception("Se produjo un error al intentar modificar el viaje. Inténtelo nuevamente.");
                }
            }

            catch (SqlException)
            {
                throw new Exception("La base de datos no se encuantra disponible. Contacte al administrador.");
            }

            catch (Exception ex)
            {
                throw new Exception("Problemas con la base de datos: " + ex.Message);
            }

            finally
            {
                oConexion.Close();
            }
        }

        public void Eliminar_Nacional(Nacionales unNac)
        {
            SqlConnection oConexion = new SqlConnection(Conexion.STR);
            SqlCommand oComando = new SqlCommand("Eliminar_ViajeNacional", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            oComando.Parameters.AddWithValue("@numero", unNac.Numero);

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

            catch (SqlException)
            {
                throw new Exception("La base de datos no se encuantra disponible. Contacte al administrador.");
            }

            catch (Exception ex)
            {
                throw new Exception("Problemas con la base de datos: " + ex.Message);
            }

            finally
            {
                oConexion.Close();
            }
        }


        public List<Nacionales> Listar_Viajes_Nac()
        {
            SqlConnection oConexion = new SqlConnection(Conexion.STR);
            SqlCommand oComando = new SqlCommand("Listar_Viajes_Nacionales", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;
            List<Nacionales> _Lista = new List<Nacionales>();
            try
            {
                oConexion.Open();
                SqlDataReader _Reader = oComando.ExecuteReader();
                while (_Reader.Read())
                {
                    int _numero = (int)_Reader["numero"];
                    Companias _compania = PersistenciaCompania.GetInstancia().BuscarTodos_Compania((string)_Reader["compania"]);
                    Terminales _terminal = PersistenciaTerminales.GetInstancia().BuscarTodos_Terminal((string)_Reader["destino"]);
                    DateTime _fechapartida = (DateTime)_Reader["fecha_partida"];
                    DateTime _fechaarribo = (DateTime)_Reader["fecha_arribo"];
                    int _asientos = (int)_Reader["asientos"];
                    Empleados _empleado = PersistenciaEmpleado.GetInstancia().BuscarTodos_Empleado((string)_Reader["empleado"]);
                    int _paradas = (int)_Reader["paradas"];
                    Nacionales viaje = new Nacionales(_numero, _compania, _terminal, _fechapartida, _fechaarribo, _asientos, _empleado, _paradas);
                    _Lista.Add(viaje);
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
            return _Lista;
        }
    }
}
