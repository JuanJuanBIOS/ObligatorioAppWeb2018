using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;
using Logica.Interfaces;
using Persistencia.Interfaces;
using Persistencia;

namespace Logica.Interfaces
{
    internal class LogicaTerminales : ILogicaTerminales
    {
        //Singleton
        private static LogicaTerminales _instancia = null;
        private LogicaTerminales() { }

        public static LogicaTerminales GetInstancia()
        {
            if (_instancia == null)
            {
                _instancia = new LogicaTerminales();
            }

            return _instancia;
        }


        //Operaciones
        public Terminales Buscar_Terminal(string pCodTerminal)
        {
            IPersistenciaTerminales FTerminal = FabricaPersistencia.getPersistenciaTerminal();

            return FTerminal.Buscar_Terminal(pCodTerminal);
        }

        public void Alta_Terminal(Terminales Ter)
        {
            IPersistenciaTerminales FTerminal = FabricaPersistencia.getPersistenciaTerminal();

            FTerminal.Alta_Terminal(Ter);
        }

        public void Eliminar_Terminal(Terminales Ter)
        {
            IPersistenciaTerminales FTerminal = FabricaPersistencia.getPersistenciaTerminal();

            FTerminal.Eliminar_Terminal(Ter);
        }

        public void Modificar_Terminal(Terminales Ter)
        {
            IPersistenciaTerminales FTerminal = FabricaPersistencia.getPersistenciaTerminal();

            FTerminal.Modificar_Terminal(Ter);
        }

        public List<Terminales> Listar_Terminales()
        {
            IPersistenciaTerminales FTerminal = FabricaPersistencia.getPersistenciaTerminal();

            return FTerminal.Listar_Terminales();
        }

        public List<Terminales> Listar_Todos_Terminales()
        {
            IPersistenciaTerminales FTerminal = FabricaPersistencia.getPersistenciaTerminal();

            return FTerminal.Listar_Todos_Terminales();
        }
    }
}
