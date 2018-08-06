using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas; 

namespace Logica.Interfaces
{
    public interface ILogicaTerminales
    {
        Terminales Buscar_Terminal(string pCodTerminal);

        void Alta_Terminal(Terminales pTerminal);

        void Eliminar_Terminal(Terminales pTerminal);

        void Modificar_Terminal(Terminales pTerminal);

        List<Terminales> Listar_Terminales();

        List<Terminales> Listar_Todos_Terminales();
    }
}
