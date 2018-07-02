using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;
using Persistencia;

namespace Logica
{
    internal class LogicaEmpleado : ILogicaEmpleado
    {
        //Singleton
        private static LogicaEmpleado _instancia = null;
        private LogicaEmpleado() { }

        public static LogicaEmpleado GetInstancia()
        {
            if (_instancia == null)
            {
                _instancia = new LogicaEmpleado();
            }

            return _instancia;
        }


        //Operaciones
        public Empleados Login(string pCed, string pPass)
        {
            IPersistenciaEmpleado FEmpleado = FabricaPersistencia.getPersistenciaEmpleado();

            Empleados E = FEmpleado.Login(pCed, pPass);

            return E;
        }
    }
}
