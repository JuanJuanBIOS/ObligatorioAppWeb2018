using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;
using Persistencia;

namespace Logica
{
    internal class LogicaCompania:ILogicaCompania
    {
        //Singleton
        private static LogicaCompania _instancia = null;
        private LogicaCompania() { }

        public static LogicaCompania GetInstancia()
        {
            if (_instancia == null)
            {
                _instancia = new LogicaCompania();
            }

            return _instancia;
        }

        //Operaciones
        public Companias Buscar(string pNombre)
        {
            IPersistenciaCompania FCompania = FabricaPersistencia.getPersistenciaCompania();

            Companias C = FCompania.Buscar(pNombre);

            return C;
        }

        public void Crear(Companias C)
        {
            IPersistenciaCompania FCompania = FabricaPersistencia.getPersistenciaCompania();

            FCompania.Crear(C);

        }

        public void Eliminar(Companias C)
        {
            IPersistenciaCompania FCompania = FabricaPersistencia.getPersistenciaCompania();

            FCompania.Eliminar(C);

        }

        public void Modificar(Companias C)
        {
            IPersistenciaCompania FCompania = FabricaPersistencia.getPersistenciaCompania();

            FCompania.Modificar(C);

        }




    }
}
