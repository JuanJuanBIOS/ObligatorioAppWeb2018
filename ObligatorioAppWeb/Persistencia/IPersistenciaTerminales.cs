using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;

namespace Persistencia
{
    public interface IPersistenciaTerminales
    {
        void Alta_Terminal(Terminales pTemrinal);

        void Eliminar_Terminal(Terminales pTemrinal);

        void Modificar_Terminal(Terminales pTemrinal);
    }
}
