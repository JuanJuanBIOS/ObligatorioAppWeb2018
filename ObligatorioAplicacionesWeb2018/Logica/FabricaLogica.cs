using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Logica.Interfaces;

namespace Logica
{
    public class FabricaLogica
    {
        public static ILogicaEmpleado getLogicaEmpleado()
        {
            return (LogicaEmpleado.GetInstancia());
        }

        public static ILogicaCompania getLogicaCompania()
        {
            return (LogicaCompania.GetInstancia());
        }

        public static ILogicaTerminales getLogicaTerminal()
        {
            return (LogicaTerminales.GetInstancia());
        }

        public static ILogicaViajes getLogicaViaje()
        {
            return (LogicaViajes.GetInstancia());
        }
    }
}
