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

        void Alta_Nacional(Nacionales pNacional);

        void Modificar_Nacional(Nacionales pNacional);

        void Eliminar_Nacional(Nacionales pNacional);

        List<Nacionales> Listar_Viajes_Nac();
    }
}
