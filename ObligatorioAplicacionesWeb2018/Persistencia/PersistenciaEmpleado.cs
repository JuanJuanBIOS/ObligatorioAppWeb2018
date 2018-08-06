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
    internal class PersistenciaEmpleado : IPersistenciaEmpleado
    {
        //Singleton
        private static PersistenciaEmpleado _instancia = null;

        private PersistenciaEmpleado() { }

        public static PersistenciaEmpleado GetInstancia()
        {
            if (_instancia == null)
            {
                _instancia = new PersistenciaEmpleado();
            }

            return _instancia;
        }


        //Operaciones
        public Empleados Login(string pCed, string pPass)
        {
            Empleados unEmp = null;

            SqlConnection oConexion = new SqlConnection(Conexion.STR);
            SqlCommand oComando = new SqlCommand("Login_Empleado", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            oComando.Parameters.AddWithValue("@cedula", pCed);
            oComando.Parameters.AddWithValue("@pass", pPass);

            try
            {
                oConexion.Open();
                SqlDataReader oReader = oComando.ExecuteReader();

                if (oReader.HasRows)
                {
                    oReader.Read();

                    string _cedula = (string)oReader["cedula"];
                    string _pass = (string)oReader["pass"];
                    string _nombre = (string)oReader["nombre"];

                    oReader.Close();

                    unEmp = new Empleados(_cedula, _pass, _nombre);
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

            return unEmp;
        }



        public Empleados Buscar_Empleado(string pCedula)
        {
            SqlConnection oConexion = new SqlConnection(Conexion.STR);
            SqlCommand oComando = new SqlCommand("Buscar_Empleado", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            oComando.Parameters.AddWithValue("@cedula", pCedula);

            Empleados unEmp = null;

            try
            {
                oConexion.Open();

                SqlDataReader _Reader = oComando.ExecuteReader();

                if (_Reader.HasRows)
                {
                    _Reader.Read();

                    string _cedula = (string)_Reader["cedula"];
                    string _pass = (string)_Reader["pass"];
                    string _nombre = (string)_Reader["nombre"];

                    unEmp = new Empleados(_cedula, _pass, _nombre);

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

            return unEmp;
        }

        public Empleados BuscarTodos_Empleado(string pCedula)
        {
            SqlConnection oConexion = new SqlConnection(Conexion.STR);
            SqlCommand oComando = new SqlCommand("BuscarTodos_Empleado", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            oComando.Parameters.AddWithValue("@cedula", pCedula);

            Empleados unEmp = null;

            try
            {
                oConexion.Open();

                SqlDataReader _Reader = oComando.ExecuteReader();

                if (_Reader.HasRows)
                {
                    _Reader.Read();

                    string _cedula = (string)_Reader["cedula"];
                    string _pass = (string)_Reader["pass"];
                    string _nombre = (string)_Reader["nombre"];

                    unEmp = new Empleados(_cedula, _pass, _nombre);

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

            return unEmp;
        }


        public void Alta_Empleado(Empleados unEmp)
        {
            SqlConnection oConexion = new SqlConnection(Conexion.STR);
            SqlCommand oComando = new SqlCommand("Alta_Empleado", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            oComando.Parameters.AddWithValue("@cedula", unEmp.Cedula);
            oComando.Parameters.AddWithValue("@nombre", unEmp.Nombre);
            oComando.Parameters.AddWithValue("@pass", unEmp.Pass);

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
                    throw new Exception("Ya existe el Empleado con la cedula ingresada");
                }
                else if (oAfectados == -2)
                {
                    throw new Exception("Error en la base de datos");
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
            finally
            {
                oConexion.Close();
            }
        }

        //Modificar
        public void Modificar_Empleado(Empleados unEmp)
        {
            SqlConnection oConexion = new SqlConnection(Conexion.STR);
            SqlCommand oComando = new SqlCommand("Modificar_Empleado", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            oComando.Parameters.AddWithValue("@cedula", unEmp.Cedula);
            oComando.Parameters.AddWithValue("@nombre", unEmp.Nombre);
            oComando.Parameters.AddWithValue("@pass", unEmp.Pass);

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
                    throw new Exception("No existe Empleado con la cedula ingresada");
                }
                else if (oAfectados == -2)
                {
                    throw new Exception("Error en la base de datos");
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
            finally
            {
                oConexion.Close();
            }
        }

        //Eliminar
        public void Eliminar_Empleado(Empleados unEmp)
        {
            SqlConnection oConexion = new SqlConnection(Conexion.STR);
            SqlCommand oComando = new SqlCommand("Eliminar_Empleado", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            oComando.Parameters.AddWithValue("@cedula", unEmp.Cedula);

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
                    throw new Exception("El Empleado no existe en la base de datos");
                }
                else if (oAfectados == -2)
                {
                    throw new Exception("Error al eliminar el empleado de la base de datos");
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
            finally
            {
                oConexion.Close();
            }
        }





    }
}
