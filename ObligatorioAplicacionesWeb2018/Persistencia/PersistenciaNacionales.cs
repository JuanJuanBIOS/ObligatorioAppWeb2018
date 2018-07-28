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
                    Companias _compania = PersistenciaCompania.GetInstancia().Buscar_Compania((string)_Reader["compania"]);
                    Terminales _terminal = PersistenciaTerminales.GetInstancia().Buscar_Terminal((string)_Reader["destino"]);
                    DateTime _fechapartida = (DateTime)_Reader["fecha_partida"];
                    DateTime _fechaarribo = (DateTime)_Reader["fecha_arribo"];
                    int _asientos = (int)_Reader["asientos"];
                    Empleados _empleado = PersistenciaEmpleado.GetInstancia().Buscar_Empleado((string)_Reader["empleado"]);
                    int _paradas = (int)_Reader["paradas"];

                    unNac = new Nacionales(_numero, _compania, _terminal, _fechapartida, _fechaarribo, _asientos, _empleado, _paradas);

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

            return unNac;
        }

        public List<Nacionales> ListarViajeNac()
        {
            SqlConnection oConexion = new SqlConnection(Conexion.STR);
            SqlCommand oComando = new SqlCommand("ListarViajeNacional", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            List<Nacionales> _Lista = null;

            try
            {
                oConexion.Open();

                SqlDataReader _Reader = oComando.ExecuteReader();

                while (_Reader.Read())
                {
                    _Reader.Read();

                    int _numero = (int)_Reader["numero"];
                    Companias _compania = PersistenciaCompania.GetInstancia().Buscar_Compania((string)_Reader["compania"]);
                    Terminales _terminal = PersistenciaTerminales.GetInstancia().Buscar_Terminal((string)_Reader["destino"]);
                    DateTime _fechapartida = (DateTime)_Reader["fecha_partida"];
                    DateTime _fechaarribo = (DateTime)_Reader["fecha_arribo"];
                    int _asientos = (int)_Reader["asientos"];
                    Empleados _empleado = PersistenciaEmpleado.GetInstancia().Buscar_Empleado((string)_Reader["empleado"]);
                    int _paradas = (int)_Reader["paradas"];

                    Nacionales viaje = new Nacionales(_numero, _compania, _terminal, _fechapartida, _fechaarribo, _asientos, _empleado, _paradas);
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
