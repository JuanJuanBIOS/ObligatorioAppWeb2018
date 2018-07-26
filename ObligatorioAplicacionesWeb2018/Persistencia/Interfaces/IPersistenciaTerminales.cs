using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;

namespace Persistencia.Interfaces
{
    public interface IPersistenciaTerminales
    {
        Terminales Buscar_Terminal(string pCodTerminal);

        void Alta_Terminal(Terminales pTemrinal);

        void Eliminar_Terminal(Terminales pTemrinal);

        void Modificar_Terminal(Terminales pTemrinal);

        List<Terminales> Listar_Terminales();
    }
}
