using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;
using Persistencia;

namespace Logica
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
        public void Alta_Terminal(Terminales Ter)
        {
            IPersistenciaTerminales FTerminal = FabricaPersistencia.getPersistenciaTerminal();

            FTerminal.Alta_Terminal(Ter);
        }

        public void Baja_Terminal(Terminales Ter)
        {
            IPersistenciaTerminales FTerminal = FabricaPersistencia.getPersistenciaTerminal();

            FTerminal.Baja_Terminal(Ter);
        }

        public void Modificar_Terminal(Terminales Ter)
        {
            IPersistenciaTerminales FTerminal = FabricaPersistencia.getPersistenciaTerminal();

            FTerminal.Modificar_Terminal(Ter);
        }
    }
}
