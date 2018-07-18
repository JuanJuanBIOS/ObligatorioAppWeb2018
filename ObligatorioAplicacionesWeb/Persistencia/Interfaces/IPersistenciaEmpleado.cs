using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;

namespace Persistencia.Interfaces
{
    public interface IPersistenciaEmpleado
    {
        Empleados Login(string pCedula, string pPass);
    }
}
