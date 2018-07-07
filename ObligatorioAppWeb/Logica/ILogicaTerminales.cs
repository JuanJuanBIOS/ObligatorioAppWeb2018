using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;

namespace Logica
{
    public interface ILogicaTerminales
    {
        void Alta_Terminal(Terminales pTerminal);

        void Baja_Terminal(Terminales pTerminal);

        void Modificar_Terminal(Terminales pTerminal);
    }
}
