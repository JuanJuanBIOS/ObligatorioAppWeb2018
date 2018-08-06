using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;
using Logica.Interfaces;
using Persistencia.Interfaces;
using Persistencia;

namespace Logica
{
    internal class LogicaCompania : ILogicaCompania
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
        public Companias Buscar_Compania(string pNombre)
        {
            IPersistenciaCompania FCompania = FabricaPersistencia.getPersistenciaCompania();

            Companias C = FCompania.Buscar_Compania(pNombre);

            return C;
        }

        public void Alta_Compania(Companias C)
        {
            IPersistenciaCompania FCompania = FabricaPersistencia.getPersistenciaCompania();

            FCompania.Alta_Compania(C);
        }

        public void Eliminar_Compania(Companias C)
        {
            IPersistenciaCompania FCompania = FabricaPersistencia.getPersistenciaCompania();

            FCompania.Eliminar_Compania(C);
        }

        public void Modificar_Compania(Companias C)
        {
            IPersistenciaCompania FCompania = FabricaPersistencia.getPersistenciaCompania();

            FCompania.Modificar_Compania(C);
        }

        public List<Companias> Listar_Companias()
        {
            IPersistenciaCompania FCompania = FabricaPersistencia.getPersistenciaCompania();

            return FCompania.Listar_Companias();
        }

        public List<Companias> Listar_Todos_Companias()
        {
            IPersistenciaCompania FCompania = FabricaPersistencia.getPersistenciaCompania();

            return FCompania.Listar_Todos_Companias();
        }
    }
}
