using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Persistencia.Interfaces;

namespace Persistencia
{
    public class FabricaPersistencia
    {
        public static IPersistenciaEmpleado getPersistenciaEmpleado()
        {
            return (PersistenciaEmpleado.GetInstancia());
        }
        public static IPersistenciaTerminales getPersistenciaTerminal()
        {
            return (PersistenciaTerminales.GetInstancia());
        }
        public static IPersistenciaCompania getPersistenciaCompania()
        {
            return (PersistenciaCompania.GetInstancia());
        }

    }
}
