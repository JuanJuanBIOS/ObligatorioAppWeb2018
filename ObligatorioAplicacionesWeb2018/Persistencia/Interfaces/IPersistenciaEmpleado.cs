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

        Empleados Buscar_Empleado(string pCedula);

        Empleados BuscarTodos_Empleado(string pCedula);

        void Alta_Empleado(Empleados E);

        void Eliminar_Empleado(Empleados E);

        void Modificar_Empleado(Empleados E);
    }
}
