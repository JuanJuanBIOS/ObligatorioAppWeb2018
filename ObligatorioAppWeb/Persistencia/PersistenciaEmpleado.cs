using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;
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
            Empleados E = null;

            SqlConnection oConexion = new SqlConnection(Conexion.STR);
            SqlCommand oComando = new SqlCommand("Login_Empleado", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            SqlParameter _cedula = new SqlParameter("@cedula", pCed);
            SqlParameter _pass = new SqlParameter("@pass", pPass);
            

            //no me acuerdo si esto era para capturar los errores o teniamos que definir la variable tambien en el stored procedure
            SqlParameter _Retorno = new SqlParameter("@Retorno", SqlDbType.Int);
            _Retorno.Direction = ParameterDirection.ReturnValue;

            int oAfectados = -1;

            oComando.Parameters.Add(_cedula);
            oComando.Parameters.Add(_pass);

            try
            {
                oConexion.Open();
                oReader = oComando.ExecuteReader();
                if (oReader.Read())
                {
                    _codigo = (int)oReader["CodArt"];
                    _nombre = (string)oReader["NomArt"];
                    _precio = (decimal)oReader["PreArt"];
                    a = new Articulo(_codigo,_nombre,_precio);
                }
                oReader.Close();
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Problemas con la base de datos:" + ex.Message);
            }
            finally
            {
                oConexion.Close();
            }
            return a;
        }
       }
    }
}
