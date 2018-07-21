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

            oComando.Parameters.AddWithValue("@codigo", pCodViaje);

            Internacionales unInter = null;

            try
            {
                oConexion.Open();

                SqlDataReader _Reader = oComando.ExecuteReader();

                if (_Reader.HasRows)
                {
                    _Reader.Read();

                    int _numero = (int)_Reader["numero"];
                    Companias _compania = PersistenciaCompania.GetInstancia().Buscar_Compania(((Companias)_Reader["compania"]).Nombre);
                    Terminales _terminal = PersistenciaTerminales.GetInstancia().Buscar_Terminal(((Terminales)_Reader["destino"]).Codigo);
                    DateTime _fechapartida = (DateTime)_Reader["fecha_partida"];
                    DateTime _fechaarribo = (DateTime)_Reader["fecha_arribo"];
                    int _asientos = (int)_Reader["asientos"];
                    Empleados _empleado = PersistenciaEmpleado.GetInstancia().Buscar_Empleado(((Empleados)_Reader["empleado"]).Cedula);
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
    }
}
