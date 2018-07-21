using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;

namespace Persistencia.Interfaces
{
    public interface IPersistenciaNacionales
    {
        Nacionales Buscar_Viaje(int pCodViaje);
    }
}
