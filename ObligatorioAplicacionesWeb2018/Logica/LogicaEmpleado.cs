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

        public Empleados Buscar_Empleado(string pCedula)
        {
            IPersistenciaEmpleado Fempleado = FabricaPersistencia.getPersistenciaEmpleado();

            Empleados E = Fempleado.Buscar_Empleado(pCedula);

            return E;
        }
    }
}
