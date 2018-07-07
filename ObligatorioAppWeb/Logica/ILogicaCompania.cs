using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas

namespace Logica
{
    public interface ILogicaCompania
    {
        Companias Buscar(string pNombre);
        void Crear(Companias C);
        void Eliminar(Companias C);
        void Modificar(Companias C);
    }

}
