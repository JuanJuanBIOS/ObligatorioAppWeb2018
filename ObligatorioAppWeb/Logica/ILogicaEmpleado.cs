using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;

namespace Logica
{
    public interface ILogicaEmpleado
    {
        Empleados Login(string pCedula, string pPass);
    }
}
