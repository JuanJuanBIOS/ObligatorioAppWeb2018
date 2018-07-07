﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

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
    }
}
